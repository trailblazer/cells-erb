require 'test_helper'

class ErbTest < MiniTest::Spec
  let (:controller) { ApplicationController.new.tap { |ctl| ctl.send("request=", ActionDispatch::Request.new({})) } }
  let (:song_cell) { SongCell.new(controller) }


  # URL helpers work in cell instance.
  it { song_cell.songs_path.must_equal "/songs" }

  # content_tag { }
  it { song_cell.(:with_content_tag).must_equal "<div>Beachparty</div>" }

  # content_tag { content_tag { } }
  it do song_cell.(:with_content_tag_and_content_tag).must_equal %{<span>
    Title:
    <div>
        Still Knee Deep
</div></span>}
  end

  # form_tag { content_tag { } }
  it do
    form_tag = "<form action=\"/erubis/is/horribly/outdated\" accept-charset=\"UTF-8\" method=\"post\"><input name=\"utf8\" type=\"hidden\" value=\"&#x2713;\" />"
    form_tag = "<form accept-charset=\"UTF-8\" action=\"/erubis/is/horribly/outdated\" method=\"post\"><div style=\"margin:0;padding:0;display:inline\"><input name=\"utf8\" type=\"hidden\" value=\"&#x2713;\" /></div>" if ActionPack::VERSION::MAJOR == 3

    song_cell.(:with_form_tag_and_content_tag).must_equal %{Word.

#{form_tag}
  <a href=\"/rails/sucks\">
    hallo
</a>
  <ul>
   Hallo
</ul>
</form>


Weiter!

  Bonjour!
  <a href=\"/coffee\">Coffee?</a>
  <b>Yes please!</b>
  <script>oui!</script>



<a href=\"/1\">1</a>+<a href=\"/2\">2</a>

<b>No current page!<b>
<form url=\"/rails/escapes/too/much\" method=\"post\"><input name=\"utf8\" type=\"hidden\" value=\"&#x2713;\" />&lt;input type=&quot;button&quot;/&gt;</form>}
  end
end

# start with content_tag and block (or capture) and find out how sinatra handles that. goal is NOT to use those hacks in haml's action_view_extensions.
class SongCell < Cell::ViewModel
  self.view_paths = ["test/dummy/app/cells"]

  include ActionView::Helpers::FormHelper

  def with_form_tag_and_content_tag
    render
  end

  def with_content_tag_and_content_tag
    render
  end

  def with_content_tag
    render
  end

  def with_block
    render
  end

  def with_capture
    render
  end

  def with_form_tag
    form_tag("/songs") + content_tag(:span) + "</form>"
  end

  def with_link_to
    render
  end

  def with_form_for_block
    render
  end

  private
  def cap
    "yay, #{with_output_buffer { yield } }"
  end
end
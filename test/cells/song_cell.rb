class SongCell < Cell::ViewModelErb
  self.view_paths = ["test/cells"]

  def render_in_render
    render
  end
end

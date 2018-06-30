require "cells"
require "cell/erb/template"

module Cell
  module Erb
    def template_options_for(options)
      {
          template_class: ::Cell::Erb::Template,
          suffix: "erb"
      }
    end
  end
  class ViewModelErb < ViewModel
    include Cell::Erb
  end
end
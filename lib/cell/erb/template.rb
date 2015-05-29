require "erbse"

module Cell
  # Erb contains helpers that are messed up in Rails and do escaping.
  module Erb
    # this is capture copied from AV:::CaptureHelper without doing escaping.
    # TODO: re-implement capture and return content instead of the OB rubbish.
    def capture(*args)
      value = nil
      buffer = with_output_buffer { value = yield(*args) }
      if string = buffer.presence || value and string.is_a?(String)
        string
      end
    end

    def form_tag_with_body(html_options, content)
      "#{form_tag_html(html_options)}" << content.to_s << "</form>"
    end

    def form_tag_html(html_options)
      extra_tags = extra_tags_for_form(html_options)
      "#{tag(:form, html_options, true) + extra_tags}"
    end


    # Erbse-Tilt binding. This should be bundled with tilt. # 1.4. OR should be tilt-erbse.
    class Template < Tilt::Template
      def self.engine_initialized?
        defined? ::Erbse::Template
      end

      def initialize_engine
        require_template_library 'erbse'
      end

      # :engine_class can be passed via
      #
      #   Tilt.new("#{base}/#{prefix}/#{view}", engine_class: Erbse::Eruby)
      def prepare
        engine_class = options.delete(:engine_class)
        # engine_class = ::Erubis::EscapedEruby if options.delete(:escape_html)
        @template = (engine_class || ::Erbse::Template).new(data, options)
      end

      def precompiled_template(locals)
        @template.call
      end
    end
  end
end

Tilt.register Cell::Erb::Template, "erb"
Tilt.prefer Cell::Erb::Template
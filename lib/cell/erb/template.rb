require "erbse"

module Cell
  # Erb contains helpers that are messed up in Rails and do escaping.
  module Erb
    # This is to prevent multiple renders to share the same output_buffer.
    # I am still trying to find a way to avoid output buffers.
    def render_template(*)
      old_output_buffer = @output_buffer
      super
    ensure
      @output_buffer = old_output_buffer
    end

    def template_options_for(options)
      {
        template_class: ::Cell::Erb::Template,
        suffix:         "erb"
      }
    end

    # this is capture copied from AV:::CaptureHelper without doing escaping.
    def capture(*args)
      value = nil
      buffer = with_output_buffer { value = yield(*args) }

      return buffer.to_s if buffer.size > 0
      value # this applies for "Beachparty" string-only statements.
    end

    def with_output_buffer(block_buffer=ViewModel::OutputBuffer.new)
      @output_buffer, old_buffer = block_buffer, @output_buffer
      yield
      @output_buffer = old_buffer

      block_buffer
    end

    # Below:
    # Rails specific helper fixes. I hate that. I can't tell you how much I hate those helpers,
    # and their blind escaping for every possible string within the application.
    def content_tag(name, content_or_options_with_block=nil, options=nil, escape=false, &block)
      super
    end

    # We do statically set escape=true since attributes are double-quoted strings, so we have
    # to escape (default in Rails).
    def tag_options(options, escape = true)
      super(options, true)
    end

    def form_tag_with_body(html_options, content)
      "#{form_tag_html(html_options)}" << content.to_s << "</form>"
    end

    def form_tag_html(html_options)
      extra_tags = extra_tags_for_form(html_options)
      "#{tag(:form, html_options, true) + extra_tags}"
    end

    def concat(string)
      @output_buffer << string
    end


    # Erbse-Tilt binding. This should be bundled with tilt. # 1.4. OR should be tilt-erbse.
    class Template < Tilt::Template
      def self.engine_initialized?
        defined? ::Erbse::Template
      end

      def initialize_engine
        require_template_library 'erbse'
      end

      #   Tilt.new("#{base}/#{prefix}/#{view}", engine_class: Erbse::Eruby)
      def prepare
        @template = ::Erbse::Template.new(data, options)
      end

      def precompiled_template(locals)
         # puts "@@@@@ #{@template.().inspect}"
        @template.call
      end
    end
  end
end
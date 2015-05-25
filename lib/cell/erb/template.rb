require "erbse"

module Cell::Erb
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

Tilt.register Cell::Erb::Template, "erb"
# Tilt.prefer Cell::Erb::Template
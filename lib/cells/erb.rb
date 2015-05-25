require "erbse"

module Cell::Erb
  # Erbse-Tilt binding. This should be bundled with tilt. # 1.4.
  class Template < Tilt::Template
    def self.default_output_variable
      "_erbout"
    end

    def self.engine_initialized?
      defined? ::Erbse::Eruby
    end

    def initialize_engine
      require_template_library 'erbse'
    end

    # :engine_class can be passed via
    #
    #   Tilt.new("#{base}/#{prefix}/#{view}", engine_class: Erbse::Eruby)
    def prepare
      @outvar = options.delete(:outvar) || self.class.default_output_variable

      @options.merge!(:bufvar => @outvar)

      engine_class = options.delete(:engine_class)
      # engine_class = ::Erubis::EscapedEruby if options.delete(:escape_html)
      @engine = (engine_class || ::Erbse::Eruby).new(data, options)
    end

    def precompiled_template(locals)
      @engine.src
    end
  end
end
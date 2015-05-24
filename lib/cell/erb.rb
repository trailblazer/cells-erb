require 'cells'
require 'erubis/engine/eruby'
# require 'tilt/erubis'

# The original ERB implementation in Ruby doesn't support blocks like
#   <%= form_for do %>
# which is fixed with this monkey-patch.
#
# TODO: don't monkey-patch, use this in cells/tilt, only!

module Cell
  class Erubis < ::Erubis::Eruby
    # include ::Erubis::Converter # happens automatically.

    def add_preamble(src)
      puts "add_preamble called§§§§§§§§§§"
      @newline_pending = 0
      src << "@output_buffer = output_buffer || ActionView::OutputBuffer.new;"
    end

    def add_text(src, text)
      return if text.empty?

      if text == "\n"
        @newline_pending += 1
      else
        src << "@output_buffer.safe_append='"
        src << "\n" * @newline_pending if @newline_pending > 0
        src << escape_text(text)
        src << "'.freeze;"

        @newline_pending = 0
      end
    end

    # Erubis toggles <%= and <%== behavior when escaping is enabled.
    # We override to always treat <%== as escaped.
    def add_expr(src, code, indicator)
      case indicator
      when '=='
        add_expr_escaped(src, code)
      else
        super
      end
    end

    BLOCK_EXPR = /\s*((\s+|\))do|\{)(\s*\|[^|]*\|)?\s*\Z/

    def add_expr_literal(src, code)
      flush_newline_if_pending(src)
      if code =~ BLOCK_EXPR
        src << '@output_buffer.append= ' << code
      else
        src << '@output_buffer.append=(' << code << ');'
      end
    end

    def add_expr_escaped(src, code)
      flush_newline_if_pending(src)
      if code =~ BLOCK_EXPR
        src << "@output_buffer.safe_expr_append= " << code
      else
        src << "@output_buffer.safe_expr_append=(" << code << ");"
      end
    end

    def add_stmt(src, code)
      flush_newline_if_pending(src)
      super
    end

    def add_postamble(src)
      flush_newline_if_pending(src)
      src << '@output_buffer.to_s'
    end

    def flush_newline_if_pending(src)
      if @newline_pending > 0
        src << "@output_buffer.safe_append='#{"\n" * @newline_pending}'.freeze;"
        @newline_pending = 0
      end
    end
  end
end


# module Erubis
#   module RubyGenerator
#     def init_generator(properties={})
#       super
#       @in_block = 0
#       @block_ignore = 0
#     end

#     def escaped_expr(code)
#       return "#{@escapefunc} #{code}"
#     end

#     def add_stmt(src, code)
#       if block_start? code
#         block_ignore
#       elsif block_end? code
#         src << @bufvar << ?;
#         block_end
#       end

#       src << "#{code};"
#     end

#     def add_expr_literal(src, code)
#       if block_start? code
#         src << "#@bufvar << #{code};"
#         block_start
#         src << "#@bufvar = '';"
#       else
#         src << "#{@bufvar} << (#{code}).to_s;"
#       end
#     end

#     private

#     def block_start? code
#       res = code =~ /\b(do|\{)(\s*\|[^|]*\|)?\s*\Z/
#     end

#     def block_start
#       @in_block += 1
#       @bufvar << '_tmp'
#     end

#     def block_ignore
#       @block_ignore += 1
#     end

#     def block_end? code
#       res = @in_block != 0 && code =~ /\bend\b|}/
#       if res && @block_ignore != 0
#         @block_ignore -= 1
#         return false
#       end
#       res
#     end

#     def block_end
#       @in_block -= 1
#       @bufvar.sub! /_tmp\Z/, ''
#     end
#   end
# end

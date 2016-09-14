class ListBuilder < ActiveAdminAddons::CustomBuilder
  def render
    return if data.nil?
    raise "list must be Array" if !data.is_a?(Array)
    render_list(data)
  end

  def render_list(_data)
    _data.each do |value|
      # context.content_tag(:span) do
      # end
      context.concat(context.content_tag(:span, value))
    end
  end
end

module ::ActiveAdmin
  module Views
    class TableFor
      def listtag_column(*args, &block)
        column(*args) { |model| ::ListBuilder.new(self, model, *args, &block).render }
      end
    end
    class AttributesTable
      def listtag_row(*args, &block)
        row(*args) { |model| ::ListBuilder.new(self, model, *args, &block).render }
      end
    end
  end
end

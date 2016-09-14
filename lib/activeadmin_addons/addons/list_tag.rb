class ListBuilder < ActiveAdminAddons::CustomBuilder
  def render
    return if data.nil?
    raise "list must be Array" if !data.is_a?(Array)
    render_list(data)
  end

  def render_list(_data)
    context.content_tag(:div) do
      _data.each do |value|
        color = Digest::MD5.hexdigest(value)[0..5]
        context.concat(context.content_tag(:span, value, class: "status_tag tag", style: "background-color:##{color};"))
      end
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

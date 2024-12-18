module ActiveAdmin
  module Views
    class IndexAsReorderableTable < IndexAsTable

      def self.index_name
        'reorderable_table'
      end

      def build(page_presenter, collection)
        add_class "index-as-table"
        table_options = {
          id: "index_table_#{active_admin_config.resource_name.plural}",
          sortable: true,
          i18n: active_admin_config.resource_class,
          paginator: page_presenter[:paginator] != false,
          tbody_html: page_presenter[:tbody_html],
          row_html: page_presenter[:row_html],
          row_class: page_presenter[:row_class]
        }

        if page_presenter.block
          insert_tag(ReorderableTableFor, collection, table_options) do |t|
            instance_exec(t, &page_presenter.block)
          end
        else
          render "index_as_table_default", table_options: table_options
        end
      end

      def table_for(*args, &block)
        insert_tag ReorderableTableFor, *args, &block
      end

    end
  end
end

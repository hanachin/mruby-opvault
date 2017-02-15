class OPVault
  class Item
    class Overview
      include Enumerable

      def initialize(item, overview)
        @item = item
        @overview = overview
      end

      def each(&block)
        @overview.each(&block)
      end

      def [](key)
        @overview[key]
      end

      def title
        @overview['title'] || '(empty title)'
      end

      def ainfo
        @overview['ainfo']
      end

      def url
        @overview['url']
      end

      def urls
        @overview['URLs'] || []
      end

      def tags
        @overview['tags']
      end

      def ps
        @overview['ps']
      end

      def category
        @item.category
      end

      def category
        @item.created
      end

      def fave
        @item.fave
      end

      def folder
        @item.folder
      end

      def trashed
        @item.trashed
      end

      def tx
        @item.tx
      end

      def updated
        @item.updated
      end

      def uuid
        @item.uuid
      end

      def detail(master_keys, &block)
        @item.detail(master_keys, &block)
      end
    end
  end
end

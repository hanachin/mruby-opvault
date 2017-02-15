class OPVault
  class Item
    class Detail
      include Enumerable

      def initialize(item, detail)
        @item = item
        @detail = detail
      end

      def each(&block)
        @detail.each(&block)
      end

      def [](key)
        @detail[key]
      end

      def fields
        @detail['fields']
      end

      def html_form
        @detail['htmlForm']
      end

      def notes_plain
        @detail['notesPlain']
      end

      def password_history
        @detail['passwordHistory']
      end

      def sections
        @detail['sections']
      end
    end
  end
end

class OPVault
  class Profile
    class Band
      def initialize(opvault, profile, uuid_initial_letter)
        @data = BandLoader.new(opvault, profile).load(uuid_initial_letter)
      end

      def each_item
        @data.each do |_uuid, item|
          yield Item.new(item)
        end
      end
    end
  end
end

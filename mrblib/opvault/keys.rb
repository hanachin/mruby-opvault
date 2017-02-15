class OPVault
  class Keys
    attr_reader :encryption_key, :mac_key

    def initialize(keys)
      @encryption_key = keys[0...32]
      @mac_key = keys[32...64]
    end

    def inspect
      "#<OPVault::Keys:#{object_id}>"
    end
  end
end

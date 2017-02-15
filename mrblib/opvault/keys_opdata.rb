class OPVault
  class OPData; end

  class KeysOPData < OPData
    def decrypt(keys)
      new_keys = Keys.new(Digest::SHA512.digest(super))
      if block_given?
        yield new_keys
      else
        new_keys
      end
    end

    def inspect
      "#<OPVault::KeysOPData:#{object_id}>"
    end
  end
end

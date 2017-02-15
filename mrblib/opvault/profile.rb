class OPVault
  class Profile
    def initialize(opvault, name)
      @opvault = opvault
      @data = ProfileLoader.new(opvault).load(name)
    end

    def last_updated_by
      @data['lastUpdatedBy']
    end

    def updated_at
      @data['updatedAt']
    end

    def profile_name
      @data['profileName']
    end

    def salt
      Base64.decode(@data['salt'])
    end

    def password_hint
      @data['passwordHint']
    end

    def master_key
      master_key = Base64.decode(@data['masterKey'])
      KeysOPData.new(master_key)
    end

    def iterations
      @data['iterations']
    end

    def uuid
      @data['uuid']
    end

    def overview_key
      overview_key = Base64.decode(@data['overviewKey'])
      KeysOPData.new(overview_key)
    end

    def created_at
      @data['createdAt']
    end

    def items
      to_enum(:each_item).to_a
    end

    def each_item
      bands.each do |band|
        band.each_item do |item|
          yield item
        end
      end
    end

    def derive_keys(master_password)
      keys = PKCS5.pbkdf2_hmac(master_password, salt, iterations, 512/8, Digest::SHA512)
      keys = Keys.new(keys)
      if block_given?
        yield keys
      else
        keys
      end
    end

    def master_keys(derived_keys, &block)
      master_key.decrypt(derived_keys)
    end

    def overview_keys(derived_keys, &block)
      overview_key.decrypt(derived_keys)
    end

    private

    def bands
      (0...16).map do |n|
        Band.new(@opvault, self, n.to_s(16).upcase)
      end
    end
  end
end

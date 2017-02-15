class OPVault
  class ItemKeys
    def initialize(k)
      @k = k
    end

    def decrypt(master_keys)
      verify_hmac(master_keys.mac_key)

      data = decrypt_data(master_keys.encryption_key)

      unless data.size == 64
        raise "item key decrypt error"
      end

      keys = Keys.new(data)

      if block_given?
        yield keys
      else
        keys
      end
    end

    private

    def data
      @k[0...-32]
    end

    def iv
      @k[0...16]
    end

    def encrypted_data
      @k[16...-32]
    end

    def hmac
      @k[-32..-1]
    end

    def decrypt_data(encryption_key)
      cipher = setup_cipher(encryption_key)
      cipher.update(encrypted_data) + cipher.final
    end

    def setup_cipher(key)
      cipher = Cipher.new("AES-256-CBC")
      cipher.decrypt
      cipher.key = key
      cipher.iv = iv
      cipher.padding = 0
      cipher
    end

    def verify_hmac(mac_key)
      actual = Digest::HMAC.digest(data, mac_key, Digest::SHA256)
      return if hmac == actual
      raise "item key hmac doesn't match,"
    end
  end
end

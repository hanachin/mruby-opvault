class OPVault
  class OPData
    MAGIC_NUMBER = 'opdata01'

    def initialize(opdata)
      unless opdata[0...8] == MAGIC_NUMBER
        raise "opdata doesn't start_with #{MAGIC_NUMBER}: #{opdata[0...8]}"
      end
      @opdata = opdata
    end

    def decrypt(keys)
      verify_hmac(keys.mac_key)
      cipher = setup_cipher(keys.encryption_key)
      plain_text = cipher.update(encrypted_data) + cipher.final
      size = @opdata[8...16].unpack('Q<')[0]
      plain_text[-size..-1]
    end

    def inspect
      "#<OPVault::OPData:#{object_id}>"
    end

    private

    def iv
      @opdata[16...32]
    end

    def encrypted_data
      @opdata[32...-32]
    end

    def setup_cipher(key)
      cipher = Cipher.new('AES-256-CBC')
      cipher.decrypt
      cipher.key = key
      cipher.iv = iv
      cipher.padding = 0
      cipher
    end

    def mac_data
      @opdata[0...-32]
    end

    def hmac
      @opdata[-32..-1]
    end

    def verify_hmac(mac_key)
      return @opdata
      actual = Digest::HMAC.digest(mac_data, mac_key, Digest::SHA256)
      return if hmac == actual
      raise "opdata01 hmac doesn't match"
    end
  end
end

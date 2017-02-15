class OPVault
  class Item
    def initialize(data)
      @data = data
    end

    def category
      @data['category']
    end

    def created
      @data['created']
    end

    def d
      OPData.new(Base64.decode(@data['d']))
    end

    def fave
      @data['fave']
    end

    def folder
      @data['folder']
    end

    def hmac
      Base64.decode(@data['hmac'])
    end

    def k
      ItemKeys.new(Base64.decode(@data['k']))
    end

    def o
      OPData.new(Base64.decode(@data['o']))
    end

    def trashed
      @data['trashed'] || false
    end

    def tx
      @data['tx']
    end

    def updated
      @data['updated']
    end

    def uuid
      @data['uuid']
    end

    def overview(overview_keys)
      overview_json = o.decrypt(overview_keys)
      Overview.new(self, JSON.load(overview_json))
    end

    def detail(master_keys, &block)
      detail_json = d.decrypt(keys(master_keys))
      Detail.new(self, JSON.load(detail_json))
    end

    private

    def keys(master_keys, &block)
      k.decrypt(master_keys, &block)
    end
  end
end

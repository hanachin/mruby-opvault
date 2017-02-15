class OPVault
  class ProfileLoader
    def initialize(opvault)
      @opvault = opvault
    end

    def load(name)
      js = profile_js(name)
      json = profile_json(js)
      JSON.load(json)
    end

    private

    def profile_js_path(name)
      File.join(@opvault.path, name, 'profile.js')
    end

    def profile_js(name)
      File.read(profile_js_path(name))
    end

    def profile_json(js)
      js.sub!('var profile=', '')
      js[-1] = ''
      js
    end
  end
end

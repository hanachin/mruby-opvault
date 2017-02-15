class OPVault
  class Profile
    class BandLoader
      def initialize(opvault, profile)
        @opvault = opvault
        @profile = profile
      end

      def load(uuid_initial_letter)
        js = band_js(uuid_initial_letter)
        if js
          json = band_json(js)
          JSON.load(json)
        else
          []
        end
      end

      private

      def band_js_path(uuid_initial_letter)
        File.join(@opvault.path, @profile.profile_name, "band_#{uuid_initial_letter}.js")
      end

      def band_js(uuid_initial_letter)
        path = band_js_path(uuid_initial_letter)

        if File.exist?(path)
          File.read(path)
        end
      end

      def band_json(js)
        unless js[0, 3] == 'ld('
          raise "band js file invalid"
        end
        unless js[-2..-1] == ');'
          raise "band js file invalid"
        end
        js[3..-2]
      end
    end
  end
end

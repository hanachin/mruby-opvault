class OPVault
  DEFAULT_PROFILE_NAME = 'default'

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def profile(name = DEFAULT_PROFILE_NAME)
    Profile.new(self, name)
  end
end

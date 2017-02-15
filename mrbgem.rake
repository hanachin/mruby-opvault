MRuby::Gem::Specification.new('mruby-opvault') do |spec|
  spec.license = 'MIT'
  spec.author  = 'Seiei Miyagi'
  spec.summary = 'decrypt OPVault'
  spec.add_dependency 'mruby-enumerator', core: 'mruby-enumerator'
  spec.add_dependency 'mruby-struct', core: 'mruby-struct'
  spec.add_dependency 'mruby-digest'
  spec.add_dependency 'mruby-iijson'
  spec.add_dependency 'mruby-io'
  spec.add_dependency 'mruby-base64'
  spec.add_dependency 'mruby-pkcs5'
  spec.add_dependency 'mruby-cipher'
end

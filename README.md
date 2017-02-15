mruby-opvault   [![Build Status](https://travis-ci.org/hanachin/mruby-opvault.svg?branch=master)](https://travis-ci.org/hanachin/mruby-opvault)
====

decrypt OPVault

Installation
----

Add this line to build_config.rb

```ruby
MRuby::Build.new do |conf|
  conf.gem github: 'hanachin/mruby-opvault'
end
```

or add this line to your aplication's mrbgem.rake

```ruby
MRuby::Gem::Specification.new('your-mrbgem') do |spec|
  spec.add_dependency 'mruby-opvault', github: 'hanachin/mruby-opvault'
end
```

Usage
----

```ruby
master_password = 'freddy'
opvault = OPVault.new('./onepassword_data')
profile = opvault.profile

derived_keys  = profile.derive_keys(master_password)
master_keys   = profile.master_keys(derived_keys)
overview_keys = profile.overview_keys(derived_keys)

profile.items.each do |item|
  puts item.overview(overview_keys).title
  p item.detail(master_keys).fields
end
```

How to run test
----

    $ git clone https://github.com/hanachin/mruby-opvault.git
    $ cd mruby-opvault
    $ ./test.sh

License
----

MIT

def master_password
  'freddy'
end

def opvault_path
  File.expand_path('../onepassword_data', File.dirname(__FILE__))
end

assert('OPVault') do
  opvault = OPVault.new(opvault_path)
  assert_equal(opvault_path, opvault.path)
end

assert('OPVault::Profile') do
  opvault = OPVault.new(opvault_path)
  profile = opvault.profile
  assert_equal(1370323483, profile.updated_at)
  assert_equal('Dropbox', profile.last_updated_by)
  assert_equal('default', profile.profile_name)
  assert_kind_of(String, profile.salt)
  assert_equal(nil, profile.password_hint)
  assert_kind_of(OPVault::KeysOPData, profile.master_key)
  assert_equal(50000, profile.iterations)
  assert_equal('2B894A18997C4638BACC55F2D56A4890', profile.uuid)
  assert_kind_of(OPVault::KeysOPData, profile.overview_key)
  assert_equal(1373753414, profile.created_at)

  assert_equal(29, profile.items.size)

  derived_keys  = profile.derive_keys(master_password)
  master_keys   = profile.master_keys(derived_keys)
  overview_keys = profile.overview_keys(derived_keys)
  assert_kind_of(OPVault::Keys, derived_keys)
  assert_kind_of(OPVault::Keys, master_keys)
  assert_kind_of(OPVault::Keys, overview_keys)
end

assert('OPVault::Profile::Item') do
  opvault = OPVault.new(opvault_path)
  profile = opvault.profile

  derived_keys  = profile.derive_keys(master_password)
  master_keys   = profile.master_keys(derived_keys)
  overview_keys = profile.overview_keys(derived_keys)

  item = profile.items.sort_by {|i| i.overview(overview_keys).to_a.size + i.detail(master_keys).to_a.size }.last

  assert_equal('001', item.category)
  assert_equal(1325483952, item.created)
  assert_kind_of(OPVault::OPData, item.d)
  assert_equal(nil, item.fave)
  assert_equal(nil, item.folder)
  assert_kind_of(String, item.hmac)
  assert_kind_of(OPVault::ItemKeys, item.k)
  assert_kind_of(OPVault::OPData, item.o)
  assert_equal(false, item.trashed)
  assert_equal(1373753420, item.tx)
  assert_equal(1325483952, item.updated)
  assert_equal('F7883ADDE5944B349ABB5CBEC20F39BE', item.uuid)

  overview = item.overview(overview_keys)
  detail = item.detail(master_keys)

  assert_kind_of(OPVault::Item::Overview, overview)
  assert_kind_of(OPVault::Item::Detail, detail)

  assert_equal('MobileMe', overview.title)
  assert_kind_of(String, overview.ainfo)
  assert_kind_of(String, overview.url)
  assert_kind_of(Array, overview.urls)
  assert_kind_of(Array, overview.tags)
  assert_equal(66, overview.ps)

  assert_kind_of(Array, detail.fields)
  assert_kind_of(Array, detail.sections)
  assert_kind_of(String, detail.notes_plain)

  trash_item = profile.items.detect { |i| i.uuid == '0C4F27910A64488BB339AED63565D148' }
  trash_item_overview = trash_item.overview(overview_keys)
  assert_equal('(empty title)', trash_item_overview.title)
  assert_equal(nil, trash_item_overview['title'])
  assert_equal(true, trash_item.trashed)
end

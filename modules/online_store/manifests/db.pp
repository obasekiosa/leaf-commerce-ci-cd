class online_store::db {
  include online_store
  include mysql::server
  include online_store::params

  mysql::db { $online_store::params::db['user']:
    schema => $online_store::params::db['schema'],
    password => $online_store::params::db['password'],
  }
}

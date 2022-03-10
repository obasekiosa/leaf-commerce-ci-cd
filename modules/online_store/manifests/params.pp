class online_store::params {
  $keystore_file = "/etc/ssl/.keystore"

  $ssl_connector = {
    "port" => 8443,
    "protocol" => "HTTP/1.1",
    "SSLEnabled" => true,
    "maxThreads" => 150,
    "scheme" => "https",
    "secure" => "true",
    "keystoreField" => $keystore_file,
    "keystorePass" => "secret",
    "clientAuth" => false,
    "sslProtocol" => "SSLv3",
  }

  $db = {
    "user" => "store",
    "password" => "storesecret",
    "schema" => "store_schema",
    "driver" => "com.mysql.jdbc.Driver",
    "url" => "jdbc:mysql://192.168.33.10:3306/",
  }
}

file { '/etc/consul/svc-db-admin.json':
  ensure => present,
  mode   => '0644',
  owner  => 'root',
  group  => 'root',
  source => 'puppet:///nubis/files/consul-svc-db-admin.json',
}

file { '/etc/consul/svc-mysqld-exporter.json':
  ensure => present,
  mode   => '0644',
  owner  => 'root',
  group  => 'root',
  source => 'puppet:///nubis/files/consul-svc-mysqld-exporter.json',
}

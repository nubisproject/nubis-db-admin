$mysqld_exporter_version = '0.9.0'
$mysqld_exporter_url = "https://github.com/prometheus/mysqld_exporter/releases/download/v${mysqld_exporter_version}/mysqld_exporter-${mysqld_exporter_version}.linux-amd64.tar.gz"
notice ("Grabbing mysqld_exporter ${mysqld_exporter_version}")
staging::file { "mysqld_exporter.${mysqld_exporter_version}.tar.gz":
  source => $mysqld_exporter_url,
}->
staging::extract { "mysqld_exporter.${mysqld_exporter_version}.tar.gz":
  strip   => 1,
  target  => '/usr/local/bin',
  creates => '/usr/local/bin/mysqld_exporter',
}

file { '/etc/init.d/mysqld_exporter':
  ensure => present,
  mode   => '0755',
  owner  => 'root',
  group  => 'root',
  source => 'puppet:///nubis/files/mysqld_exporter.init',
}

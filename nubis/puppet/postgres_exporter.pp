$postgres_exporter_version = '0.4.6'

$postgres_exporter_url = "https://github.com/wrouesnel/postgres_exporter/releases/download/v${postgres_exporter_version}/postgres_exporter_v${postgres_exporter_version}_linux-amd64.tar.gz"
notice ("Grabbing postgres_exporter ${postgres_exporter_version}")
staging::file { "postgres_exporter.${postgres_exporter_version}.tar.gz":
  source => $postgres_exporter_url,
}
  -> staging::extract { "postgres_exporter.${postgres_exporter_version}.tar.gz":
  strip   => 1,
  target  => '/usr/local/bin',
  creates => '/usr/local/bin/postgres_exporter',
}

systemd::unit_file { 'postgres_exporter.service':
  source => 'puppet:///nubis/files/postgres_exporter.systemd',
}

include nubis_discovery

nubis::discovery::service { 'postgresql-metrics':
  tags     => [ 'metrics' ],
  http     => 'http://localhost:9187',
  port     => 9187,
  interval => '30s',
}

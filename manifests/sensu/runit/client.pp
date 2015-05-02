# Sensu client setup
class monitoring::sensu::runit::client {
  file{'/etc/service/sensu_client':
    ensure => directory,
  } ->

  file { '/etc/service/sensu_client/run':
    ensure => file,
    mode   => 'u+x',
    source => 'puppet:///modules/sensu_server/run_client',
    owner  => root,
    group  => root,
  }
}

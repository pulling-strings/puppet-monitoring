# Sensu server runit setup
class monitoring::sensu::runit {

  include monitoring::sensu::runit::client

  file{'/etc/service/rabbitmq':
    ensure => directory,
  } ->

  file { '/etc/service/rabbitmq/run':
    ensure => file,
    mode   => 'u+x',
    source => 'puppet:///modules/monitoring/run_rabbitmq',
    owner  => root,
    group  => root,
  }

  file{'/etc/service/sensu_server':
    ensure => directory,
  } ->

  file { '/etc/service/sensu_server/run':
    ensure => file,
    mode   => 'u+x',
    source => 'puppet:///modules/monitoring/run_server',
    owner  => root,
    group  => root,
  }

  file{'/etc/service/sensu_api':
    ensure => directory,
  } ->

  file { '/etc/service/sensu_api/run':
    ensure => file,
    mode   => 'u+x',
    source => 'puppet:///modules/monitoring/run_api',
    owner  => root,
    group  => root,
  }
}

# Setting up uchiwa
class monitoring::sensu::uchiwa {

  if($::virtual == 'docker') {
    $manage_service = false

    file{'/etc/service/uchiwa':
      ensure => directory,
    } ->

    file { '/etc/service/uchiwa/run':
      ensure => file,
      mode   => 'u+x',
      source => 'puppet:///modules/monitoring/run_uchiwa',
      owner  => root,
      group  => root,
    }

  } else {
    $manage_service = true
  }

  # Somehow private nic does not work so we access host
  class { '::uchiwa':
    manage_services     => $manage_service,
  }

}

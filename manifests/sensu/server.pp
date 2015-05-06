# Sets up a sensu server with a local client
class monitoring::sensu::server {

  include monitoring::sensu::deployment
  class {'monitoring::sensu::rabbit':} ~> Class['sensu']

  if($::virtual == 'docker'){
    include monitoring::sensu::runit
    $manage = false
  } else {
    $manage = true
    Service['rabbitmq-server'] ~> Service['sensu-client']
    Service['rabbitmq-server'] ~> Service['sensu-server']
    Service['rabbitmq-server'] ~> Service['sensu-api']
    Service['redis-server'] ~> Service['sensu-server']
    Service['redis-server'] ~> Service['sensu-api']
  }

  class {'redis':
    append         => true,
    manage_service => $manage
  }

  redis::bind {'no bindings at all':
    unbind => true
  }

  $ruby = ['rubygems1.9.1','ruby1.9.1-dev', 'build-essential']

  ensure_resource('package', $ruby , {'ensure' => 'present'})

  class { 'sensu':
    server               => true,
    api                  => true,
    rabbitmq_vhost       => '/sensu',
    sensu_plugin_version => 'latest',
    manage_services      => $manage,
    require              => Package[$ruby]
  }
  
}

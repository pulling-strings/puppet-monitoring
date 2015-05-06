# Setting up sensu client
class monitoring::sensu::client {
  
  include monitoring::sensu::plugins

  $ruby = ['rubygems1.9.1','ruby1.9.1-dev', 'build-essential']

  if($::virtual == 'docker'){
    $manage = false
    include monitoring::sensu::runit::client
  } else {
    $manage = true
  }

  class { 'sensu':
    rabbitmq_vhost       => '/sensu',
    sensu_plugin_version => 'latest',
    require              => Package[$ruby],
    manage_services      => $manage,
  }
}

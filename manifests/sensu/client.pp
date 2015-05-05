# Setting up sensu client
class monitoring::sensu::client {
  
  include monitoring::sensu::plugins

  $ruby = ['rubygems1.9.1','ruby1.9.1-dev', 'build-essential']

  class { 'sensu':
    rabbitmq_vhost       => '/sensu',
    sensu_plugin_version => 'latest',
    require              => Package[$ruby]
  }
}

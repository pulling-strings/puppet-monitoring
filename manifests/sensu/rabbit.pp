# Sets up rabbitmq for sensu-server
class monitoring::sensu::rabbit(
  $user = 'sensu',
  $password = 'secret',
  $vhost = '/sensu'
){

  
  if($::virtual == 'docker'){
    class { 'rabbitmq::server':
      port              => '5672',
      delete_guest_user => false,
      config            => template('monitoring/rabbitmq.config.erb'),
      service_ensure    => 'stopped',
    }
  } else {
    class { 'rabbitmq::server':
      port              => '5672',
      delete_guest_user => true,
    }

    rabbitmq_user { $user:
      admin    => true,
      password => $password,
      provider => 'rabbitmqctl',
    }

    rabbitmq_plugin {'rabbitmq_management':
      ensure   => present,
      provider => 'rabbitmqplugins',
      require  => Package['rabbitmq-server']
    }

    rabbitmq_vhost { $vhost:
      ensure   => present,
      provider => 'rabbitmqctl',
      require  => Package['rabbitmq-server']
    }

    rabbitmq_user_permissions { "${user}@${vhost}":
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
      provider             => 'rabbitmqctl',
      require              => Rabbitmq_user['sensu']
    }
  }
}

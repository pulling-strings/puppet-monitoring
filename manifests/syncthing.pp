# Setting up syncthing local monitoring
class monitor::syncthing(
  $token='',
  $url='https://localhost:8080',
) {
  
  sensu::check {'syncthing-status':
    command => "${monitor::narkisr_plug_path}/check-status.rb -u ${url} -t ${token}"
  }

  sensu::check {'syncthing-errors':
    command => "${monitor::narkisr_plug_path}/check-errors.rb -u ${url} -t ${token}"
  }
}

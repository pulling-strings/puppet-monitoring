# Setting up syncthing local monitoring
class monitoring::syncthing(
  $token='',
  $url='https://localhost:8080',
) {
  
  sensu::check {'syncthing-status':
    command => "${monitor::narkisr_plug_path}/plugins/check-status.rb -u ${url} -t ${token}"
  }

  sensu::check {'syncthing-errors':
    command => "${monitor::narkisr_plug_path}/plugins/check-errors.rb -u ${url} -t ${token}"
  }
}

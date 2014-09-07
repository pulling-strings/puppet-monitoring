# Setting up syncthing local monitoring
class monitoring::syncthing(
  $token='',
  $url='https://localhost:8080',
) {

  $exec = "BUNDLE_GEMFILE=${::monitoring::narkisr_plug_path}/Gemfile /usr/local/bin/bundle exec"

  sensu::check {'syncthing-status':
    command => "${exec} ${::monitoring::narkisr_plug_path}/plugins/syncthing/check-status.rb -u ${url} -t ${token}"
  }

  sensu::check {'syncthing-errors':
    command => "${exec} ${::monitoring::narkisr_plug_path}/plugins/syncthing/check-errors.rb -u ${url} -t ${token}"
  }
}

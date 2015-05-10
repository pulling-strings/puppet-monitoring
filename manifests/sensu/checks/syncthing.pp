# Synching checks
class monitoring::sensu::checks::syncthing {
  
  $community = "${::monitoring::sensu::plugins::base}/${::monitoring::sensu::plugins::community}"
  $custom    = "${::monitoring::sensu::plugins::base}/${::monitoring::sensu::plugins::custom}"

  sensu::check {'syncthing-status':
    command => "${exec} ${custom}/plugins/syncthing/check-status.rb -u ${url} -t ${token}"
  }

  sensu::check {'syncthing-errors':
    command => "${exec} ${custom}/plugins/syncthing/check-errors.rb -u ${url} -t ${token}"
  }
}

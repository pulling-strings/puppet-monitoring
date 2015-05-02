# common checks
class monitoring::sensu::checks {

  $community = "${::monitoring::sensu::plugins::base}/${::monitoring::sensu::plugins::community}"
  $custom    = "${::monitoring::sensu::plugins::base}/${::monitoring::sensu::plugins::custom}"

  sensu::check { 'diskspace':
    command     => "${community}/plugins/system/check-disk.rb",
    subscribers => ['system'],
    standalone  => false
  }

  sensu::check { 'dropbox':
    command     => "${custom}/plugins/system/check-status.rb",
    subscribers => ['dropbox'],
    standalone  => false
  }
}

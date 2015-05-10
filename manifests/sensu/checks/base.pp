# common checks
class monitoring::sensu::checks::base(
  $token='',
  $url='https://localhost:8080',
){

  $community = "${::monitoring::sensu::plugins::base}/${::monitoring::sensu::plugins::community}"
  $custom    = "${::monitoring::sensu::plugins::base}/${::monitoring::sensu::plugins::custom}"

  sensu::check { 'diskspace':
    command     => "${community}/plugins/system/check-disk.rb",
    subscribers => ['system'],
    standalone  => false
  }

  sensu::check { 'dropbox':
    command     => "${custom}/plugins/dropbox/check-status.rb",
    subscribers => ['dropbox'],
    standalone  => false
  }

  $exec = "BUNDLE_GEMFILE=${custom}/Gemfile /usr/local/bin/bundle exec"

}

# Capistrano based deployment settings
class monitoring::sensu::deployment {

  $cap = '/u/apps/sensu'

  file{['/u', '/u/apps/',$cap, "${cap}/releases/"]:
    ensure  => directory,
    require => Package['sensu'],
    owner   => hiera('user'),
    group   => hiera('user')
  }

  package{'unzip':
    ensure  => present
  }
}

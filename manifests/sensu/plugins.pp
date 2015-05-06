# Setting up plugins
class monitoring::sensu::plugins(
  $base = '/opt',
  $community  = 'community-plugins',
  $custom = 'custom-plugins',
  $owner = 'sensu'
){

  include git

  $ruby = ['rubygems1.9.1','ruby1.9.1-dev', 'build-essential']

  ensure_resource('package', $ruby , {'ensure' => 'present'})

  User['sensu'] ->

  git::clone {'narkisr-plugins':
      url   => 'git://github.com/narkisr/sensu-narkisr-plugins.git',
      dst   => "${base}/${custom}",
      owner => $owner
  } ->

  git::clone {'community-plugins':
      url   => 'git://github.com/sensu/sensu-community-plugins.git',
      dst   => "${base}/${community}",
      owner => $owner
  } ->

  package{'net-ping':
    ensure   => present,
    provider => gem
  }

  package{'bundler':
    ensure   => present,
    provider => gem
  } ->

  exec{'install narkisr-sensu-plugins gems':
    command     => 'bundle install',
    environment => ["BUNDLE_GEMFILE=${base}/${custom}/Gemfile"],
    user        => 'root',
    timeout     => 600,
    path        => ['/usr/bin','/bin','/usr/local/bin'],
    require     => [Git::Clone['narkisr-plugins'],
                    Package['ruby1.9.1-dev', 'build-essential']]
  }


}

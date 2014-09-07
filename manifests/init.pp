# General motnitoring setup
class monitoring(
  $narkisr_plug_path = '/opt/sensu-narkisr-plugins',
  $community_plug_path = '/opt/sensu-community-plugins',
){
  package{['ruby1.9.1-dev', 'build-essential']:
    ensure  => present
  } -> Class['sensu']

  include sensu

  package{'bundler':
    ensure   => present,
    provider => gem
  } ->

  exec{'install narkisr-sensu-plugins gems':
    command     => 'bundle install',
    environment => ["BUNDLE_GEMFILE=${narkisr_plug_path}/Gemfile"],
    user        => 'root',
    timeout     => 600,
    path        => ['/usr/bin','/bin','/usr/local/bin'],
    require     => [Git::Clone[$narkisr_plug_path],
                    Package['ruby1.9.1-dev', 'build-essential']]
  }

  git::clone{$narkisr_plug_path:
    url   => 'git://github.com/narkisr/sensu-narkisr-plugins.git',
    dst   => $narkisr_plug_path,
    owner => 'root'
  } -> Sensu::Check<||>

  git::clone{$community_plug_path:
    url   => 'git://github.com/sensu/sensu-community-plugins.git',
    dst   => $community_plug_path,
    owner => 'root'
  } -> Sensu::Check<||>


}

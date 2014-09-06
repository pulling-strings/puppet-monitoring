# General motnitoring setup
class monitoring(
  $narkisr_plug_path = '/opt/sensu-narkisr-plugins/',
  $community_plug_path = '/opt/sensu-community-plugins/',
){
  package{['ruby1.9.1-dev', 'build-essential']:
    ensure  => present
  } -> Class['sensu']

  include sensu

  git::clone{$narkisr_plug_path:
    url   => 'git://github.com/narkisr/sensu-narkisr-plugins.git',
    dst   => $narkisr_plug_path,
    owner => 'root'
  } -> Sensu::Check<||>

  git::clone{$community_plug_path:
    url   => 'git://github.com/narkisr/sensu-narkisr-plugins.git',
    dst   => $community_plug_path,
    owner => 'root'
  } -> Sensu::Check<||>


}

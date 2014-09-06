# General motnitoring setup
class monitoring(
  $narkisr_plug_path = '/opt/sensu-narkisr-plugins/plugins/syncthing/',
){
  include sensu

  git::clone{$::plug_path:
    url => 'git://github.com/narkisr/sensu-narkisr-plugins.git'
  } -> Sensu::Check<||>

}

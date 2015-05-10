# Serverspec monitoring
class monitoring::serverspec(
  $name = '',
  $repo ='',
  $dst  ="/opt",
  $specs = ''
){

  git::clone{$name:
    url   => $repo,
    dst   => $dst,
    owner => 'root'
  }

  $exec = "LOCAL=true BUNDLE_GEMFILE=${::monitoring::community_plug_path}/Gemfile"

  sensu::check {"${name}-sensu-serverspec":
    command => "${exec} ${::monitoring::community_plug_path}/plugins/serverspec/check-serverspec.rb ${url} -d ${dst} -t spec/${specs}"
  }
}

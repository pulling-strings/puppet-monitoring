# Setting up collectd
class monitoring::collectd(
  $host = false
){
  validat_strings($host)

  include collectd

  collectd::plugin::network::server{$host:
    port => '25826'
  }

  class { 'collectd::plugin::cpu': }
  class { 'collectd::plugin::memory': }
  class { 'collectd::plugin::syslog':
    log_level => 'warning'
  }

}

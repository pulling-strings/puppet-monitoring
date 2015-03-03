# Setting up collectd
class monitoring::collectd(
  $host = false
){
  validate_string($host)

  class{'::collectd':}

  collectd::plugin::network::server{$host:
    port => '25826'
  }

  class { 'collectd::plugin::write_graphite':
    graphitehost => $host,
    graphiteport => '2003'
  }

  class { 'collectd::plugin::cpu': }
  class { 'collectd::plugin::memory': }
  class { 'collectd::plugin::syslog':
    log_level => 'warning'
  }

}

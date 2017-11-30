#
class rabbitmq_legacy::install::rabbitmqadmin {

  if($rabbitmq_legacy::ssl and $rabbitmq_legacy::management_ssl) {
    $management_port = $rabbitmq_legacy::ssl_management_port
    $protocol        = 'https'
  } else {
    $management_port = $rabbitmq_legacy::management_port
    $protocol        = 'http'
  }

  $default_user = $rabbitmq_legacy::default_user
  $default_pass = $rabbitmq_legacy::default_pass
  $node_ip_address = $rabbitmq_legacy::node_ip_address

  if $rabbitmq_legacy::node_ip_address == 'UNSET' {
    # Pull from localhost if we don't have an explicit bind address
    $curl_prefix = ''
    $sanitized_ip = '127.0.0.1'
  } elsif is_ipv6_address($node_ip_address) {
    $curl_prefix  = "--noproxy ${node_ip_address} -g -6"
    $sanitized_ip = join(enclose_ipv6(any2array($node_ip_address)), ',')
  } else {
    $curl_prefix  = "--noproxy ${node_ip_address}"
    $sanitized_ip = $node_ip_address
  }

  staging::file { 'rabbitmqadmin':
    target      => "${rabbitmq_legacy::rabbitmq_home}/rabbitmqadmin",
    source      => "${protocol}://${default_user}:${default_pass}@${sanitized_ip}:${management_port}/cli/rabbitmqadmin",
    curl_option => "-k ${curl_prefix} --retry 30 --retry-delay 6",
    timeout     => '180',
    wget_option => '--no-proxy',
    require     => [
      Class['rabbitmq_legacy::service'],
      Rabbitmq_plugin['rabbitmq_management']
    ],
  }

  file { '/usr/local/bin/rabbitmqadmin':
    owner   => 'root',
    group   => '0',
    source  => "${rabbitmq_legacy::rabbitmq_home}/rabbitmqadmin",
    mode    => '0755',
    require => Staging::File['rabbitmqadmin'],
  }

}

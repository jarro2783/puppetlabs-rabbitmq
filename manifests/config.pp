# Class: rabbitmq_legacy::config
# Sets all the configuration values for RabbitMQ and creates the directories for
# config and ssl.
class rabbitmq_legacy::config {

  $admin_enable               = $rabbitmq_legacy::admin_enable
  $cluster_node_type          = $rabbitmq_legacy::cluster_node_type
  $cluster_nodes              = $rabbitmq_legacy::cluster_nodes
  $config                     = $rabbitmq_legacy::config
  $config_cluster             = $rabbitmq_legacy::config_cluster
  $config_path                = $rabbitmq_legacy::config_path
  $config_stomp               = $rabbitmq_legacy::config_stomp
  $config_shovel              = $rabbitmq_legacy::config_shovel
  $config_shovel_statics      = $rabbitmq_legacy::config_shovel_statics
  $default_user               = $rabbitmq_legacy::default_user
  $default_pass               = $rabbitmq_legacy::default_pass
  $env_config                 = $rabbitmq_legacy::env_config
  $env_config_path            = $rabbitmq_legacy::env_config_path
  $erlang_cookie              = $rabbitmq_legacy::erlang_cookie
  $interface                  = $rabbitmq_legacy::interface
  $management_port            = $rabbitmq_legacy::management_port
  $management_ssl             = $rabbitmq_legacy::management_ssl
  $management_hostname        = $rabbitmq_legacy::management_hostname
  $node_ip_address            = $rabbitmq_legacy::node_ip_address
  $plugin_dir                 = $rabbitmq_legacy::plugin_dir
  $rabbitmq_user              = $rabbitmq_legacy::rabbitmq_user
  $rabbitmq_group             = $rabbitmq_legacy::rabbitmq_group
  $rabbitmq_home              = $rabbitmq_legacy::rabbitmq_home
  $port                       = $rabbitmq_legacy::port
  $tcp_keepalive              = $rabbitmq_legacy::tcp_keepalive
  $tcp_backlog                = $rabbitmq_legacy::tcp_backlog
  $tcp_sndbuf                 = $rabbitmq_legacy::tcp_sndbuf
  $tcp_recbuf                 = $rabbitmq_legacy::tcp_recbuf
  $heartbeat                  = $rabbitmq_legacy::heartbeat
  $service_name               = $rabbitmq_legacy::service_name
  $ssl                        = $rabbitmq_legacy::ssl
  $ssl_only                   = $rabbitmq_legacy::ssl_only
  $ssl_cacert                 = $rabbitmq_legacy::ssl_cacert
  $ssl_cert                   = $rabbitmq_legacy::ssl_cert
  $ssl_key                    = $rabbitmq_legacy::ssl_key
  $ssl_depth                  = $rabbitmq_legacy::ssl_depth
  $ssl_cert_password          = $rabbitmq_legacy::ssl_cert_password
  $ssl_port                   = $rabbitmq_legacy::ssl_port
  $ssl_interface              = $rabbitmq_legacy::ssl_interface
  $ssl_management_port        = $rabbitmq_legacy::ssl_management_port
  $ssl_stomp_port             = $rabbitmq_legacy::ssl_stomp_port
  $ssl_verify                 = $rabbitmq_legacy::ssl_verify
  $ssl_fail_if_no_peer_cert   = $rabbitmq_legacy::ssl_fail_if_no_peer_cert
  $ssl_versions               = $rabbitmq_legacy::ssl_versions
  $ssl_ciphers                = $rabbitmq_legacy::ssl_ciphers
  $stomp_port                 = $rabbitmq_legacy::stomp_port
  $stomp_ssl_only             = $rabbitmq_legacy::stomp_ssl_only
  $ldap_auth                  = $rabbitmq_legacy::ldap_auth
  $ldap_server                = $rabbitmq_legacy::ldap_server
  $ldap_user_dn_pattern       = $rabbitmq_legacy::ldap_user_dn_pattern
  $ldap_other_bind            = $rabbitmq_legacy::ldap_other_bind
  $ldap_use_ssl               = $rabbitmq_legacy::ldap_use_ssl
  $ldap_port                  = $rabbitmq_legacy::ldap_port
  $ldap_log                   = $rabbitmq_legacy::ldap_log
  $ldap_config_variables      = $rabbitmq_legacy::ldap_config_variables
  $wipe_db_on_cookie_change   = $rabbitmq_legacy::wipe_db_on_cookie_change
  $config_variables           = $rabbitmq_legacy::config_variables
  $config_kernel_variables    = $rabbitmq_legacy::config_kernel_variables
  $config_management_variables = $rabbitmq_legacy::config_management_variables
  $config_additional_variables = $rabbitmq_legacy::config_additional_variables
  $auth_backends              = $rabbitmq_legacy::auth_backends
  $cluster_partition_handling = $rabbitmq_legacy::cluster_partition_handling
  $file_limit                 = $rabbitmq_legacy::file_limit
  $collect_statistics_interval = $rabbitmq_legacy::collect_statistics_interval

  if $ssl_only {
    $default_env_variables = {}
  } else {
    $default_env_variables = {
      'NODE_PORT'        => $port,
      'NODE_IP_ADDRESS'  => $node_ip_address
    }
  }

  # Handle env variables.
  $environment_variables = merge($default_env_variables, $rabbitmq_legacy::environment_variables)

  # Get ranch (socket acceptor pool) availability,
  # use init class variable for that since version from the fact comes too late.
  $ranch = versioncmp($rabbitmq_legacy::version, '3.6') >= 0

  file { '/etc/rabbitmq':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { '/etc/rabbitmq/ssl':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { 'rabbitmq.config':
    ensure  => file,
    path    => $config_path,
    content => template($config),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Class['rabbitmq_legacy::service'],
  }

  file { 'rabbitmq-env.config':
    ensure  => file,
    path    => $env_config_path,
    content => template($env_config),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Class['rabbitmq_legacy::service'],
  }

  if $admin_enable {
    file { 'rabbitmqadmin.conf':
      ensure  => file,
      path    => '/etc/rabbitmq/rabbitmqadmin.conf',
      content => template('rabbitmq/rabbitmqadmin.conf.erb'),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      require => File['/etc/rabbitmq'],
    }
  }

  case $::osfamily {
    'Debian': {
      if versioncmp($::operatingsystemmajrelease, '16.04') >= 0 {
        file { '/etc/systemd/system/rabbitmq-server.service.d':
          ensure                  => directory,
          owner                   => '0',
          group                   => '0',
          mode                    => '0755',
          selinux_ignore_defaults => true,
        }
        -> file { '/etc/systemd/system/rabbitmq-server.service.d/limits.conf':
          content => template('rabbitmq/rabbitmq-server.service.d/limits.conf'),
          owner   => '0',
          group   => '0',
          mode    => '0644',
          notify  => Exec['rabbitmq-systemd-reload'],
        }
        exec { 'rabbitmq-systemd-reload':
          command     => '/bin/systemctl daemon-reload',
          notify      => Class['Rabbitmq::Service'],
          refreshonly => true,
        }
      }
      file { '/etc/default/rabbitmq-server':
        ensure  => file,
        content => template('rabbitmq/default.erb'),
        mode    => '0644',
        owner   => '0',
        group   => '0',
        notify  => Class['rabbitmq_legacy::service'],
      }
    }
    'RedHat': {
      if versioncmp($::operatingsystemmajrelease, '7') >= 0 {
        file { '/etc/systemd/system/rabbitmq-server.service.d':
          ensure                  => directory,
          owner                   => '0',
          group                   => '0',
          mode                    => '0755',
          selinux_ignore_defaults => true,
        }
        -> file { '/etc/systemd/system/rabbitmq-server.service.d/limits.conf':
          content => template('rabbitmq/rabbitmq-server.service.d/limits.conf'),
          owner   => '0',
          group   => '0',
          mode    => '0644',
          notify  => Exec['rabbitmq-systemd-reload'],
        }
        exec { 'rabbitmq-systemd-reload':
          command     => '/usr/bin/systemctl daemon-reload',
          notify      => Class['Rabbitmq::Service'],
          refreshonly => true,
        }
      }
      file { '/etc/security/limits.d/rabbitmq-server.conf':
        content => template('rabbitmq/limits.conf'),
        owner   => '0',
        group   => '0',
        mode    => '0644',
        notify  => Class['Rabbitmq::Service'],
      }
    }
    default: {
    }
  }

  if $erlang_cookie == undef and $config_cluster {
    fail('You must set the $erlang_cookie value in order to configure clustering.')
  } elsif $erlang_cookie != undef {
    rabbitmq_erlang_cookie { "${rabbitmq_home}/.erlang.cookie":
      content        => $erlang_cookie,
      force          => $wipe_db_on_cookie_change,
      rabbitmq_user  => $rabbitmq_user,
      rabbitmq_group => $rabbitmq_group,
      rabbitmq_home  => $rabbitmq_home,
      service_name   => $service_name,
      before         => File['rabbitmq.config'],
      notify         => Class['rabbitmq_legacy::service'],
    }
  }
}

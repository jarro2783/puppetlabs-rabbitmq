# Main rabbitmq class
class rabbitmq_legacy(
  Boolean $admin_enable                          = $rabbitmq_legacy::params::admin_enable,
  Enum['ram', 'disk', 'disc'] $cluster_node_type = $rabbitmq_legacy::params::cluster_node_type,
  Array $cluster_nodes                           = $rabbitmq_legacy::params::cluster_nodes,
  String $config                                 = $rabbitmq_legacy::params::config,
  Boolean $config_cluster                        = $rabbitmq_legacy::params::config_cluster,
  Stdlib::Absolutepath $config_path              = $rabbitmq_legacy::params::config_path,
  Boolean $config_stomp                          = $rabbitmq_legacy::params::config_stomp,
  Boolean $config_shovel                         = $rabbitmq_legacy::params::config_shovel,
  Hash $config_shovel_statics                    = $rabbitmq_legacy::params::config_shovel_statics,
  String $default_user                           = $rabbitmq_legacy::params::default_user,
  String $default_pass                           = $rabbitmq_legacy::params::default_pass,
  Boolean $delete_guest_user                     = $rabbitmq_legacy::params::delete_guest_user,
  String $env_config                             = $rabbitmq_legacy::params::env_config,
  Stdlib::Absolutepath $env_config_path          = $rabbitmq_legacy::params::env_config_path,
  Optional[String] $erlang_cookie                = $rabbitmq_legacy::params::erlang_cookie,
  $interface                                     = $rabbitmq_legacy::params::interface,
  $management_port                               = $rabbitmq_legacy::params::management_port,
  $management_ssl                                = $rabbitmq_legacy::params::management_ssl,
  Optional[String] $management_hostname          = $rabbitmq_legacy::params::management_hostname,
  String $node_ip_address                        = $rabbitmq_legacy::params::node_ip_address,
  $package_apt_pin                               = $rabbitmq_legacy::params::package_apt_pin,
  String $package_ensure                         = $rabbitmq_legacy::params::package_ensure,
  String $package_gpg_key                        = $rabbitmq_legacy::params::package_gpg_key,
  String $package_name                           = $rabbitmq_legacy::params::package_name,
  Optional[String] $package_provider             = $rabbitmq_legacy::params::package_provider,
  $package_source                                = undef,
  Boolean $repos_ensure                          = $rabbitmq_legacy::params::repos_ensure,
  $manage_repos                                  = $rabbitmq_legacy::params::manage_repos,
  Stdlib::Absolutepath $plugin_dir               = $rabbitmq_legacy::params::plugin_dir,
  $rabbitmq_user                                 = $rabbitmq_legacy::params::rabbitmq_user,
  $rabbitmq_group                                = $rabbitmq_legacy::params::rabbitmq_group,
  $rabbitmq_home                                 = $rabbitmq_legacy::params::rabbitmq_home,
  $port                                          = $rabbitmq_legacy::params::port,
  Boolean $tcp_keepalive                         = $rabbitmq_legacy::params::tcp_keepalive,
  Integer $tcp_backlog                           = $rabbitmq_legacy::params::tcp_backlog,
  Optional[Integer] $tcp_sndbuf                  = $rabbitmq_legacy::params::tcp_sndbuf,
  Optional[Integer] $tcp_recbuf                  = $rabbitmq_legacy::params::tcp_recbuf,
  Optional[Integer] $heartbeat                   = $rabbitmq_legacy::params::heartbeat,
  Enum['running', 'stopped'] $service_ensure     = $rabbitmq_legacy::params::service_ensure,
  Boolean $service_manage                        = $rabbitmq_legacy::params::service_manage,
  String $service_name                           = $rabbitmq_legacy::params::service_name,
  Boolean $ssl                                   = $rabbitmq_legacy::params::ssl,
  Boolean $ssl_only                              = $rabbitmq_legacy::params::ssl_only,
  String $ssl_cacert                             = $rabbitmq_legacy::params::ssl_cacert,
  String $ssl_cert                               = $rabbitmq_legacy::params::ssl_cert,
  String $ssl_key                                = $rabbitmq_legacy::params::ssl_key,
  Optional[Integer] $ssl_depth                   = $rabbitmq_legacy::params::ssl_depth,
  Optional[String] $ssl_cert_password            = $rabbitmq_legacy::params::ssl_cert_password,
  $ssl_port                                      = $rabbitmq_legacy::params::ssl_port,
  $ssl_interface                                 = $rabbitmq_legacy::params::ssl_interface,
  $ssl_management_port                           = $rabbitmq_legacy::params::ssl_management_port,
  $ssl_stomp_port                                = $rabbitmq_legacy::params::ssl_stomp_port,
  $ssl_verify                                    = $rabbitmq_legacy::params::ssl_verify,
  $ssl_fail_if_no_peer_cert                      = $rabbitmq_legacy::params::ssl_fail_if_no_peer_cert,
  Optional[Array] $ssl_versions                  = $rabbitmq_legacy::params::ssl_versions,
  Array $ssl_ciphers                             = $rabbitmq_legacy::params::ssl_ciphers,
  Boolean $stomp_ensure                          = $rabbitmq_legacy::params::stomp_ensure,
  Boolean $ldap_auth                             = $rabbitmq_legacy::params::ldap_auth,
  String $ldap_server                            = $rabbitmq_legacy::params::ldap_server,
  String $ldap_user_dn_pattern                   = $rabbitmq_legacy::params::ldap_user_dn_pattern,
  String $ldap_other_bind                        = $rabbitmq_legacy::params::ldap_other_bind,
  Boolean $ldap_use_ssl                          = $rabbitmq_legacy::params::ldap_use_ssl,
  $ldap_port                                     = $rabbitmq_legacy::params::ldap_port,
  Boolean $ldap_log                              = $rabbitmq_legacy::params::ldap_log,
  Hash $ldap_config_variables                    = $rabbitmq_legacy::params::ldap_config_variables,
  $stomp_port                                    = $rabbitmq_legacy::params::stomp_port,
  Boolean $stomp_ssl_only                        = $rabbitmq_legacy::params::stomp_ssl_only,
  $version                                       = $rabbitmq_legacy::params::version,
  Boolean $wipe_db_on_cookie_change              = $rabbitmq_legacy::params::wipe_db_on_cookie_change,
  $cluster_partition_handling                    = $rabbitmq_legacy::params::cluster_partition_handling,
  $file_limit                                    = $rabbitmq_legacy::params::file_limit,
  Hash $environment_variables                    = $rabbitmq_legacy::params::environment_variables,
  Hash $config_variables                         = $rabbitmq_legacy::params::config_variables,
  Hash $config_kernel_variables                  = $rabbitmq_legacy::params::config_kernel_variables,
  Hash $config_management_variables              = $rabbitmq_legacy::params::config_management_variables,
  Hash $config_additional_variables              = $rabbitmq_legacy::params::config_additional_variables,
  Optional[Array] $auth_backends                 = $rabbitmq_legacy::params::auth_backends,
  $key_content                                   = undef,
  Optional[Integer] $collect_statistics_interval = $rabbitmq_legacy::params::collect_statistics_interval,
) inherits rabbitmq_legacy::params {

  # Validate install parameters.
  validate_re($package_apt_pin, '^(|\d+)$')
  validate_re($version, '^\d+\.\d+\.\d+(-\d+)*$') # Allow 3 digits and optional -n postfix.
  # Validate config parameters.
  if ! is_integer($management_port) {
    validate_re($management_port, '\d+')
  }
  if ! is_integer($port) {
    validate_re($port, ['\d+','UNSET'])
  }
  if ! is_integer($stomp_port) {
    validate_re($stomp_port, '\d+')
  }

  # using sprintf for conversion to string, because "${file_limit}" doesn't
  # pass lint, despite being nicer
  validate_re(sprintf('%s', $file_limit),
              '^(\d+|-1|unlimited|infinity)$', '$file_limit must be a positive integer, \'-1\', \'unlimited\', or \'infinity\'.')
  if ! is_integer($ssl_port) {
    validate_re($ssl_port, '\d+')
  }
  if ! is_integer($ssl_management_port) {
    validate_re($ssl_management_port, '\d+')
  }
  if ! is_integer($ssl_stomp_port) {
    validate_re($ssl_stomp_port, '\d+')
  }
  validate_re($ldap_port, '\d+')

  if $ssl_only and ! $ssl {
    fail('$ssl_only => true requires that $ssl => true')
  }

  if $config_stomp and $stomp_ssl_only and ! $ssl_stomp_port  {
    fail('$stomp_ssl_only requires that $ssl_stomp_port be set')
  }

  if $ssl_versions {
    unless $ssl {
      fail('$ssl_versions requires that $ssl => true')
    }
  }

  # This needs to happen here instead of params.pp because
  # $package_source needs to override the constructed value in params.pp
  if $package_source { # $package_source was specified by user so use that one
    $real_package_source = $package_source
  # NOTE(bogdando) do not enforce the source value for yum provider #MODULES-1631
  } elsif $package_provider != 'yum' {
    # package_source was not specified, so construct it, unless the provider is 'yum'
    case $::osfamily {
      'RedHat', 'SUSE': {
        $base_version   = regsubst($version,'^(.*)-\d$','\1')
        $real_package_source = "http://www.rabbitmq.com/releases/rabbitmq-server/v${base_version}/rabbitmq-server-${version}.noarch.rpm"
      }
      'OpenBSD': {
        # We just use the default OpenBSD package from a mirror
        $real_package_source = undef
      }
      default: { # Archlinux and Debian
        $real_package_source = undef
      }
    }
  } else { # for yum provider, use the source as is
    $real_package_source = $package_source
  }

  if $manage_repos != undef {
    warning('$manage_repos is now deprecated. Please use $repos_ensure instead')
  }

  if $manage_repos != false {
    case $::osfamily {
      'RedHat', 'SUSE': {
          include '::rabbitmq_legacy::repo::rhel'
          $package_require = undef
      }
      'Debian': {
        class { '::rabbitmq_legacy::repo::apt' :
          key_source  => $package_gpg_key,
          key_content => $key_content,
        }
        $package_require = Class['apt::update']
      }
      default: {
        $package_require = undef
      }
    }
  } else {
    $package_require = undef
  }

  include '::rabbitmq_legacy::install'
  include '::rabbitmq_legacy::config'
  include '::rabbitmq_legacy::service'
  include '::rabbitmq_legacy::management'

  if $admin_enable and $service_manage {
    include '::rabbitmq_legacy::install::rabbitmqadmin'

    rabbitmq_plugin { 'rabbitmq_management':
      ensure   => present,
      require  => Class['rabbitmq_legacy::install'],
      notify   => Class['rabbitmq_legacy::service'],
      provider => 'rabbitmqplugins',
    }

    Class['::rabbitmq_legacy::service'] -> Class['::rabbitmq_legacy::install::rabbitmqadmin']
    Class['::rabbitmq_legacy::install::rabbitmqadmin'] -> Rabbitmq_exchange<| |>
  }

  if $stomp_ensure {
    rabbitmq_plugin { 'rabbitmq_stomp':
      ensure  => present,
      require => Class['rabbitmq_legacy::install'],
      notify  => Class['rabbitmq_legacy::service'],
    }
  }

  if ($ldap_auth) {
    rabbitmq_plugin { 'rabbitmq_auth_backend_ldap':
      ensure  => present,
      require => Class['rabbitmq_legacy::install'],
      notify  => Class['rabbitmq_legacy::service'],
    }
  }

  if ($config_shovel) {
    rabbitmq_plugin { 'rabbitmq_shovel':
      ensure   => present,
      require  => Class['rabbitmq_legacy::install'],
      notify   => Class['rabbitmq_legacy::service'],
      provider => 'rabbitmqplugins',
    }

    if ($admin_enable) {
      rabbitmq_plugin { 'rabbitmq_shovel_management':
        ensure   => present,
        require  => Class['rabbitmq_legacy::install'],
        notify   => Class['rabbitmq_legacy::service'],
        provider => 'rabbitmqplugins',
      }
    }
  }

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'rabbitmq_legacy::begin': }
  anchor { 'rabbitmq_legacy::end': }

  Anchor['rabbitmq_legacy::begin'] -> Class['::rabbitmq_legacy::install']
    -> Class['::rabbitmq_legacy::config'] ~> Class['::rabbitmq_legacy::service']
    -> Class['::rabbitmq_legacy::management'] -> Anchor['rabbitmq_legacy::end']

  # Make sure the various providers have their requirements in place.
  Class['::rabbitmq_legacy::install'] -> Rabbitmq_plugin<| |>

}

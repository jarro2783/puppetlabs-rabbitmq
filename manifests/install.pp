# Class rabbitmq_legacy::install
# Ensures the rabbitmq-server exists
class rabbitmq_legacy::install {

  $package_ensure   = $rabbitmq_legacy::package_ensure
  $package_name     = $rabbitmq_legacy::package_name
  $package_provider = $rabbitmq_legacy::package_provider
  $package_require  = $rabbitmq_legacy::package_require
  $package_source   = $rabbitmq_legacy::real_package_source

  package { 'rabbitmq-server':
    ensure   => $package_ensure,
    name     => $package_name,
    provider => $package_provider,
    notify   => Class['rabbitmq_legacy::service'],
    require  => $package_require,
  }

  if $package_source {
    Package['rabbitmq-server'] {
      source  => $package_source,
    }
  }

  if $rabbitmq_legacy::environment_variables['MNESIA_BASE'] {
    file { $rabbitmq_legacy::environment_variables['MNESIA_BASE']:
      ensure  => 'directory',
      owner   => 'root',
      group   => 'rabbitmq',
      mode    => '0775',
      require => Package['rabbitmq-server'],
    }
  }
}

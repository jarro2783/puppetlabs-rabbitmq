# Class: rabbitmq_legacy::service
#
#   This class manages the rabbitmq server service itself.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class rabbitmq_legacy::service(
  Enum['running', 'stopped'] $service_ensure  = $rabbitmq_legacy::service_ensure,
  Boolean $service_manage                     = $rabbitmq_legacy::service_manage,
  $service_name                               = $rabbitmq_legacy::service_name,
) inherits rabbitmq_legacy {

  if ($service_manage) {
    if $service_ensure == 'running' {
      $ensure_real = 'running'
      $enable_real = true
    } else {
      $ensure_real = 'stopped'
      $enable_real = false
    }

    service { 'rabbitmq-server':
      ensure     => $ensure_real,
      enable     => $enable_real,
      hasstatus  => true,
      hasrestart => true,
      name       => $service_name,
    }
  }

}

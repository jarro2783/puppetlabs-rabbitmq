# Class: rabbitmq_legacy::repo::rhel
# Imports the gpg key if it doesn't already exist.
class rabbitmq_legacy::repo::rhel {

  if $rabbitmq_legacy::repos_ensure {

    $package_gpg_key = $rabbitmq_legacy::package_gpg_key

    Class['rabbitmq_legacy::repo::rhel'] -> Package<| title == 'rabbitmq-server' |>

    exec { "rpm --import ${package_gpg_key}":
      path   => ['/bin','/usr/bin','/sbin','/usr/sbin'],
      unless => 'rpm -q gpg-pubkey-6026dfca-573adfde 2>/dev/null',
    }
  }
}

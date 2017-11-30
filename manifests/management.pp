#
class rabbitmq_legacy::management {

  $delete_guest_user = $rabbitmq_legacy::delete_guest_user

  if $delete_guest_user {
    rabbitmq_user{ 'guest':
      ensure   => absent,
      provider => 'rabbitmqctl',
    }
  }

}

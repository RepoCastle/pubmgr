package com.github.shinkchu.pubmgr

class Contact {
  String organization
  String address
  String contacts
  String phone
  String email

  static constraints = {
    organization nullable: true
    address nullable: true
    contacts nullable: true
    phone nullable: true
    email nullable: true
  }
}

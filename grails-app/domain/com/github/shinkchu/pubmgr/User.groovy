package com.github.shinkchu.pubmgr

class User {
  String username
  String password
  String email
  String mobileNo
  String alias
  String institution
  String role

  static constraints = {
      username(nullable:false, blank:false, unique:true)
      password(password:true)
      email(email:true, unique:true)
      mobileNo(length:11, matches:"[0-9]+", blank: false)
      alias(nullable:false, blank:false)
      institution(nullable:true)
  }

  static mapping = {
  }

  static transients = ['admin']
  Boolean isAdmin() {
      role == 'admin'
  }

  String toString() {
      alias
  }

  def beforeInsert = {
      password = password.encodeAsSHA1()
  }
}

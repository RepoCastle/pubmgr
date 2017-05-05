package com.github.shinkchu.pubmgr

class Organization {
  String name
//  String content
//  String topic
  String url
//  String attachment

  static mapping = {
    sort 'id'
  }

  static constraints = {
    name nullable: false
//    content nullable: true, maxSize: 4000
//    topic nullable: true
    url nullable: true
//    attachment nullable: true
  }
}

package com.github.shinkchu.pubmgr

class Book {
  String title
  String authors
  String publishDate
  String keywords
  String introduction
  String picture
  String attachment

  static	belongsTo	= [category: Category]

  static mapping = {
    sort 'publishDate'
    order 'desc'
  }

  static constraints = {
    title nullable: false
    authors nullable: true
    publishDate nullable: true
    keywords nullable: true
    introduction maxSize: 65535
    picture nullable: true
    attachment nullable: true
  }
}

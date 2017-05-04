package com.github.shinkchu.pubmgr

class Reference {
  String title
  String authors
  String publishDate
  String publisher
  String publisherType
  String content
  String attachment
  String institutions
  String abstractEn
  String keywordEn
  String abstractCh
  String keywordCh


  static mapping = {
    sort publishDate: "desc"
  }

  static constraints = {
    title nullable: false
    authors nullable: true
    content nullable: true, maxSize: 65535
    publishDate nullable: true
    publisher nullable: true
    publisherType nullable: true, inList: ['C', 'J', 'B', 'M']
    attachment nullable: true

    institutions nullable: true
    abstractEn nullable: true, maxSize: 65535
    keywordEn nullable: true
    abstractCh nullable: true, maxSize: 65535
    keywordCh nullable: true
  }

  public String toCiteFormat() {
    String citeFormat = title + ' [' + (publisherType ? publisherType : 'J') + ']; ' + authors + '; ' + publisher + '; ' + publishDate
    return citeFormat
  }
}

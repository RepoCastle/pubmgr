package com.github.shinkchu.pubmgr

class Category {
  String name
  Integer suborder
  Category parent
  String target

  static mapping = {
    sort 'suborder'
  }

  static	constraints = {
    parent (nullable: true)
    target inList: ["reference", "organization", "book", "researcher"], nullable: false
    suborder min: 0, unique: 'target'
  }

  @Override
  public String toString() {
    return "${name}";
  }
}

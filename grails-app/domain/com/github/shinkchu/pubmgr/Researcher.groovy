package com.github.shinkchu.pubmgr

class Researcher {
    String name
    String introduction
    String picture

    static	belongsTo	= [category: Category]

    static constraints = {
        name nullable: false
        introduction maxSize: 65535
        picture nullable: true
    }
}

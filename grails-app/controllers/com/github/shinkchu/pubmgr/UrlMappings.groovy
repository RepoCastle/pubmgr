package com.github.shinkchu.pubmgr

class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?(.$format)?"{
      constraints {
          // apply constraints here
      }
    }

    "/" {
      controller = 'introduction'
      action = { 'index' }
      view = { 'index' }
    }


    "/reference" {
      controller = 'reference'
      action = { 'index' }
      view = { 'index' }
    }

    "/researcher" {
      controller = 'researcher'
      action = { 'index' }
      view = { 'index' }
    }

    "/organization" {
      controller = 'organization'
      action = { 'index' }
      view = { 'index' }
    }

    "/admin" {
      controller = 'user'
      action = 'login'
    }

    "/user" {
      controller = 'user'
      action = 'login'
    }

    "/book" {
      controller = 'book'
      action = { 'index' }
      view = { 'index' }
    }

    "/contact" {
      controller = 'contact'
      action = { 'index' }
      view = { 'index' }
    }

    "500"(view:'/error')
    "404"(view:'/notFound')
  }
}

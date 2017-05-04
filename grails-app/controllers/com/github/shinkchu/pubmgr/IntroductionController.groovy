package com.github.shinkchu.pubmgr

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class IntroductionController {

  static allowedMethods = [update: "POST"]

  def index() {
    def introductionInstances = Introduction.getAll();
    if (introductionInstances && introductionInstances.size() >= 0) {
      [introductionInstance: introductionInstances[0]]
    }
  }

  def edit() {
    def introductionInstance = Introduction.get(params.id)
    if (introductionInstance) {
      [introductionInstance: introductionInstance]
    }
  }

  def update() {
    def introductionInstance
    if (params.id) {
      introductionInstance = Introduction.get(params.id)
      if (!introductionInstance) {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'introduction.label', default: 'Introduction'), params.id])
        redirect(action: "index")
        return
      }
    } else {
      def introductionInstanceList = Introduction.list()
      if (introductionInstanceList?.size() > 0) {
        flash.message = message(code: 'default.not.found.message2', args: [message(code: 'introduction.label', default: '未指定id'), params.id])
        redirect(action: "index")
        return
      }
    }

    if (introductionInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (introductionInstance.version > version) {
          introductionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
              [message(code: 'introduction.label', default: 'Introduction')] as Object[],
              "Another user has updated this Introduction while you were editing")
          render(view: "index", model: [introductionInstance: introductionInstance])
          return
        }
      }

      introductionInstance.properties = params

      if (!introductionInstance.save(flush: true)) {
        render(view: "index", model: [introductionInstance: introductionInstance])
        return
      }
    } else {
      introductionInstance = new Introduction(params)
      introductionInstance.save(flush: true)
      if (!introductionInstance) {
        flash.message = message(code: 'default.not.found.message3', args: [message(code: 'introduction.label', default: '创建失败！'), params.id])
        redirect(action: "index")
        return
      }
    }

    flash.message = message(code: 'default.updated.message', args: [message(code: 'introduction.label', default: 'Introduction'), introductionInstance.id])
    redirect(action: "index", id: introductionInstance.id)
  }
}

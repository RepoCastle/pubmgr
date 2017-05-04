package com.github.shinkchu.pubmgr

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResearcherController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Researcher.list(params), model:[researcherCount: Researcher.count()]
    }

    def show(Researcher researcher) {
        respond researcher
    }

    def create() {
        respond new Researcher(params)
    }

    @Transactional
    def save(Researcher researcher) {
        if (researcher == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (researcher.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond researcher.errors, view:'create'
            return
        }

        researcher.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'researcher.label', default: 'Researcher'), researcher.id])
                redirect researcher
            }
            '*' { respond researcher, [status: CREATED] }
        }
    }

    def edit(Researcher researcher) {
        respond researcher
    }

    @Transactional
    def update(Researcher researcher) {
        if (researcher == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (researcher.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond researcher.errors, view:'edit'
            return
        }

        researcher.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'researcher.label', default: 'Researcher'), researcher.id])
                redirect researcher
            }
            '*'{ respond researcher, [status: OK] }
        }
    }

    @Transactional
    def delete(Researcher researcher) {

        if (researcher == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        researcher.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'researcher.label', default: 'Researcher'), researcher.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'researcher.label', default: 'Researcher'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

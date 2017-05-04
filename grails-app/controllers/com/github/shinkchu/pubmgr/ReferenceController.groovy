package com.github.shinkchu.pubmgr

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ReferenceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Reference.list(params), model:[referenceCount: Reference.count()]
    }

    def show(Reference reference) {
        respond reference
    }

    def create() {
        respond new Reference(params)
    }

    @Transactional
    def save(Reference reference) {
        if (reference == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (reference.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond reference.errors, view:'create'
            return
        }

        reference.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'reference.label', default: 'Reference'), reference.id])
                redirect reference
            }
            '*' { respond reference, [status: CREATED] }
        }
    }

    def edit(Reference reference) {
        respond reference
    }

    @Transactional
    def update(Reference reference) {
        if (reference == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (reference.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond reference.errors, view:'edit'
            return
        }

        reference.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'reference.label', default: 'Reference'), reference.id])
                redirect reference
            }
            '*'{ respond reference, [status: OK] }
        }
    }

    @Transactional
    def delete(Reference reference) {

        if (reference == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        reference.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'reference.label', default: 'Reference'), reference.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'reference.label', default: 'Reference'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

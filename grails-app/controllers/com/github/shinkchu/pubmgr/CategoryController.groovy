package com.github.shinkchu.pubmgr

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CategoryController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Category.list(params), model:[categoryCount: Category.count()]
    }

    def show(Category category) {
        respond category
    }

    def create() {
        def controllerName

        if (params.target) {
            controllerName = params.target
        } else {
            controllerName = this.controllerName
        }

        def maxSuborder = Category.findAllByTarget(controllerName).suborder.max()
        if (!maxSuborder) {
            maxSuborder = 0
        }
        params.suborder = maxSuborder + 1

        respond new Category(params)
    }

    @Transactional
    def save(Category category) {
        def controllerName = params.target

        if (category == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (category.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond category.errors, view:'create'
            return
        }

        category.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'category.new.success.label', args: [controllerName, category.name], default: 'Creating new category successfully!')
                redirect(controller: controllerName, action: "index")
            }
            '*' {
                flash.message = message(code: 'category.new.fail.label', args: [controllerName], default: 'Creating new category failed!')
                redirect(controller: controllerName, action: "index")
                return
            }
        }
    }

    def edit(Category category) {
        respond category
    }

    @Transactional
    def update(Category category) {
        if (category == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (category.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond category.errors, view:'edit'
            return
        }

        category.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'category.label', default: 'Category'), category.id])
                redirect category
            }
            '*'{ respond category, [status: OK] }
        }
    }

    @Transactional
    def delete(Category category) {

        if (category == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        category.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'category.label', default: 'Category'), category.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

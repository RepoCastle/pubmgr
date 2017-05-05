package com.github.shinkchu.pubmgr

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResearcherController {
    def fileUploadService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        def researcherInstanceList
        def researcherInstanceTotal
        def researcherCategories
        def category
        def keyword = params.keyword

        if (keyword) {
            keyword = '%' + keyword.trim() + '%'
        } else {
            keyword = '%'
        }

        researcherCategories = Category.findAllByTarget('researcher', [sort: 'suborder'])
        if (params.category) {
            def categoryId = params.int('category')
            category = Category.get(categoryId);
            researcherInstanceList = Researcher.findAllByCategoryAndNameLike(category, keyword, params)
            researcherInstanceTotal = Researcher.countByCategoryAndNameLike(category, keyword)
        } else {
            researcherInstanceList = Researcher.findAllByNameLike(keyword, params);
            researcherInstanceTotal = Researcher.countByNameLike(keyword)
            category = ''
        }

        [researcherCategories: researcherCategories, category: category.toString(), keyword: keyword, researcherInstanceList: researcherInstanceList, researcherInstanceTotal: researcherInstanceTotal]
    }

    def save() {
        def f = request.getFile('pictureFile')
        if (f!=null && !f?.isEmpty()) {
            params.picture = fileUploadService.uploadFileToDataDir(controllerName, f, "researcher")
        }

        def researcherInstance = new Researcher(params)
        if (!researcherInstance.save(flush: true)) {
            flash.message = message(code: 'default.fail.message', args: [message(code: 'researcher.label', default: 'Researcher'), researcherInstance.name])
            redirect(action: "index", params: [category: params.category.id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'researcher.label', default: 'Researcher'), researcherInstance.name])
        redirect(action: "index", params: [category: params.category.id])
    }

    @Transactional
    def delete(Researcher researcher) {

        if (researcher == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        researcher.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'researcher.label', default: 'Researcher'), researcher.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }










    def show(Researcher researcher) {
        respond researcher
    }

    def create() {
        respond new Researcher(params)
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
            respond researcher.errors, view: 'edit'
            return
        }

        researcher.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'researcher.label', default: 'Researcher'), researcher.id])
                redirect researcher
            }
            '*' { respond researcher, [status: OK] }
        }
    }


    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'researcher.label', default: 'Researcher'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

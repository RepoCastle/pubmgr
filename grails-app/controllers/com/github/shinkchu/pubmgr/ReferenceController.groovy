package com.github.shinkchu.pubmgr

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ReferenceController {
  def fileUploadService

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def index() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)

    def referenceInstanceList
    def referenceInstanceTotal
    def referenceCategories
    def category
    def keyword = params.keyword

    if (keyword) {
      keyword = '%' + keyword.trim() + '%'
    } else {
      keyword = '%'
    }

    referenceCategories = Category.findAllByTarget('reference', [sort: 'suborder'])
    if (params.category) {
      def categoryId = params.int('category')
      category = Category.get(categoryId);
      referenceInstanceList = Reference.findAllByCategoryAndTitleLike(category, keyword, params)
      referenceInstanceTotal = Reference.countByCategoryAndTitleLike(category, keyword)
    } else {
      referenceInstanceList = Reference.findAllByTitleLike(keyword, params);
      referenceInstanceTotal = Reference.countByTitleLike(keyword)
      category = ''
    }

    [referenceCategories: referenceCategories, category: category.toString(), keyword: keyword, referenceInstanceList: referenceInstanceList, referenceInstanceTotal: referenceInstanceTotal]
  }

  def save() {
    def f = request.getFile('attachmentFile')
    if (f!=null && !f?.isEmpty()) {
      params.attachment = fileUploadService.uploadFileToDataDir(controllerName, f, "reference")
    }

    def picFile = request.getFile('pictureFile')
    if (picFile!=null && !picFile?.isEmpty()) {
      params.picture = fileUploadService.uploadFileToDataDir(controllerName, f, "cover")
    }

    def referenceInstance = new Reference(params)
    if (!referenceInstance.save(flush: true)) {
      flash.message = message(code: 'default.fail.message', args: [message(code: 'reference.label', default: 'Reference'), referenceInstance.title])
      redirect(action: "index", params: [category: params.category.id])
      return
    }

    flash.message = message(code: 'default.created.message', args: [message(code: 'reference.label', default: 'Reference'), referenceInstance.title])
    redirect(action: "index", params: [category: params.category.id])
  }

  @Transactional
  def delete(Reference reference) {

    if (reference == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    reference.delete flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.deleted.message', args: [message(code: 'reference.label', default: 'Reference'), reference.id])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NO_CONTENT }
    }
  }










  def show(Reference reference) {
    respond reference
  }

  def create() {
    respond new Reference(params)
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
      respond reference.errors, view: 'edit'
      return
    }

    reference.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.updated.message', args: [message(code: 'reference.label', default: 'Reference'), reference.id])
        redirect reference
      }
      '*' { respond reference, [status: OK] }
    }
  }


  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'reference.label', default: 'Reference'), params.id])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NOT_FOUND }
    }
  }
}

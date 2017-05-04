package com.github.shinkchu.pubmgr

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BookController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def index() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)

    def bookInstanceList
    def bookInstanceTotal
    def bookCategories
    def category
    def keyword = params.keyword

    if (keyword) {
      keyword = '%' + keyword.trim() + '%'
    } else {
      keyword = '%'
    }

    bookCategories = Category.findAllByTarget('book', [sort: 'suborder'])
    if (params.category) {
      def categoryId = params.int('category')
      category = Category.get(categoryId);
      bookInstanceList = Book.findAllByCategoryAndTitleLike(category, keyword, params)
      bookInstanceTotal = Book.countByCategoryAndTitleLike(category, keyword)
    } else {
      bookInstanceList = Book.findAllByTitleLike(keyword, params);
      bookInstanceTotal = Book.countByTitleLike(keyword)
      category = ''
    }

    [bookCategories: bookCategories, category: category.toString(), keyword: keyword, bookInstanceList: bookInstanceList, bookInstanceTotal: bookInstanceTotal]
  }

  @Transactional
  def save(Book book) {
    if (book == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (book.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond book.errors, view: 'create'
      return
    }

    book.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.created.message', args: [message(code: 'book.label', default: 'Book'), book.id])
        redirect book
      }
      '*' { respond book, [status: CREATED] }
    }
  }

  @Transactional
  def delete(Book book) {

    if (book == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    book.delete flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.deleted.message', args: [message(code: 'book.label', default: 'Book'), book.id])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NO_CONTENT }
    }
  }










  def show(Book book) {
    respond book
  }

  def create() {
    respond new Book(params)
  }


  def edit(Book book) {
    respond book
  }

  @Transactional
  def update(Book book) {
    if (book == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (book.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond book.errors, view: 'edit'
      return
    }

    book.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.updated.message', args: [message(code: 'book.label', default: 'Book'), book.id])
        redirect book
      }
      '*' { respond book, [status: OK] }
    }
  }


  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NOT_FOUND }
    }
  }
}

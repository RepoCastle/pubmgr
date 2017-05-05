<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    <section id="create-book" class="first">
        <g:hasErrors bean="${bookInstance}">
            <div class="alert alert-error">
                <g:renderErrors bean="${bookInstance}" as="list" />
            </div>
        </g:hasErrors>

        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true"></span>
                        <span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="bookCreateModalLabel">
                        <g:message code="book.new.button.add.label" default="添加图书"></g:message>
                    </h4>
                </div>

                <div class="modal-body">
                    <g:form method="post" class="form-horizontal" enctype="multipart/form-data">
                        <div>
                            <fieldset class="form">

                                <div class="margin-bottom-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="book.new.title.label" default="Title"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <input name="title" type="text" class="form-control" placeholder="${message(code: 'book.new.title.label')}">
                                    </div>
                                </div>

                                <div class="margin-bottom-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="book.category.title" default="Category"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <g:select name="category.id" from="${com.github.shinkchu.pubmgr.Category.findAllByTarget("book")}"
                                                  optionKey="id" class="many-to-one btn btn-default height-40" value="${params.category}">
                                        </g:select>
                                    </div>
                                </div>

                                <div class="margin-bottom-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="book.new.authors.label" default="Authors"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <input name="authors" type="text" class="form-control" placeholder="${message(code: 'book.new.authors.label')}">
                                    </div>
                                </div>

                                <div class="margin-bottom-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="book.new.picture.label" default="Picture"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <input type="file" id="pictureFile" class="form-control" name="pictureFile"/>
                                    </div>
                                </div>

                                <div class="margin-bottom-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="book.new.publisher.label" default="Publisher"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <input name="publisher" type="text" class="form-control" placeholder="${message(code: 'book.new.publisher.label')}">
                                    </div>
                                </div>

                                <div class="margin-bottom-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="book.new.publish.date.label" default="Publish Date"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <input name="publishDate" type="text" class="form-control" placeholder="${message(code: 'book.new.publish.date.label')}">
                                    </div>
                                </div>

                                <div class="margin-top-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="book.new.attachment.label" default="Attachment"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <input type="file" id="attachmentFile" class="form-control" name="attachmentFile"/>
                                    </div>
                                </div>


                                <div class="margin-top-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="book.new.content.label" default="Content"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <ckeditor:editor name="introduction" height="300px">
                                        </ckeditor:editor>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div class="modal-footer">
                            <g:actionSubmit class="btn btn-primary btn-lg" action="save" value="${message(code: 'default.button.submit.label', default: 'Submit')}"/>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
    </section>
    </body>
</html>

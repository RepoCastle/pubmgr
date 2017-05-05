<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'researcher.label', default: '研究人员')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    <section id="create-researcher" class="first">
        <g:hasErrors bean="${researcherInstance}">
            <div class="alert alert-error">
                <g:renderErrors bean="${researcherInstance}" as="list" />
            </div>
        </g:hasErrors>

        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true"></span>
                        <span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="researcherCreateModalLabel">
                        <g:message code="researcher.new.button.add.label" default="添加研究人员"></g:message>
                    </h4>
                </div>

                <div class="modal-body">
                    <g:form method="post" class="form-horizontal" enctype="multipart/form-data">
                        <div>
                            <fieldset class="form">

                                <div class="margin-bottom-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="researcher.new.title.label" default="姓名"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <input name="name" type="text" class="form-control" placeholder="${message(code: 'researcher.new.title.label', default: '姓名')}">
                                    </div>
                                </div>

                                <div class="margin-bottom-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="researcher.category.title" default="人员类别"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <g:select name="category.id" from="${com.github.shinkchu.pubmgr.Category.findAllByTarget("researcher")}"
                                                  optionKey="id" class="many-to-one btn btn-default height-40" value="${params.category}">
                                        </g:select>
                                    </div>
                                </div>

                                <div class="margin-bottom-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="researcher.new.picture.label" default="照片"></g:message>
                                        </div>
                                        <div class="basic-title-left"></div>
                                    </div>
                                    <div>
                                        <input type="file" id="pictureFile" class="form-control" name="pictureFile"/>
                                    </div>
                                </div>

                                <div class="margin-top-xlarge">
                                    <div class="margin-bottom-medium">
                                        <div class="basic-title">
                                            <g:message code="researcher.new.content.label" default="相关介绍"></g:message>
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

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'reference.label', default: 'Reference')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

    %{--<g:set var="isAdmin" value="${session.user?.admin}"></g:set>--}%
    <g:set var="isAdmin" value="${true}"></g:set>
    <g:set var="BOOK_ABSTRACT_MAX_LENGTH" value="${77}"></g:set>

    <div class="row">
      <div class="col-md-3 margin-top-xlarge table-bordered">
        <ul class="nav">
          <li class="margin-top-medium margin-bottom-medium">
            <div class="sidebar-header">
              <div class="title">
                <g:message code="default.navbar.reference" default="期刊"/>
              </div>
            </div>

            <div class="clearfix"></div>
          </li>
          <g:each in="${referenceCategories}" status="i" var="categoryInstance">
            <li class="margin-top-medium margin-bottom-medium">
              <div class="sidebar-subheader table-bordered ${categoryInstance.toString().equals(category) ? ' active' : ''}">
                <div class="title">
                  <a class="" href="${createLink(controller: 'reference', action: 'index', params: [category: categoryInstance.id])}">
                    ${categoryInstance.name}
                  </a>
                </div>
              </div>
            </li>
          </g:each>

          <g:if test="${isAdmin}">
            <li class="margin-top-medium margin-bottom-medium">
              <button class="btn-block btn btn-default btn-success sidebar-button" data-toggle="modal" data-target="#newCategoryModal">
                <g:message code="category.new.label" default="添加类别！"></g:message>
              </button>
            </li>
            %{--<li class="margin-top-medium margin-bottom-medium">--}%
            %{--<a class="btn-block btn btn-default btn-warning sidebar-button margin-bottom-medium" href="${createLink(action: 'importCSV')}">--}%
              %{--<g:message code="reference.import" default="Import References!"></g:message>--}%
            %{--</a>--}%
            %{--</li>--}%
          </g:if>
        </ul>
      </div>
      <div class="col-md-9 margin-top-large" role="main">
        <div class="bs-docs-section margin-top-xlarge margin-left-40">
        <div class="row margin-bottom-xlarge">
          <div class="col-lg-7 col-lg-offset-1">
            <g:form action="index" class="form-horizontal" enctype="multipart/form-data">
              <fieldset class="form">
                <div class="input-group">
                  <div class="input-group-btn">
                    <g:select id="category" name="category" from="${com.github.shinkchu.pubmgr.Category.findAllByTarget("reference")}"
                              optionKey="id"
                              noSelection="['': message(code: 'default.button.reference.query.category', default: '-期刊类别-')]"
                              value="${params.category}"
                              class="many-to-one btn btn-default height-40"/>
                  </div>
                  <input name="keyword" type="text" class="form-control height-40" value="${params.keyword}">
                  <span class="input-group-btn">
                    <g:submitButton name="${message(code: 'default.button.query.label', default: '查询')}"
                                    class="btn btn-default height-40"></g:submitButton>
                  </span>
                </div>
              </fieldset>
            </g:form>
          </div>

        <g:if test="${isAdmin}">
          <div class="edit-button-div">
            <div class="button pull-right margin-top-xlarge">
              %{--<a class="btn btn-success btn-lg button-bold" data-toggle="modal" data-target="#referenceCreateModal">--}%
              <a class="btn btn-success btn-lg button-bold" href="${createLink(controller: 'reference', action: 'create')}">
                <g:message code="default.reference.button.create.label" default="添加期刊"></g:message>
              </a>
            </div>
          </div>
        </g:if>
        </div>
      </div>
        <div>
          <div class="basic-title">
            ${category ? category : message(code: "default.navbar.reference", default: "期刊")}
          </div>

          <div class="basic-title-left"></div>
        </div>
        <div class="basic-content">
          <ul class="basic-ul">
            <g:each in="${referenceInstanceList}" status="i" var="referenceInstance">
              <li class="basic-li">
                <div class="row margin-top-medium margin-bottom-medium">
                  <div class="col-md-2">
                    <div class="img-thumbnail">
                      <g:if test="${referenceInstance.picture}">
                        <g:img dir="data" file="${referenceInstance.picture}" class="book-li-picture"></g:img>
                      </g:if>
                      <g:else>
                        <g:img dir="images" file="default-book-thumb.png" class="book-li-picture"></g:img>
                      </g:else>
                    </div>
                  </div>
                  <div class="col-md-10 margin-top-small margin-bottom-small">
                    %{--<a href="${createLink(controller: 'reference', action: 'show', id: referenceInstance.id)}" class="reference-li-title">--}%
                    <a class="book-li-title">
                      ${referenceInstance.title}
                    </a>
                    <g:if test="${referenceInstance.attachment}">
                      <a class="glyphicon glyphicon-file" href="${resource(dir: 'data', file: referenceInstance.attachment)}" target="_blank"></a>
                    </g:if>

                    <g:if test="${isAdmin}">
                      <a class="pull-right"
                         style="color: #b92c28; text-decoration: none;"
                         href="${createLink(action: 'delete', id: referenceInstance.id, params: [category: params.category])}" alt="Delete">X</a>
                    </g:if>

                    <div class="book-li-brief">
                      <strong>出版社：</strong> ${referenceInstance.authors} <br>
                      <strong>出版日期：</strong> ${referenceInstance.publishDate} <br>
                      <strong>期刊简介：</strong>
                      <div id="book-introduction-${i}">
                        <g:if test="${referenceInstance.introduction.length() > BOOK_ABSTRACT_MAX_LENGTH}">
                          <div class="book-introduction-full hidden">
                            <div>${referenceInstance.introduction}</div>
                            <a class="btn btn-info btn-xs book-introduction-more">
                              <g:message code="reference.index.show.less" default="less"></g:message>
                            </a>
                          </div>

                          <div class="book-introduction-part show">
                            <div>${referenceInstance.introduction.substring(0, BOOK_ABSTRACT_MAX_LENGTH) + '...'} </div>
                            <a class="btn btn-info btn-xs book-introduction-more">
                              <g:message code="reference.index.show.more" default="more"></g:message>
                            </a>
                          </div>
                        </g:if>
                        <g:else>
                          <div>${referenceInstance.introduction}</div>
                        </g:else>
                      </div>
                    </div>
                  </div>
                </div>
              </li>
            </g:each>
          </ul>


          %{--<div class="container">--}%
          <div>
            <g:if test="${params.category && params.keyword}">
              <g:set var="paramsMap" value="${[category: params.category, keyword: params.keyword]}"></g:set>
            </g:if>
            <g:elseif test="${params.category}">
              <g:set var="paramsMap" value="${[category: params.category]}"></g:set>
            </g:elseif>
            <g:elseif test="${params.keyword}">
              <g:set var="paramsMap" value="${[keyword: params.keyword]}"></g:set>
            </g:elseif>
            <g:paginate next="Forward" prev="Back" controller="reference" action="index" total="${referenceInstanceTotal}"  params="${paramsMap}"/>
          </div>
        </div>
    </div>
    </div>

    <g:if test="${isAdmin}">
      <div class="modal fade" id="newCategoryModal" tabindex="-1" role="dialog" aria-labelledby="newCategoryModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
                <span class="sr-only">关闭</span></button>
              <h4 class="modal-title" id="newCategoryModalLabel">
                <g:message code="category.new.label" default="添加类别!"></g:message>
              </h4>
            </div>

            <div class="modal-body">
              <g:form method="post" class="form-horizontal" controller="category" action="save">
                <g:set var="suborder" value="${com.github.shinkchu.pubmgr.Category.findAllByTarget(controllerName).suborder.max()}"/>
                <g:hiddenField name="target" value="${controllerName}"/>
                <g:hiddenField name="suborder" value="${suborder ? suborder + 1 : 1}"/>
                <div>
                  <fieldset class="form">
                    <div class="margin-bottom-xlarge">
                      <div class="margin-bottom-medium">
                        <div class="basic-title">
                          <g:message code="category.new.name.label" default="期刊类别"></g:message>
                        </div>
                        <div class="basic-title-left"></div>
                      </div>
                      <div>
                        <input name="name" type="text" class="form-control" placeholder="${message(code: 'category.new.name.label', default: "期刊类别名称")}">
                      </div>
                    </div>
                  </fieldset>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default btn-lg" data-dismiss="modal">${message(code: 'default.button.close.label', default: 'Close')}</button>
                  <g:actionSubmit class="btn btn-primary btn-lg" action="save" value="${message(code: 'default.button.submit.label', default: 'Submit')}"/>
                </div>
              </g:form>
            </div>
          </div>
        </div>
      </div>
    </g:if>
    <script>
      $('.book-introduction-more').on('click', function(e) {
        e.preventDefault();
        var parent = $(this).parent();
        parent.siblings().removeClass("hidden").addClass('show');
        parent.removeClass('show').addClass('hidden');
      });
    </script>
    </body>
</html>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

    %{--<g:set var="isAdmin" value="${session.user?.admin}"></g:set>--}%
    <g:set var="isAdmin" value="${true}"></g:set>
    <g:set var="BOOK_ABSTRACT_MAX_LENGTH" value="${77}"></g:set>

    <div class="row">
      <div class="col-md-3 margin-top-xlarge table-bordered left15">
        <ul class="nav">
          <li class="margin-top-medium margin-bottom-medium">
            <div class="sidebar-header">
              <div class="title">
                <g:message code="default.navbar.book" default="图书"/>
              </div>
            </div>

            <div class="clearfix"></div>
          </li>
          <g:each in="${bookCategories}" status="i" var="categoryInstance">
            <li class="margin-top-medium margin-bottom-medium">
              <div class="sidebar-subheader table-bordered ${categoryInstance.toString().equals(category) ? ' active' : ''}">
                <div class="title">
                  <a class="" href="${createLink(controller: 'book', action: 'index', params: [category: categoryInstance.id])}">
                    ${categoryInstance.name}
                  </a>
                </div>
              </div>
            </li>
          </g:each>

          <g:if test="${isAdmin}">
            <li class="margin-top-medium margin-bottom-medium">
              <button class="btn-block btn btn-default btn-success sidebar-button" data-toggle="modal" data-target="#newCategoryModal">
                <g:message code="category.new.label" default="New Category!"></g:message>
              </button>
            </li>
            %{--<li class="margin-top-medium margin-bottom-medium">--}%
            %{--<a class="btn-block btn btn-default btn-warning sidebar-button margin-bottom-medium" href="${createLink(action: 'importCSV')}">--}%
              %{--<g:message code="book.import" default="Import Books!"></g:message>--}%
            %{--</a>--}%
            %{--</li>--}%
          </g:if>
        </ul>
      </div>
      <div class="col-md-9 margin-top-large" role="main">
      <div class="bs-docs-section margin-top-xlarge margin-left-40">
        <div class="row margin-bottom-xlarge">
          <div class="col-lg-8 col-lg-offset-2">
            <g:form action="index" class="form-horizontal" enctype="multipart/form-data">
              <fieldset class="form">
                <div class="input-group">
                  <div class="input-group-btn">
                    <g:select id="category" name="category" from="${com.github.shinkchu.pubmgr.Category.findAllByTarget("book")}"
                              optionKey="id"
                              noSelection="['': message(code: 'default.button.book.query.category', default: '-图书类别-')]"
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
        </div>

        <g:if test="${isAdmin}">
          <div class="edit-button-div">
            <div class="button pull-right">
              %{--<a class="btn btn-success btn-lg button-bold" data-toggle="modal" data-target="#bookCreateModal">--}%
              <a class="btn btn-success btn-lg button-bold" href="${createLink(controller: 'book', action: 'create')}">
                <g:message code="default.button.create.label" default="Create"></g:message>
              </a>
            </div>
          </div>
        </g:if>
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
                <span class="sr-only">Close</span></button>
              <h4 class="modal-title" id="newCategoryModalLabel">
                <g:message code="category.new.label" default="New Category!"></g:message>
              </h4>
            </div>

            <div class="modal-body">
              <g:form method="post" class="form-horizontal" controller="category" action="save">
                <g:hiddenField name="target" value="${controllerName}"/>
                <div>
                  <fieldset class="form">
                    <div class="margin-bottom-xlarge">
                      <div class="margin-bottom-medium">
                        <div class="basic-title">
                          <g:message code="category.new.name.label" default="Category Name"></g:message>
                        </div>
                        <div class="basic-title-left"></div>
                      </div>
                      <div>
                        <input name="name" type="text" class="form-control" placeholder="${message(code: 'category.new.name.label')}">
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
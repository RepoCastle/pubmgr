<html>

<head>
    <title><g:message code="default.welcome.title"/></title>
    <meta name="layout" content="main"/>
</head>

<body>
<g:set var="isAdmin" value="${true}"></g:set>
%{--<g:set var="isAdmin" value="${session.user?.admin}"></g:set>--}%
<g:if test="${isAdmin}">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true"></span>
                    <span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title" id="introEditModalLabel">
                    <g:message code="default.welcome.title"/>
                </h4>
            </div>

            <div class="modal-body">
                <g:form method="post" class="form-horizontal">
                    <g:hiddenField name="id" value="${introductionInstance?.id}"/>
                    <g:hiddenField name="version" value="${introductionInstance?.version}"/>
                    <div>
                        <fieldset class="form">
                            <ckeditor:editor name="content" height="400px" width="80%">
                                ${introductionInstance?.content}
                            </ckeditor:editor>
                        </fieldset>
                    </div>
                    <div class="modal-footer">
                        <g:actionSubmit class="btn btn-primary btn-lg" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</g:if>

</body>

</html>

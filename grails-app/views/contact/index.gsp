<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'contact.label', default: 'Contact')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    <section id="contact">
        <div class="lead">
        %{--<div class="container">--}%
            <g:set var="contactInstance" value="${com.github.shinkchu.pubmgr.Contact.count>0 ? com.github.shinkchu.pubmgr.Contact.all.get(0) : null}"></g:set>
            <g:if test="${contactInstance}">
                <div class="row">
                    <div class="col-md-5">
                        <p class="text-right"><strong><g:message code="contact.organization.label" default="Organization"></g:message>：</strong></p>
                    </div>
                    <div class="col-md-7">
                        <p class="text-left">${contactInstance?.organization}</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5">
                        <p class="text-right"><strong><g:message code="contact.address.label" default="Address"></g:message>：</strong></p>
                    </div>
                    <div class="col-md-7">
                        <p class="text-left">${contactInstance?.address}</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5">
                        <p class="text-right"><strong><g:message code="contact.contacts.label" default="Contacts"></g:message>：</strong></p>
                    </div>
                    <div class="col-md-7">
                        <p class="text-left">${contactInstance?.contacts}</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5">
                        <p class="text-right"><strong><g:message code="contact.phone.label" default="Phone No."></g:message>：</strong></p>
                    </div>
                    <div class="col-md-7">
                        <p class="text-left">${contactInstance?.phone}</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5">
                        <p class="text-right"><strong><g:message code="contact.email.label" default="email"></g:message>：</strong></p>
                    </div>
                    <div class="col-md-7">
                        <p class="text-left">${contactInstance?.email}</p>
                    </div>
                </div>
            </g:if>

            <div class="actions" style="margin-top: 10px;">
                <a href="${createLink(uri: '/')}" class="btn btn-large btn-primary" style="text-decoration: none;">
                    <i class="icon-chevron-left icon-white"></i>
                    <g:message code="error.button.backToHome" default="返回首页"/>
                </a>
            </div>
            %{--</div>--}%
        </div>
    </section>
    </body>
</html>
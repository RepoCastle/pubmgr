<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="main"/>
  <title><g:message code="default.welcome.title"/></title>
</head>

<body>
<g:set var="isAdmin" value="${true}"></g:set>
%{--<g:set var="isAdmin" value="${session.user?.admin}"></g:set>--}%
<section id="intro">
<div class="content">
  <div>
    ${introductionInstance?.content?.decodeHTML()}
  </div>

  <g:if test="${isAdmin}">
    <div class="button pull-right edit-button-div">
      <a class="btn btn-warning btn-lg button-bold"
         href="${createLink(controller: 'introduction', action: 'edit', id: introductionInstance?.id)}">
        <g:message code="default.button.edit.label" default="Edit"></g:message>
      </a>
    </div>
  </g:if>
</div>
</section>
</body>
</html>
<!doctype html>
<html lang="en" class="no-js">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <title>
    <g:layoutTitle default="${meta(name: 'app.name')}"/>
  </title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>

  <asset:stylesheet src="application.css"/>
  <asset:stylesheet src="custom.css"/>

  <g:layoutHead/>
</head>

<body>
  <g:if test="${pageProperty(name: 'page.header')}">
    <g:pageProperty name="page.header"/>
  </g:if>
  <g:else>
    <g:render template="/layouts/header"/>
  </g:else>

  <g:render template="/layouts/navbar"/>
  <g:render template="/layouts/content"/>

  <g:if test="${pageProperty(name: 'page.footer')}">
    <g:pageProperty name="page.footer"/>
  </g:if>
  <g:else>
    <g:render template="/layouts/footer"/>
  </g:else>

  <asset:javascript src="application.js"/>
</body>
</html>

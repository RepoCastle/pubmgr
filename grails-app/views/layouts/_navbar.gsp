<nav id="Navbar" class="navbar navbar-fixed-top navbar-inverse" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <div class="navbar-sep"></div>
      <a class="navbar-brand${params.controller == "introduction" ? " active" : " default"}" href="${createLink(uri: '/')}">
        <g:message code="default.navbar.home" default="首页"/>
      </a>

      <div class="navbar-sep"></div>
      <a class="navbar-brand${params.controller == "book" ? " active" : " default"}" href="${createLink(uri: '/book')}">
        <g:message code="default.navbar.book" default="图书"/>
      </a>

      <div class="navbar-sep"></div>
      <a class="navbar-brand${params.controller == "reference" ? " active" : " default"}" href="${createLink(uri: '/reference')}">
        <g:message code="default.navbar.reference" default="期刊"/>
      </a>

      <div class="navbar-sep"></div>
      <a class="navbar-brand${params.controller == "researcher" ? " active" : " default"}" href="${createLink(uri: '/researcher')}">
        <g:message code="default.navbar.researcher" default="研究人员"/>
      </a>

      <div class="navbar-sep"></div>
      <a class="navbar-brand${params.controller == "organization" ? " active" : " default"}" href="${createLink(uri: '/organization')}">
        <g:message code="default.navbar.organization" default="网站链接"/>
      </a>

      <div class="navbar-sep"></div>
      <a class="navbar-brand${params.controller == "contact" ? " active" : " default"}" href="${createLink(uri: '/contact')}">
        <g:message code="default.navbar.contact" default="联系我们"/>
      </a>

    </div>

    <g:if test="${session.user?.admin}">
      <div class="pull-right padding-right-xlarge">
        <a class="navbar-brand${params.controller == "user" ? " active" : " default"}" style="font-weight: bold;" href="${createLink(controller: 'user', action: 'show', id: session.user?.id)}">
          <g:message code="default.welcome.user" args="[session.user]" default="Welcome"/>
        </a>
      </div>
    </g:if>
  </div>
</nav>

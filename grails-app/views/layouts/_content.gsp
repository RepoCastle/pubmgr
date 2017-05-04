<div id="Content" class="container">
	<g:if test="${flash.message && !layout_noflashmessage}">
		<div class="alert alert-info">${flash.message}</div>
	</g:if>

	<g:layoutBody />
	<g:pageProperty name="page.body" />
</div>

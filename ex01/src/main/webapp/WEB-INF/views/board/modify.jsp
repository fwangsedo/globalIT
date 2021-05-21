<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/header.jsp"></jsp:include>
<!-- header 끝------------------------------------------------------------------------------ -->
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			<form action="/board/modify" method="post">
			<input type="hidden" value="${cri.pageNum}" name="pageNum">
			<input type="hidden" value="${cri.amount}" name="amount">
			<input type="hidden" value="${cri.type}" name="type">
			<input type="hidden" value="${cri.keyword}" name="keyword">
					<div class="form-group">
						<label>Bno</label><input class="form-control" name="bno" readonly="readonly"
						value='<c:out value="${board.bno}"/>'>
					</div>
					<div class="form-group">
						<label>Title</label><input class="form-control" name="title"
						value='<c:out value="${board.title}"/>'>
					</div>
					<div class="form-group">
						<label>Content</label>
						<textarea class="form-control" rows="3" name="content"><c:out value="${board.content}"/></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label><input class="form-control" name="writer" 
						value='<c:out value="${board.writer}"/>'>
					</div>
					<div class="form-group">
						<label>RegDate</label><input class="form-control"
						value='<c:out value="${board.regdate}"/>' readonly="readonly">
					</div>
					<button type="submit" data-oper="modify" class="btn btn-info">Modify</button>
					<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
					<button type="submit" data-oper="list" class="btn btn-success">List</button>
				<!-- /.table-responsive -->
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- /.row -->

<!-- footer시작 ----------------------------------------------------------- -->
<jsp:include page="../includes/footer.jsp"></jsp:include>


</body>
<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form");
	$('button').on("click", function(e){
		e.preventDefault();
	var operation = $(this).data("oper");
	console.log(operation);
	if(operation === 'remove'){
		formObj.attr("action","/board/remove");
	}else if(operation === 'list'){
		formObj.attr("action", "/board/list").attr("method", "get");
		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amount']").clone();
		var typeTag = $("input[name='type']").clone();
		var keyWordTag = $("input[name='keyword']").clone();
		formObj.empty();
		formObj.append(pageNumTag); formObj.append(amountTag);
		formObj.append(typeTag); formObj.append(keyWordTag);
	}
	formObj.submit();
	});
});
</script>
</html>

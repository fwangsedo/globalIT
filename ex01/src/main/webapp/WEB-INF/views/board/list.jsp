<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp"></jsp:include>
<!-- header 끝------------------------------------------------------------------------------ -->
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board List Page</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시판<br>총 ${count}개의 게시글이 있습니다.
			<button id="regBtn" type="button" class="btn btn-xs pull-right">새로운 글쓰기</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%"
					class="table table-striped table-bordered table-hover"
					><!-- id="dataTables-example" -->
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="lists" items="${list}" varStatus="status">
							<tr>
								<td>${lists.bno }</td>
								<td><a class="move" href='<c:out value="${lists.bno}"/>'>${lists.title }[${lists.replyCnt}]</a></td>
								<td>${lists.writer }</td>
								<td><fmt:formatDate value="${lists.regdate }"/></td>
								<td>${lists.updateDate }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="pull-right">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
						<a href="${pageMaker.startPage-1}">Previous</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.cri.pageNum==num?"active" : ""}">
							<a href="${num}">${num}</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next">
							<a href="${pageMaker.endPage+1}">Next</a></li>
						</c:if>
					</ul>
				</div>
				<div class="row">
				<div class="col-lg-12">
				
				<form id="actionForm" action="/board/list" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<input type="hidden" name="type" value="${pageMaker.cri.type}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
				</form>
				
				<form id="searchForm" action="/board/list" method="get">
					<select name="type">
						<option value="" <c:out value="${pageMaker.cri.type==null?'selected':'' }"/>>-------</option>
						<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
						<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
						<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
						<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목or내용</option>
						<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목or작성자</option>
						<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목or작성자or내용</option>
					</select>
					<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<button class="btn btn-info">Search</button>
				</form>
				</div>
				</div>
				<!-- /.table-responsive -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModellabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary"
									data-dismiss="modal">Save Changes</button>
							</div>
						</div>
						<!-- /.model-content -->
					</div>
					<!-- /.model-dialog -->
				</div>
				<!-- /.model-fade -->
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

<script type="text/javascript">
$(document).ready(function(){
	var result='<c:out value="${result}"/>'; 
	checkModal(result);
	
	history.replaceState({},null,null);
	
	function checkModal(result){
		if(result==='' || history.state){
			return;
		}
		if(parseInt(result)>0){
			$(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.");
		}
		$("#myModal").modal("show");
	}
	
});

var actionForm = $("#actionForm");
$(".paginate_button a").on("click", function(e){
	e.preventDefault();
	console.log('click');
	actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	actionForm.submit();
});

$("#regBtn").on("click",function(){
	self.location = "/board/register";
});

$(".move").on("click", function(e){
	e.preventDefault();
	actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
	actionForm.attr("action", "/board/get");
	actionForm.submit();
	console.log($(this).attr('href'));
});

var searchForm = $("#searchForm");
$("#searchForm button").on("click", function(e){
	if(!searchForm.find("option:selected").val()){
		alert("검색종류를 선택하세요.");
		return false;
	}
	if(!searchForm.find("input[name='keyword']").val()){
		alert("검색어를 입력하세요.")
		return false;
	}
	searchForm.find("input[name='pageNum']").val("1");
	e.preventDefault();
	searchForm.submit();
});
</script>
</body>

</html>

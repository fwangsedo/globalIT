<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="../include/header.jsp" />

<script type="text/javascript">
	$(document).ready(function() {
		var result = '<c:out value="${result}"/>'; //모달 보여주기 추가
	
	checkModal(result);
	
	function checkModal(result){
		if (result ==='' || history.state){
			return;
		}
		if(parseInt(result) > 0){
			$(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다.")
		}
		$("#myModal").modal("show");
	}
	});
	</script>

<!--header 끝 --------------------------------------------- -->
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글 목록
				<button id='regBtn' type="button" class="btn btn-xs pull-right">글쓰기</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%"
					class="table table-striped table-bordered table-hover"
					id="dataTables-example">
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
						<c:forEach items="${list}" var="l">
							<tr>
								<td>${l.bno}</td>
								<%-- <td><a href="/board/get?bno=${l.bno }">${l.title}</a></td> --%>
								<td><a class="move" href='<c:out value="${l.bno }"/>'><c:out value="${l.title }"/></a></td>
								<td>${l.writer}</td>
								<td>${l.regdate}</td>
								<td>${l.updateDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class='pull-right'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous"><a href="${pageMaker.startPage-1 }">Previous</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.cri.pageNum==num?"active":""}">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next"><a href="${pageMaker.endPage+1 }">Next</a></li>
						</c:if>
					</ul>
				</div><!-- pagination -->
				<form id="actionForm" action="/board/list" method='get'>
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"> 
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				</form>
				
				
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModallabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">$times;</button>
								<h4 class="modal-title id='myModalLabel'">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">Save Changes</button>
						</div>
					</div>
					<!-- /. modal-content -->
				</div>
				<!-- /. modal-dialog -->
			</div>
			<!-- /. modal fade -->

		</div>
		<!-- footer시작 -->
		<jsp:include page="../include/footer.jsp" />

		<script type="text/javascript">	
			$("#regBtn").on("click",function(){
				self.location = "/board/register";
			}); //버튼 클릭시 등록창으로 이동
			
			var actionForm = $("#actionForm");
			$(".paginate_button a").on("click", function(e){
				e.preventDefault();
				console.log('click');
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
			
			$(".move").on("click",function(e){
				e.preventDefault();
				actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href")+"'>");
				actionForm.attr("action", "/board/get");
				actionForm.submit();
			});
			</script>
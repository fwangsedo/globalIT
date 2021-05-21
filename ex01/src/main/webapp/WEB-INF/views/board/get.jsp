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
				<div class="form-group">
					<label>Bno</label><input class="form-control" name="bno"
						readonly="readonly" value='<c:out value="${board.bno}"/>'>
				</div>
				<div class="form-group">
					<label>Title</label><input class="form-control" name="title"
						readonly="readonly" value='<c:out value="${board.title}"/>'>
				</div>
				<div class="form-group">
					<label>Content</label>
					<textarea class="form-control" rows="3" name="content"
						readonly="readonly"><c:out value="${board.content}" /></textarea>
				</div>
				<div class="form-group">
					<label>Writer</label><input class="form-control" name="writer"
						readonly="readonly" value='<c:out value="${board.writer}"/>'>
				</div>
				<button data-oper="modify" class="btn btn-success">Modify</button>
				<button data-oper="list" class="btn btn-primary">List</button>
				<form id="openForm" action="/board/modify" method="get">
					<input type="hidden" id="bno" name="bno"
						value='<c:out value="${board.bno}"/>'> <input
						type="hidden" name="pageNum"
						value='<c:out value="${cri.pageNum}"/>'> <input
						type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
					<input type="hidden" name="type" value="${cri.type}"> <input
						type="hidden" name="keyword" value="${cri.keyword}">
				</form>
				<!-- /.table-responsive -->

			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comment fa-fw"></i>Reply
				<button id="addReplyBtn" class="btn btn-primary">댓글 작성하기</button>
			</div>
			<div class="panel-body">
				<ul class="chat">
				   <!-- <li class="left clearfix" data-rno="12">
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong> <small
									class="pull-right text-muted">2021-05-01 13:13</small>
							</div>
							<p>Good job</p>
						</div> -->
				</ul>
				<div class="panel-footer"></div>
			</div>
			
		</div>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- modal -->
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModellabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal"
                     aria-hidden="true">&times;</button>
                  <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
               </div>
               <div class="modal-body">
                  <div class="form-froup">
                     <label>Reply</label> <input class="form-control" name='reply'
                        value='New Reply!!!'>
                  </div>
                  <div class="form-froup">
                     <label>Replyer</label> <input class="form-control" name='replyer'
                        value='Replyer'>
                  </div>
                  <div class="form-froup">
                     <label>ReplyDate</label> <input class="form-control" name='replyDate'
                        value=''>
                  </div>
               </div>
               <!-- /.modal-body -->
               <div class="modal-footer">
                  <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
                  <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
                  <button id='modalRegisterBtn' type="button"
                     class="btn btn-success">Register</button>
                  <button id='modalCloseBtn' type="button" class="btn btn-default">close</button>
               </div>
            </div>
            <!-- /.model-content -->
         </div>
         <!-- /.model-dialog -->
      </div>
      <!--/. modal -->


<!-- /.row -->

<!-- footer시작 ----------------------------------------------------------- -->
<jsp:include page="../includes/footer.jsp"></jsp:include>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		
		/* replyService.getList(
				{bno: bnoValue, page: 1}
				,function(list){
					for(var i=0, len=list.length||0; i<len; i++){
						console.log(list[i]);
					}
				}); */
		
		/* replyService.remove(
				29, function(count){
					console.log(count);
					if(count==="success"){alert("REMOVED");}
				}, function(err){
					alert('error occured..');
				});  */
				
		/* replyService.update({
			rno:8,
			bno:bnoValue,
			reply:"modified reply......"
		}, function(result){
			alert("수정완료");
		});	 */	
				
		/* replyService.get(6, function(data){
			console.log(data);
		});
				
		console.log(bnoValue);
		replyService.add(
		{reply:"JS TEST", replyer:"js tester", bno: bnoValue},
		function(result){
			/* alert("RESULT : "+ result); 
		});
		console.log(replyService); */
		
		var modal = $('.modal');
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $('#modalModBtn');
		var modalRemoveBtn = $('#modalRemoveBtn');
		var modalRegisterBtn = $('#modalRegisterBtn');
		
		$('#addReplyBtn').on('click', function(e){
			modal.find('input').val('');
			modalInputReplyDate.closest("div").hide();
			modal.find('button[id!="modalCloseBtn"]').hide();
			//date는 보여줄 필요가 없으니 hide시킴
			modalRegisterBtn.show();
			$('.modal').modal("show");
		});
		
		modalRegisterBtn.on('click', function(e){
			var reply={
					reply:modalInputReply.val(),
					replyer: modalInputReplyer.val(),
					bno: bnoValue
			};
			replyService.add(reply,function(result){
				alert(result);
				modal.find('input').val('');
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		
		var replyUL = $(".chat");
		showList(-1);
		function showList(page){
			replyService.getList(
			{bno:bnoValue, page:page||1}
			,function(replyCnt ,list){
				console.log("replyCnt : "+replyCnt);
				console.log("list : "+list);
				if(page==-1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
				}
				var str = "";
				if(list == null || list.length == 0){
					return;
				}
				for(var i=0, len=list.length||0; i<len; i++){
					str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str+="<div><div class='header'><strong class='primary-font'>"+
						list[i].replyer+"</strong>";
					str+="<small class='pull-right text-muted'>"+
					replyService.displayTime(list[i].replyDate)+"</small></div>";
					str+="<p>"+list[i].reply+"</p></div></li>";
				}
				replyUL.html(str);
				showReplyPage(replyCnt);
			});
		};
		
		$(".chat").on("click","li",function(e){
	         var rno=$(this).data("rno");
	         console.log(rno);
	         
	         replyService.get(rno,function(reply){
	            modalInputReply.val(reply.reply);
	            modalInputReplyer.val(reply.replyer);
	            modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
	            .attr("readonly","readonly");
	            modal.data("rno",reply.rno);
	            
	            modal.find("button[id!='modalCloseBtn']").hide();
	            modalModBtn.show();
	            modalRemoveBtn.show();
	            $(".modal").modal("show");
	         
	      });
	   });

		modalModBtn.on('click', function(e){
			var reply = {rno:modal.data('rno'), reply:modalInputReply.val()};
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		modalRemoveBtn.on('click', function(e){
			var rno = modal.data('rno');
			replyService.remove(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		var pageNum = 1;
		var replyPageFooter = $('.panel-footer');
		function showReplyPage(replyCnt){
			console.log("showReplyPage : "+replyCnt);
			var endNum = Math.ceil(pageNum/10.0)*10;
			var startNum = endNum-9;
			var prev = startNum!=1;
			var next = false;
			if(endNum*10>=replyCnt){endNum = Math.ceil(replyCnt/10.0);}
			if(endNum*10<replyCnt){next = true;}
			var str = "<ul class='pagination pull-right'>";
			if(prev){
				str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
			}
			for(var i=startNum; i<=endNum; i++){
				var active = pageNum == i?"active":"";
				str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			if(next){
				str += "<li class='page-item'<a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
			}
			str += "</ul></div>";
			console.log(str); replyPageFooter.html(str);
		};
		
		replyPageFooter.on("click","li a", function(e){
			e.preventDefault();
			console.log("page click");
			var targetPageNum = $(this).attr('href');
			console.log("targetPageNum : "+ targetPageNum);
			pageNum = targetPageNum;
			showList(pageNum)
		});
		
		var openForm = $("#openForm");
		$("button[data-oper='modify']").on("click", function(e){
			openForm.attr("action", "/board/modify").submit();
		});
		$("button[data-oper='list']").on("click",function(e){
			openForm.find("#bno").remove();
			openForm.attr("action", "/board/list");
			openForm.submit();
		});
	});
</script>

</body>

</html>
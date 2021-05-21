<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="../include/header.jsp"/>

        <!--header 끝 --------------------------------------------- -->
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
                        <div class="panel-heading">
                           Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div>
                        <div class="panel-body">
                        
                         <div class="form-group">
                         <label>Bno</label><input class="form-control" name="bno" value='<c:out value="${board.bno}"/>'readonly="readonly">
                         </div>
                         <div class="form-group">
                         <label>Title</label><input class="form-control" name='title' value='<c:out value="${board.title}"/>' readonly="readonly">
                         </div>
                         <div class="form-group">
                         	<label>Content</label><textarea class="form-control" row="3" name='content' readonly="readonly"><c:out value="${board.content}"/></textarea>
                         </div>
	                         <div class="form-group">
	                           <label>Writer</label>
	                           <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
	                        </div>     
                     
		                     <button data-oper='modify' class="btn btn-warning">Modify</button>
		                     <button data-oper='list' class="btn btn-success">List</button>
                     
	                       <form id="operForm" action="/board/modify" method="get">
	                       		<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
	                       		<input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	                       		<input type='hidden' id='amount' name='amount' value='<c:out value="${cri.amount}"/>'>
	                       		<input type="hidden" name="type" value="${cri.type }"/>
								<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'/>
                       		</form>
            			</div>
            		</div>
            	</div><!-- panel...... -->
            	
            	<div class="panel panel-default">
            		<div class="panel-heading">
            			<i class="fa fa-comments fa-fw"></i>Reply
            				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">new Reply</button>
            		</div>
            		<div class="panel-body">
            			<ul class="chat">
            				<!-- <li class="left clearfix" data-rno="12">
            					<div>
            						<div class="header">
            							<strong class="primary-font">댓글단사람자리</strong>
            							<small class="pull-right text-muted">댓글단날짜</small>
            						</div>
            						<p>댓글내용</p>
            					</div>
            				</li> -->
            			</ul>
            		</div>
            		<div class="panel-footer">
            			
            		</div>
            	</div><!-- reply panel -->
            	<!-- Modal -->
				<div class = "modal fade" id = "MyModal" tabindex = "-1" role = "dialog"
					aria-labelledby = "myModalLabel" aria-hidden = "true">
					<div class = "modal-dialog">
						<div class = "modal-content">
							<div class = "modal-header">
								<button type = "button" class = "close" data-dismiss = "modal"
									ari-hidden = "true">&times;</button>
								<h4 class = "modal-title" id = "myModalLabel">REPLY MODAL</h4>
							</div>
							<div class = "modal-body">
								<div class = "form-group">
									<label>Reply</label>
									<input class = "form-control" name = 'reply' value = 'New Reply!!!!'>
								</div>
								<div class = "form-group">
									<label>Replyer</label>
									<input class = "form-control" name = 'replyer' value = 'replyer'>
								</div>
								<div class = "form-group">
									<label>Reply Date</label>
									<input class = "form-control" name = 'replyDate' value = ''>
								</div>
							</div>
						<div class = "modal-footer">
							<button id = 'modalModBtn' type = "button" class = "btn btn-warning">Modify</button>
							<button id = 'modalRemoveBtn' type = "button" class = "btn btn-danger">Remove</button>
							<button id = 'modalRegisterBtn' type = "button" class = "btn btn-primary">Register</button>
							<button id = 'modalCloseBtn' type = "button" class = "btn btn-default">Close</button>
						</div>
						</div>
					</div>
					</div><!-- modal -->
            </div>
			<script type="text/javascript">
			 $(document).ready(function(){
				 console.log(replyService);
				 var pageNum=1;
				 
				 var bnoValue = '<c:out value="${board.bno}"/>';
				 /* replyService.add(
						 {reply:"JS TEST", replyer:"테스트하는사람...", bno:bnoValue}, function(result){
							  alert("result : " + result); 
						 }); */
						 
				var replyURL = $(".chat");
				showList(1);
				
				function showList(page){
					replyService.getList( {bno:bnoValue, page: page||1}
					, function(replyCnt, list){
						console.log("replyCnt:" + replyCnt);
						console.log("list!"+list);
						if(page===-1){
							pageNum=Math.ceil(replyCnt/10.0);
							showList(pageNum);
							return;
						}
						
						var str = "";
						if(list == null || list.length ==0) {
							replyURL.html("");
							return;
						}
						for(var i=0, len = list.length || 0; i<len; i++){
							str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
							str += "<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
							str +="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small>"
							str +="</div><p>"+list[i].reply+"</p></div></li>"
						}
						replyURL.html(str);
						showReplyPage(replyCnt);
					});//function call
					
					
				}//showList
				
				var modal = $(".modal");
				var modalInputReply = modal.find("input[name='reply']");
				var modalInputReplyer = modal.find("input[name='replyer']");
				var modalInputReplyDate = modal.find("input[name='replyDate']");

				var modalModBtn = $("#modalModBtn");
				var modalRemoveBtn = $("#modalRemoveBtn");
				var modalRegisterBtn = $("#modalRegisterBtn");

				$('#addReplyBtn').on("click", function(e) {
					modal.find("input").val("");
					modalInputReplyDate.closest("div").hide();
					modal.find("button[id !='modalCloseBtn']").hide();
					modalRegisterBtn.show();

				    $(".modal").modal("show");
				});
				
				//pageReply Start
				replyPageFooter = $(".panel-footer");
				console.log("여기.."+replyPageFooter);
				function showReplyPage(replyCnt){
					console.log("여기..??");	
					console.log("showReplyPage : " + replyCnt);
					var endNum = Math.ceil(pageNum/10.0)*10;
					var startNum = endNum -9;
					var prev = startNum !=1;
					var next = false;
					if(endNum*10 >=replyCnt){
						endNum=Math.ceil(replyCnt/10.0);
					}
					if(endNum*10<replyCnt){ next=true;}
					var str = "<ul class='pagination pull-right'>";
					
					if(prev){
						str+= "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
					}
					for(var i=startNum; i<=endNum; i++){
						var active = pageNum==i ? "active":"";
						/* str += "이거안나오냐!"; */
						str += "<li class='page-item"+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
					}
					if(next){
						str += "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
					}
					str += "</ul></div>";
					console.log(str);
					replyPageFooter.html(str);
				}
				
				modalRegisterBtn.on("click", function(e){
					var reply = {
							reply : modalInputReply.val(),
							replyer : modalInputReplyer.val(),
							bno : bnoValue
					};
					
					replyService.add(reply, function(result){
						alert(result);
					
						modal.find("input").val("");
						modal.modal("hide");
						showList(1);
					});
				});//댓글 register버튼 호출시
				
				modalModBtn.on("click", function(e){
					var reply={rno:modal.data("rno"), reply:modalInputReply.val()};
					replyService.update(reply, function(result){
						alert(result);
						modal.modal("hide");
						showList(pageNum);
					});
				});//update버튼 호출시
				
				modalRemoveBtn.on("click", function(e){
					var rno = modal.data("rno");
					replyService.remove(rno, function(result){
						alert(result);
						modal.modal("hide");
						showList(pageNum);
					});
				});//remove버튼 호출시
				
				replyPageFooter.on("click", "li a", function(e){
					e.preventDefault();
					console.log("page click");
					var targetPageNum = $(this).attr("href");
					console.log("targetPageNum : " + targetPageNum);
					pageNum = targetPageNum;
					showList(pageNum);
				});//page 번호 클릭시 새로운 댓글 출력
				
				$(".chat").on("click", "li", function(e){
					var rno = $(this).data("rno");
					replyService.get(rno, function(reply){
						modalInputReply.val(reply.reply);
						modalInputReplyer.val(reply.replyer);
						modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
						modal.data("rno", reply.rno);
						
						modal.find("button[id!='modalCloseBtn']").hide();
						modalModBtn.show();
						modalRemoveBtn.show();
						$(".modal").modal("show");
					});
					console.log(rno);
				});

				replyService.getList(
					{bno: bnoValue, page:1}, 
					function(list){
					for(var i = 0, len = list.length||0; i<len; i++){
						 console.log(list[i]);
					}
				});//getList
				
				/* replyService.remove(7,
					function(count){
						console.log(count);
						if(count==="success"){ alert("remove!!");}
					}, function(err){
						alert("error.............TT");
					}
				);//remove */
				
				/* replyService.update({
					rno : 8
					, bno : bnoValue
					, reply: "바꿔버리기~"					
				}
				, function(result){
					alert("수정함!");
				}); */
				
				/* replyService.get(15, function(data){
					console.log(data);
				}); */
				 
				 var operForm = $("#operForm");
				 $('button[data-oper="modify"]').on("click", function(e){
					 operForm.attr("action", "/board/modify").submit();
				 });
				 $('button[data-oper="list"]').on("click", function(e){
					operForm.find('#bno').remove();
				    operForm.attr("action","/board/list");
				    operForm.submit();
				 });
			 });
			
			</script>
			<script type="text/javascript" src="/resources/js/reply.js"></script>
            <!-- footer시작 -->
      <jsp:include page="../include/footer.jsp"/>
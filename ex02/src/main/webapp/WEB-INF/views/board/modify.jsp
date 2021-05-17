<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


<jsp:include page="../include/header.jsp"/>
	<script>
	$(document).ready(function() {
	var formObj = $("form");
	 $('button').on("click", function(e){
		 e.preventDefault();
		 var operation = $(this).data("oper");
		 console.log(operation);
		 if(operation === 'remove'){
			 formObj.attr("action","/board/remove");
		 }else if(operation === "list"){
			 //move to list
			 formObj.attr("action", "/board/list").attr("method", "get");
			 var pageNumTag = $("input[name='pageNum']").clone();
			 var amountTag = $("input[name='amount']").clone();
			 var keywordTag = $("input[name='keyword']").clone();
			 var typeTag = $("input[name='type']").clone();
			 formObj.empty();
			 formObj.append(pageNumTag);
			 formObj.append(amountTag);
			 formObj.append(keywordTag);
			 formObj.append(typeTag);
		 }
		 
		 formObj.submit();
	 });
	});
	 
	 
	</script>
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
                        
                        <form role="form" action="/board/modify" method="post">
                         <div class="form-group">
                         <label>Bno</label><input class="form-control" name="bno" value='<c:out value="${board.bno}"/>'readonly="readonly">
                         </div>
                         <div class="form-group">
                         <label>Title</label><input class="form-control" name='title' value='<c:out value="${board.title}"/>'>
                         </div>
                         <div class="form-group">
                         <label>Content</label><textarea class="form-control" row="3" name='content'><c:out value="${board.content}"/>
                         </textarea></div>
                             <div class="form-group">
                           <label>Writer</label>
                           <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>'>
                        </div>     
                        <div class="form-group">
                         <label>Regdate</label><input class="form-control" name='regdate' value='<c:out value="${board.regdate}"/>'readonly="readonly">
                         </div>
                         <div class="form-group">
                         <label>UpdateDate</label><input class="form-control" name='updateDate' value='<c:out value="${board.updateDate}"/>' readonly="readonly">
                         </div>
                         
                         <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                         <input type="hidden" name="amount" value='<c:out value='${cri.amount }'/>'>
                         <input type="hidden" name="type" value="${cri.type }"/>
						 <input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'/>
						 
                         <button type="submit" data-oper='modify' class="btn btn-info">Modify</button>
                         <button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
                         <button type="submit" data-oper='list' class="btn btn-success">List</button>
                     
                     </form>
                       
            </div>
            </div>
            </div>
            </div>

            <!-- footer시작 -->
      <jsp:include page="../include/footer.jsp"/>
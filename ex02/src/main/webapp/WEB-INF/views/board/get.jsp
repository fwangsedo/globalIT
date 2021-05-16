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
                         <label>Content</label><textarea class="form-control" row="3" name='content' readonly="readonly"><c:out value="${board.content}"/>
                         </textarea></div>
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
                       </form>
            </div>
            </div>
            </div>
            </div>
			<script type="text/javascript">
			 $(document).ready(function(){
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
            <!-- footer시작 -->
      <jsp:include page="../include/footer.jsp"/>
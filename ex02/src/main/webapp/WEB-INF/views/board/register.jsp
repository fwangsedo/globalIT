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
                        <div class="panel-body">
                         <form role="form" action="/board/register" method="post">
                         <div class="form-group">
                         <label>Title</label><input class="form-control" name='title'>
                         </div>
                         <div class="form-group">
                         <label>Content</label><textarea class="form-control" rows='3' name='content'>
                         </textarea></div>
                             <div class="form-group">
                           <label>Writer</label>
                           <input class="form-control" name="writer">
                        </div>     
                         <button type="submit" class="btn btn-default">Submit</button>
                         <button type="reset" class="btn btn-default">Reset</button>
                         </form>   
            </div>
            </div>
            </div>
            </div>

            <!-- footer시작 -->
      <jsp:include page="../include/footer.jsp"/>
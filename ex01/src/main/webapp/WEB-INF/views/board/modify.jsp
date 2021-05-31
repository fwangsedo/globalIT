<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<style>
.uploadResult{
width:100%;
background-color: #ddd;
}
.uploadResult ul{
display: flex;
flex-flow: row;
justify-content: center;
align-items: center;
}
.uploadResult ul li{
list-style: none;
padding: 10px;
}
.uploadResult ul li img{
width:20px;
}
.uploadResult ul li span{
color: white;
}
.bigPictureWrapper{
position: absolute;
display: none;
justify-content: center;
align-items: center;
top:0%;
width:100%;
height:100%;
background-color: gray;
z-index: 100;
background: rgba(225,225,225,0.5);
}
.bigPicture{
position: relative;
display: flex;
justify-content: center;
align-items: center;
}
.bigPicture img{
width:400px;
}
</style>


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
						value='<c:out value="${board.writer}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>RegDate</label><input class="form-control"
						value='<c:out value="${board.regdate}"/>' readonly="readonly">
					</div>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<sec:authentication property="principal" var="pinfo"/>
						<sec:authorize access="isAuthenticated()">
							<c:if test="${pinfo.username eq board.writer}">
					<button type="submit" data-oper="modify" class="btn btn-info">Modify</button>
					<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
							</c:if>
						</sec:authorize>
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

<div class="bigPictureWrapper">
			<div class="bigPicture"></div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-info">
					<div class="panel-heading">File List</div>
					<div class="panel-body">
					<input type="file" name="uploadFile" multiple="multiple">
						<div class="uploadResult">
							<ul>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

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
	}else if(operation === 'modify'){
		console.log("submitClicked");
		var str = "";
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj);
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		})
		formObj.append(str);
	}
	formObj.submit();
	});
	
	$(".uploadResult").on("click", "button",function(e){
		if(confirm("이 파일을 삭제하시겠습니까?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	
	var bno = '<c:out value="${board.bno}"/>';
	$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
		console.log(arr);
	
	var str = "";
	$(arr).each(function(i,obj){
		if(!obj.fileType){
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
			str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+
			obj.fileName+"' data-type='"+obj.fileType+"'><div>";
			str += "<span>"+obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+ 
			"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/resources/images/attach.png'></a>";
			str += "</div></li>";
		}else{
			//str += "<li>"+obj.fileName+"</li>";
			var fileCallPath = 
				encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			var originPath = obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g),"/");
			str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+
				obj.fileName+"' data-type='"+obj.fileType+"'><div>";
			str += "<span>"+obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+ 
				"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<a href=\"javascript:showImage(\'"+obj.originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'>";
			str += "</div></li>";
		}
	});
	
	console.log(str);
	$(".uploadResult ul").html(str);
	
	});
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		//파일 다중 업로드로 받았기 떄문에 inputFile[0]으로 하지 않으면 값을 못받아옴
		var cloneObj = $(".uploadDiv").clone();
		console.log(files);
		console.log(inputFile[0]);
		
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		console.log("files.length"+files.length);
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false, //전달할 데이터를 query string으로 만들지 말것
			contentType: false,
			beforeSend: function(xhr){ //ajax로 보내기 전에 이 동작을 하라.
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);},
			data: formData,
			type: 'POST',
			dataType: 'json', //받는 파일 타입
			success: function(result){
				console.log(result);
				showUploadedFile(result);
				$(".form-group uploadDiv").html(cloneObj.html());
			}
		});
		
	});
	
	var regEx = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	function checkExtension(fileName, fileSize){
		if(fileSize>=maxSize){
			alert("파일 크기 초과");
			return false;
		}
		if(regEx.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없음.")
			return false;
		}
		return true;
	}
	
	function showUploadedFile(uploadResultArr){
		var str="";
		var uploadUL = $(".uploadResult ul");
		if(!uploadResultArr||uploadResultArr.length==0){return;}
		$(uploadResultArr).each(function(i, obj){
			if(!obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+
				obj.fileName+"' data-type='"+obj.image+"'><div>";
				str += "<span>"+obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+
				"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/images/attach.png'></a>";
				str += "</div></li>";
			}else{
				//str += "<li>"+obj.fileName+"</li>";
				var fileCallPath = 
					encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				var originPath = obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g),"/");
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+
					obj.fileName+"' data-type='"+obj.image+"'><div>";
				str += "<span>"+obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+ 
				"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div></li>";
			}
		});
		console.log(str);
		uploadUL.append(str);
	}
	
});
</script>
</html>

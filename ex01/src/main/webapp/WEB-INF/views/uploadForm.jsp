<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="uploadFormAction" method="post" enctype="multipart/form-data">
	<input type="file" name="uploadFile" multiple="multiple">
						<!--1. 여기 name이 uploadController에서 인식됨 -->
	<button>파일 업로드</button>
</form>
</body>
</html>
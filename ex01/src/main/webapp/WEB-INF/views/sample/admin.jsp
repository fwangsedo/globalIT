<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>관리자만 접근 가능합니다.</h1>
<!-- org.kcm.security에서 구현한 CustomUserDetailsService.java에서 반환한 CustomUser타입으로 저장된 MemberVO
객체를 principal이라는 이름으로 불러올 수 있다. 즉 CustomUser == principal이다. -->
<p>principal : <sec:authentication property="principal"/></p>
<p>MemberVO : <sec:authentication property="principal.member"/></p>
<p>사용자이름 : <sec:authentication property="principal.member.userName"/></p>
<p>사용자아이디 : <sec:authentication property="principal.username"/></p>
<!-- principal.username//이부분은 security에 정해진 값 == principal.member.userId -->
<p>사용자권한 리스트 : <sec:authentication property="principal.member.authList"/></p>
<a href="/customLogout">로그아웃</a>
</body>
</html>
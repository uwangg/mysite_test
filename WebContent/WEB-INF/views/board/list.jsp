<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="/mysite/assets/css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<div id="content">
			<div id="board">
				<form id="search_form" action="${pageContext.request.contextPath }/board" method="get">
					<input type="text" id="kwd" name="kwd" value="${keyword }">
					<input type="submit" value="찾기">
				</form>
				<table class="tbl-ex">
					<tr>
						<th>번호 </th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>&nbsp;</th>
					</tr>	
					<c:set var="cnt" value="${listLength }"/>
					<c:forEach items="${list }" var="vo" varStatus="status">			
					<tr>
						<td>${cnt-(status.index+cp*3)+3 }</td>
						<td style="text-align:left; padding-left:${20*vo.depth}px"><a href="${pageContext.request.contextPath }/board?a=view&no=${vo.no}">${vo.title }</a></td>
						<td>${vo.name }</td>
						<td>${vo.hit }</td>
						<td>${vo.reg_date }</td>
						
						<td>
							<c:if test="${sessionScope.authUser.no == vo.user_no}">
								<a href="${pageContext.request.contextPath }/board?a=delete&no=${vo.no}" class="del">삭제</a>
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</table>
				
				<div class="pager">
					<ul>
						<c:if test="${page > 1 }">
							<li><a href="/mysite/board?page=${page-1 }">◀</a></li>
						</c:if>
						
						<c:forEach begin="${begin }" end="${end }" var="count" step="1">
							
							<c:choose>
								<c:when test="${cp == count }">
									<li class="selected">${count }</li>
								</c:when>
								<c:otherwise>
									<li><a href="/mysite/board?page=${page }&cp=${count }&kwd=${keyword }">${count }</a></li>
								</c:otherwise>
							</c:choose>
							
						</c:forEach>
						
						<c:if test="${page < totalPage}">
							<li><a href="/mysite/board?page=${page+1 }">▶</a></li>
						</c:if>
		
					</ul>
				</div>
				
				<div class="bottom">
					<c:if test="${sessionScope.authUser != null }">
						<a href="${pageContext.request.contextPath }/board?a=writeform" id="new-book">글쓰기</a>
					</c:if>	
				</div>
			</div>
		</div>
		<c:import url="/WEB-INF/views/include/navigation.jsp"></c:import>
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	</div>
</body>
</html>
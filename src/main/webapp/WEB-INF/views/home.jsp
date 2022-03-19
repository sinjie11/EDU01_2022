<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<link rel="shortcut icon" href="#">

<!-- jquery -->
<script src="/js/jquery-3.6.0.js"></script>

<head>
	<title>Home</title>
	
	<script>
	$(document).ready(function(){
		//alert('첫페이지 입성!!!');
		
		fnStartData();
	});
	
	function fnStartData() {
		
		var params = {
				'mberId' : 'test'
				, 'name' : '테스트'
		}
		
		$.ajax({
			url : '/testAjax.do'
			, type : 'POST'
			, data : params
			, dataType : 'json'
			, success : function(response) {
			    //정상 요청, 응답 시 처리 작업
			    console.log('성공');
			    console.log(response);
			  
			    $('#p_id').text(response.resId);
			    $('#p_name').text(response.resName);
			}
			, error : function(request, status, error) {
			    //오류 발생 시 처리
				console.log('에러');
			}
		});
		
	}
	
	// 회원 목록
	function fnMberList() {
		var form = $('#mberForm');
		
		form.attr('action', '/mber/mberList.do');
		form.submit();
	}
	</script>
</head>

<body>
	<h1>
		Hello world!  
	</h1>
	
	<P>  The time on the server is ${serverTime}. </P>
	<P id="p_id"></P>
	<P id="p_name"></P>
	
	<form id="mberForm" name="mberForm" action="" method="post">
	</form>
	
	<button type="button" id="mberBtn" onclick="fnMberList();">회원목록</button>

</body>

</html>

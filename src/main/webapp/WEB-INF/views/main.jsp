<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<link rel="shortcut icon" href="#">

<!-- jquery -->
<script src="/js/jquery-3.6.0.js"></script>

<head>
	<title>로그인</title> 
	
	<script>
	$(document).ready(function(){
		
		// 회원 폼 데이터 초기화 실행
		clearMberForm();
		
		// Enter키 이벤트
		$('#mberPw').keydown(function(e) {
			
			if( e.keyCode == 13 ){
				// 로그인
				fnLogin();
			}
		});
		
	});
	
	// 회원 폼 데이터 초기화
	function clearMberForm() {
		$('#mberId').val('');
	    $('#mberPw').val('');
	}
	
	// 회원 검증
	function fnMberConfirm() {
		
		var id = $('#mberId').val();
		var pw = $('#mberPw').val();
		
		if (id == null || id == '') {
			
			alert("아이디를 입력하세요.");
			$('#mberId').focus();
			return;
		}
		
		if (pw == null || pw == '') {
			
			alert("비밀번호를 입력하세요.");
			$('#mberPw').focus();
			return;
		}
		
		var params = {
				'mberId' : id
				, 'mberPw' : pw
		}
		
		$.ajax({
			url : '/mberConfirmAjax.do'
			, type : 'POST'
			, data : params
			, dataType : 'json'
			, success : function(response) {
			    //정상 요청, 응답 시 처리 작업
			    if (response != null && response.resultCode == '0') { // 성공
			    	
			    	$('#mberId').val(response.mberId);
				    $('#mberPw').val(response.mberPw);
				    
				    // 로그인 실행
				    fnLogin();
			    } else { // 실패
			    	alert(response.resultMsg);
			    	// 로그인 페이지로 이동
			    	location.href = '/';
			    }
			  
			    
			}
			, error : function(request, status, error) {
			    //오류 발생 시 처리
				console.log('Ajax 통신 에러');
			}
		});
		
	}
	
	// 로그인
	function fnLogin() {
		
		var form = $('#mberForm');
		
		var id = $('#mberId').val();
		var pw = $('#mberPw').val();
		
		if (id == null || id == '') {
			alert("아이디를 입력하세요.");
			$('#mberId').focus();
			return;
		}
		
		if (pw == null || pw == '') {
			alert("비밀번호를 입력하세요.");
			$('#mberPw').focus();
			return;
		}
		
		//form.attr('action', '/mber/mberList.do');
		form.attr('action', '/board/boardList.do');
		form.submit();
	}
	
	// 회원가입
	function fnMberJoin() {
		
		var form = $('#mberForm');
		
		form.attr('action', '/mber/mberJoin.do');
		form.submit();
	}
	</script>
</head>

<body>
	<div class="loginForm">
		<form id="mberForm" name="mberForm" method="post">
			<table class="memberTable">
				<colgroup>
					<col width="50%">
					<col width="50%">
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" id="mberId" name="mberId" value="" />
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" id="mberPw" name="mberPw" value="" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<button type="button" class="loginBtn" style="margin-left: 230px;" id="mberLoginBtn" onclick="fnMberConfirm();">로그인</button>
		<button type="button" class="loginBtn" style="" id="mberJoinBtn" onclick="fnMberJoin();">회원가입</button>
	</div>
</body>

</html>

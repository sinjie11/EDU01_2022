<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<script src="/js/jquery-3.6.0.js"></script>

<head>
	<title>회원가입</title>
	
	<script>
		$(document).ready(function() {
			
			/*
			 	keydown 
			 	- 사용자가 키보드의 키를 눌렀을 때 발생합니다.
 				keyup 
 				- 사용자가 키보드의 키를 눌렀다가 떼었을 때 발생합니다.
				keypress 
				- 사용자가 키보드를 눌렀을 때 발생합니다.
				- Alt, Ctrl, Shift, Esc 키등 몇 가지 키에서는 이 이벤트를 발생시키지 않습니다.
			*/
			
			// 회원아이디 키보드 이벤트
			$('#mberId').on('keyup', function(){
				$('#dupChk').val('Y');
			});
			
		});
		
		// 중복체크
		function fnMberIdDupCheck() {
			
			var id = $('#mberId').val();
			
			var params = {
					'mberId' : id
			}
			
			$.ajax({
				url : '/mber/mberIdDupCheck.do'
				, type : 'POST'
				, data : params
				, dataType : 'json'
				, success : function(response) {
				    //정상 요청, 응답 시 처리 작업
				    if (response != null && response.resultCode == '0') { // 성공
				    	alert(response.resultMsg);
				    	$('#dupChk').val('N');
				    } else { // 실패
				    	alert(response.resultMsg);
				    	$('#dupChk').val('Y');
				    	return;
				    }
				    
				}
				, error : function(request, status, error) {
				    //오류 발생 시 처리
					console.log('Ajax 통신 에러');
				}
			});
			
		}
		
		// 등록
		function fnRegist() {
			
			var formData = $('#joinForm').serialize(); // serialize() : 입력된 모든 Element를 문자열의 데이터에 serialize 한다
			
			var dupChkVal = $('#dupChk').val();
			var idVal = $('#mberId').val();
			var pwVal = $('#mberPw').val(); 
			var pw2Val = $('#mberPwConfirm').val(); 
			var nameVal = $('#name').val(); 
			var birthVal = $('#birth').val(); 
			var mobileTelNoVal = $('#mobileTelNo').val(); 
			var emailVal = $('#email').val();

			if (idVal == '' || idVal == null) {
				alert('아이디를 입력해 주세요.');
				$('#mberId').focus();
				return;
			}
			
			if (dupChkVal == '' || dupChkVal == 'Y') {
				alert('아이디 중복체크를 해주세요.');
				return;
			}
			
			if (pwVal == '' || pwVal == null) {
				alert('비밀번호를 입력해 주세요.');
				$('#mberPw').focus();
				return;
			}
			
			if (pw2Val == '' || pw2Val == null) {
				alert('비밀번호 확인을 입력해 주세요.');
				$('#mberPwConfirm').focus();
				return;
			}
			
			if (nameVal == '' || nameVal == null) {
				alert('이름을 입력해 주세요.');
				$('#name').focus();
				return;
			}
			
			if (birthVal == '' || birthVal == null) {
				alert('생년월일을 입력해 주세요.');
				$('#birth').focus();
				return;
			}
			
			if (mobileTelNoVal == '' || mobileTelNoVal == null) {
				alert('휴대폰번호를 입력해 주세요.');
				$('#mobileTelNo').focus();
				return;
			}
			
			if (emailVal == '' || emailVal == null) {
				alert('이메일을 입력해 주세요.');
				$('#email').focus();
				return;
			}
			
			if (pwVal != pw2Val) {
				alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
				$('#mberPw').focus();
				return;
			}
			
			$.ajax({
				url : '/mber/mberRegist.do'
				, type : 'POST'
				, data : formData
				, dataType : 'json'
				, success : function(response) {
				    //정상 요청, 응답 시 처리 작업
				    if (response != null && response.resultCode == '0') { // 성공
				    	alert(response.resultMsg);
				    } else { // 실패
				    	alert(response.resultMsg);
				    }
				    
				    // 로그인 페이지로 이동
			    	location.href = '/';
				    
				}
				, error : function(request, status, error) {
				    //오류 발생 시 처리
					console.log('Ajax 통신 에러');
				}
			});
			
		}
		
		// 취소
		function fnCancel() {
			
			var form = $('#joinForm');
			
			form.attr('action', '/');
			form.submit();
		}
	</script>
</head>

<body>
	<div class="joinForm">
		<form id="joinForm" name="joinForm" method="post">
			<input type="hidden" id="dupChk" value="" />
			<table>
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" id="mberId" name="mberId" />
							<button type="button" class="loginBtn" style="margin-left: 10px;" id="dupCheck" onclick="fnMberIdDupCheck();">중복체크</button>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" id="mberPw" name="mberPw" />
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input type="password" id="mberPwConfirm" />
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input type="text" id="name" name="name" />
						</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>
							<input type="text" id="birth" name="birth" />
						</td>
					</tr>
					<tr>
						<th>휴대폰번호</th>
						<td>
							<input type="text" id="mobileTelNo" name="mobileTelNo" />
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input type="text" id="email" name="email" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		</br>
		<button type="button" class="loginBtn" style="margin-left: 190px;" id="registBtn" onclick="fnRegist();">등록</button>
		<button type="button" class="loginBtn" style="" id="cancelBtn" onclick="fnCancel();">취소</button>
	</div>
</body>

</html>
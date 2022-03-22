<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<script src="/js/jquery-3.6.0.js"></script>

<head>
	<title>게시판 상세</title>
	
	<style>
   	input[type=radio]{
        background-color: #FFFF;
        -webkit-appearance: none;
        -moz-appearance: none;
        margin-left: 16px;
        border: 1px solid rgb(216, 216, 216);
        width: 14px;
        height: 14px;
        border-radius: 100%;
    }
    
    input[type=radio]:checked{
        background-color: rgb(25, 118, 248);
        -webkit-appearance: none;
        -moz-appearance: none;
        margin-left: 16px;
        border: none;
        width: 14px;
        height: 14px;
        border-radius: 100%;
    }
    </style>
    
	<script>
	$(document).ready(function() {
		
	});
	
	// 공개여부 선택에 따른 이벤트
	function fnBbsOpenYnChk(objVal) {
		
		$('#boardPw').val('');
		
		if (objVal == 'Y') { // 예
			$('#boardPw').css('background', 'LightGray');
			$('#boardPw').attr('readonly', true);
			
			$('#boardOpenYn_Y').prop('checked', true);
			$('#boardOpenYn_N').prop('checked', false);
		} else { // 아니오(N)
			$('#boardPw').css('background', 'white');
			$('#boardPw').attr('readonly', false);
			
			$('#boardOpenYn_Y').prop('checked', false);
			$('#boardOpenYn_N').prop('checked', true);
		}
		
	}
	
	// 게시글 상세
	function fnBbsDetail() {
		
		var form = $('#modifyForm');

		form.attr('action', '/board/boardDetail.do');
		form.submit();
	}
	
	// 게시글 수정
	function fnBbsModify() {
		
		var form = $('#modifyForm');
		
		if (confirm('수정하시겠습니까?')){ // 확인

			$.ajax({
				url : '/board/boardUpdate.do'
				, type : 'POST'
				, data : form.serialize()
				, dataType : 'json'
				, success : function(response) {
				    //정상 요청, 응답 시 처리 작업
				    if (response.resultCode == '0') { // 성공
				    	alert(response.resultMsg);
				    	// 게시글 상세로 이동
				    	fnBbsDetail();
				    } else {
				    	alert(response.resultMsg);
				    	return;
				    }
				    
				}
				, error : function(request, status, error) {
				    //오류 발생 시 처리
					console.log('Ajax 통신 에러');
				}
			});

		} else { // 취소
			
			return;
		}
		
	}
	</script>
</head>

<body>

	<form id="modifyForm" name="modifyForm" method="post">
		<input type="hidden" id="mberId" name="mberId" value="${mberId}" />
		<input type="hidden" id="boardNo" name="boardNo" value="${boardVO.boardNo}" />
		
		<table class="boardTable">
			<colgroup>
		        <col width="40%;">
		        <col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="title" name="title" value="${boardVO.title}" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="content" name="content" rows="10" cols="20">${boardVO.content}</textarea>
					</td>
				</tr>
				<tr>
					<th>게시글 비밀번호</th>
					<td>
						<input type="password" id="boardPw" name="boardPw" value="${boardVO.boardPw}" <c:if test="${boardVO.boardOpenYn eq 'Y'}">style="background-color: LightGray;"</c:if> <c:if test="${boardVO.boardOpenYn eq 'N'}">readonly="readonly"</c:if> />
					</td>
				</tr>
				<tr>
					<th>공개여부</th>
					<td>
						<input type="radio" id="boardOpenYn_Y" name="boardOpenYn" value="Y" onclick="fnBbsOpenYnChk(this.value);" <c:if test="${boardVO.boardOpenYn eq 'Y'}">checked="checked"</c:if> />
  						<label for="boardOpenYn_Y">예</label>
						<input type="radio" id="boardOpenYn_N" name="boardOpenYn" value="N" onclick="fnBbsOpenYnChk(this.value);" <c:if test="${boardVO.boardOpenYn eq 'N'}">checked="checked"</c:if> />
  						<label for="boardOpenYn_N">아니오</label>
					</td>
				</tr>
			</tbody>
		</table>
		
	</form>
	</br>
	<button type="button" class="boardBtn" style="margin-left: 200px;" id="bbsModifyBtn" onclick="fnBbsModify();">수정</button>
	<button type="button" class="boardBtn" style="margin-left: 5px;" id="bbsDeleteBtn" onclick="fnBbsDetail();">취소</button>
</body>

</html>
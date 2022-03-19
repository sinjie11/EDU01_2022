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
	
	// 목록
	function fnBbsList() {
		
		var form = $('#detailForm')

		form.attr('action', '/board/boardList.do');
		form.submit();
	}
	
	// 게시글 수정
	function fnBbsModify() {
		
		var form = $('#detailForm')

		form.attr('action', '/board/boardModify.do');
		form.submit();
	}
	
	// 게시글 삭제
	function fnBbsDelete() {
		
		var form = $('#detailForm');
		
		if (confirm('삭제하시겠습니까?') == true){ // 확인

			$.ajax({
				url : '/board/boardDelete.do'
				, type : 'POST'
				, data : form.serialize()
				, dataType : 'json'
				, success : function(response) {
				    //정상 요청, 응답 시 처리 작업
				    if (response.resultCode == '0') { // 성공
				    	alert(response.resultMsg);
				    	// 게시글 목록으로 이동
				    	fnBbsList();
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

	<form id="detailForm" name="detailForm" method="post">
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
						<input type="text" id="title" name="title" style="background-color: LightGray;" value="${boardVO.title}" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="content" name="content" style="background-color: LightGray;" rows="10" cols="20" readonly="readonly">${boardVO.content}</textarea>
					</td>
				</tr>
				<tr>
					<th>게시글 비밀번호</th>
					<td>
						<input type="password" id="boardPw" name="boardPw" style="background-color: LightGray;" value="${boardVO.boardPw}" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th>공개여부</th>
					<td>
						<input type="radio" id="boardOpenYn_Y" name="boardOpenYn" value="Y" <c:if test="${boardVO.boardOpenYn eq 'Y'}">checked="checked"</c:if> disabled="disabled" />
  						<label for="boardOpenYn_Y">예</label>
						<input type="radio" id="boardOpenYn_N" name="boardOpenYn" value="N" <c:if test="${boardVO.boardOpenYn eq 'N'}">checked="checked"</c:if> disabled="disabled" />
  						<label for="boardOpenYn_N">아니오</label>
					</td>
				</tr>
				<tr>
					<th>등록일시</th>
					<td>
						<span>${boardVO.regDate}</span>
					</td>
				</tr>
			</tbody>
		</table>
		
	</form>
	</br>
	<button type="button" class="boardBtn" style="margin-left: 150px;" id="bbsListBtn" onclick="fnBbsList();">목록</button>
	<c:if test="${boardVO.regId eq mberId or 'admin' eq mberId}"> <%-- 게시글 등록자 아이디와 로그인 아이디가 같거나 로그인 아이디가 admin(관리자)인 경우  --%>
	<button type="button" class="boardBtn" style="margin-left: 5px;" id="bbsModifyBtn" onclick="fnBbsModify();">수정</button>
	<button type="button" class="boardBtn" style="margin-left: 5px;" id="bbsDeleteBtn" onclick="fnBbsDelete();">삭제</button>
	</c:if>
</body>

</html>
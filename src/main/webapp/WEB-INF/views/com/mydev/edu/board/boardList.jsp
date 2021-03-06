<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<style>
table, td, th {
    border: 1px solid black;
}
 
th {
    background: #F3F5F5;
}
 
table {
    margin-top: 5%;
    margin-left: auto;
    margin-right: auto;
    text-align: center;
    width: 80%;
}
 
a:link {
    color: red;
    text-decoration: none;
    cursor: pointer;
}
 
a:visited {
    color: black;
    text-decoration: none;
}
 
/* paginate */
.paginate {
    padding: 0;
    line-height: normal;
    text-align: center;
    position: relative;
    margin: 20px 0 20px 0;
    z-index: 1;
}
 
.paginate .paging {
    text-align: center;
}
 
.paginate .paging a, .paginate .paging strong {
    margin: 0;
    padding: 0;
    width: 20px;
    height: 24px;
    line-height: 24px;
    text-align: center;
    color: #848484;
    display: inline-block;
    vertical-align: middle;
    text-align: center;
    font-size: 12px;
}
 
.paginate .paging a:hover, .paginate .paging strong {
    color: #DAA520;
    font-weight: 600;
    font-weight: normal;
}
 
.paginate .paging .direction {
    z-index: 3;
    vertical-align: middle;
    background-color: none;
    margin: 0 2px;
    border: 1px solid #777;
    border-radius: 2px;
    width: 28px;
}
 
.paginate .paging .direction:hover {
    border: 1px solid #C40639;
}
 
.paginate .paging .direction.prev {
    margin-right: 4px;
}
 
.paginate .paging .direction.next {
    margin-left: 4px;
    cursor: pointer;
}
 
.paginate .paging img {
    vertical-align: middle;
}
 
.paginate .right {
    position: absolute;
    top: 0;
    right: 0;
}
 
.bottom-left, .bottom-right {
    position: relative;
    z-index: 5;
}
 
.paginate ~ .bottom {
    margin-top: -50px;
}
 
.bottom select {
    background: transparent;
    /* color: #aaa; */
    cursor: pointer;
}
 
/* paginate */
.paginate {
    padding: 0;
    line-height: normal;
    text-align: center;
    position: relative;
    margin: 20px 0 20px 0;
}
 
.paginate .paging {
    text-align: center;
}
 
.paginate .paging a, .paginate .paging strong {
    margin: 0;
    padding: 0;
    width: 20px;
    height: 28px;
    line-height: 28px;
    text-align: center;
    color: #999;
    display: inline-block;
    vertical-align: middle;
    text-align: center;
    font-size: 14px;
}
 
.paginate .paging a:hover, .paginate .paging strong {
    color: #C40639;
    font-weight: 600;
    font-weight: normal;
}
 
.paginate .paging .direction {
    z-index: 3;
    vertical-align: middle;
    background-color: none;
    margin: 0 2px;
}
 
.paginate .paging .direction:hover {
    background-color: transparent;
}
 
.paginate .paging .direction.prev {
    margin-right: 4px;
}
 
.paginate .paging .direction.next {
    margin-left: 4px;
}
 
.paginate .paging img {
    vertical-align: middle;
}
 
.paginate .right {
    position: absolute;
    top: 0;
    right: 0;
}
</style>

<script src="/js/jquery-3.6.0.js"></script>

<head>
	<title>????????? ??????</title>
	
	<script>
	$(document).ready(function() {
		
		// ????????? ?????? ?????????
		$('#boardNo').val('');
	});
	
	//10,20,30?????? selectBox ?????? ?????????
	function changeSelectBox(currentPage, cntPerPage, pageSize){
	    var selectValue = $('#cntSelectBox option:selected').val();
	    movePage(currentPage, selectValue, pageSize);
	    
	}
	 
	//????????? ??????
	function movePage(currentPage, cntPerPage, pageSize){

		var form = $('#pagingForm');
		
	    $('#currentPage').val(currentPage);
	    $('#cntPerPage').val(cntPerPage);
	    $('#pageSize').val(pageSize);

	    form.attr('action', '/board/boardList.do');
		form.submit();
	}
	
	// ????????? ???????????? ??????	 
	function fnBbsPwCheck() {
		
		var form = $('#listForm');
		
		if ($('#boardPw').val() == '' || $('#boardNo').val() == null) {
			alert('????????? ??????????????? ????????? ?????????');
			return;
		}
		
		var params = {
				'boardNo' : $('#boardNo').val()
		}
		
		// ????????? ????????????
		$.ajax({
			url : '/board/boardDetailInfo.do'
			, type : 'POST'
			, data : params
			, dataType : 'json'
			, success : function(response) {
			    //?????? ??????, ?????? ??? ?????? ??????
			    if (response.resultCode == '0') { // ??????
			    
			    	if (response.boardVO.boardPw == $('#boardPw').val()) { // ????????? ????????? ??????????????? ?????? ??? ????????? ??????????????? ?????????
			    		
			    		// ????????? ????????? ??????
			    		$.ajax({
			    			url : '/board/boardHitsCntModify.do'
			    			, type : 'POST'
			    			, data : params
			    			, dataType : 'json'
			    			, success : function(response2) {
			    			    //?????? ??????, ?????? ??? ?????? ??????
			    			    if (response2.resultCode == '0') { // ??????
			    			    	
			    			    	form.attr('action', '/board/boardDetail.do');
			    					form.submit();
			    			    }
			    			    
			    			}
			    			, error : function(request2, status2, error2) {
			    			    //?????? ?????? ??? ??????
			    				console.log('Ajax ?????? ??????');
			    			}
			    		});
			    		
			    	} else { // ?????????
			    		alert('????????? ??????????????? ???????????? ????????????.\n?????? ????????? ?????????.');
			    		$('#boardPw').focus();
						return;
			    	}
			    	
			    }
			    
			}
			, error : function(request, status, error) {
			    //?????? ?????? ??? ??????
				console.log('Ajax ?????? ??????');
			}
		});

	}
	
	// ????????? ??????
	function fnBbsDetail(no, openYn) {
		
		var form = $('#listForm');
		
		$('#boardNo').val(no);
		$('#boardOpenYn').val(openYn);
		
		$('#boardPw').val('');
		
		// ????????? ????????????
		$.ajax({
			url : '/board/boardDetailInfo.do'
			, type : 'POST'
			, data : form.serialize()
			, dataType : 'json'
			, success : function(response) {
			    //?????? ??????, ?????? ??? ?????? ??????
			    if (response.resultCode == '0') { // ??????

			    	if (response.boardVO.boardOpenYn == 'N') { // ????????? ?????????
			    		
			    		$('#boardOpenYn').val('N');
			    		$('#bbsPwDiv').show();
			    	} else { // ????????? ??????
			    		
			    		$('#boardOpenYn').val('Y');
			    		$('#bbsPwDiv').hide();
			    		
			    		// ????????? ????????? ??????
			    		$.ajax({
			    			url : '/board/boardHitsCntModify.do'
			    			, type : 'POST'
			    			, data : form.serialize()
			    			, dataType : 'json'
			    			, success : function(response2) {
			    			    //?????? ??????, ?????? ??? ?????? ??????
			    			    if (response2.resultCode == '0') { // ??????
			    			    	
			    			    	form.attr('action', '/board/boardDetail.do');
			    					form.submit();
			    			    }
			    			    
			    			}
			    			, error : function(request2, status2, error2) {
			    			    //?????? ?????? ??? ??????
			    				console.log('Ajax ?????? ??????');
			    			}
			    		});
			    	}
			    	
			    }
			    
			}
			, error : function(request, status, error) {
			    //?????? ?????? ??? ??????
				console.log('Ajax ?????? ??????');
			}
		});
		
	}
	
	// ????????? ??????
	function fnBbsRegist() {
		
		var form = $('#listForm');

		form.attr('action', '/board/boardRegist.do');
		form.submit();
	}
	
	// ????????????
	function fnLogOut() {
		
		var form = $('#listForm');

		form.attr('action', '/logout.do');
		form.submit();
	}
	</script>
</head>

<body>
	<button type="button" class="loginBtn" style="float:right;margin-right:190px;" id="logoutBtn" onclick="fnLogOut();">????????????</button>
	<span style="float:right;margin-right:10px;">${mberVO.name}</span>
	<h2 style="text-align: center;">?????????</h2>
	<form id="listForm" name="listForm" method="post">
		<input type="hidden" id="mberId" name="mberId" value="${mberId}" />
		<input type="hidden" id="boardNo" name="boardNo" value="" />
		<input type="hidden" id="boardOpenYn" name="boardOpenYn" value="" />
		
		<table class="boardTable" style="">
			<tbody>
				<th>??????</th>
				<th>??????</th>
				<th>????????????</th>
				<th>?????????</th>
				<th>?????????</th>
				<th>????????????</th>
				<c:forEach var="item" items="${boardList}" varStatus="i">
					<tr>
						<td>
							${item.rnum}
						</td>
						<td>
							<a href="javascript:void(0);" style="text-decoration: underline; color: red;" onclick="fnBbsDetail('${item.boardNo}', '${item.boardOpenYn}');">
								${item.title}
							</a>
						</td>
						<td>
							${item.boardOpenYn}
						</td>
						<td>
							${item.hits}
						</td>
						<td>
							${item.regName}
						</td>
						<td>
							${item.regDate}
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
	</form>
	
	
	<form id="pagingForm" name="pagingForm" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value="" />
		<input type="hidden" id="cntPerPage" name="cntPerPage" value="" />
		<input type="hidden" id="pageSize" name="pageSize" value="" />
	</form>
	
	<!--paginate -->
    <div class="paginate">
        <div class="paging">
            <a class="direction prev" href="javascript:void(0);" onclick="movePage(1,${pagination.cntPerPage},${pagination.pageSize});">&lt;&lt; </a> 
            <a class="direction prev" href="javascript:void(0);" onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasPreviousPage == true}">-1</c:if>,${pagination.cntPerPage},${pagination.pageSize});">&lt; </a>
 
           <c:forEach var="idx" begin="${pagination.firstPage}" end="${pagination.lastPage}">
                <a style="color:<c:out value="${pagination.currentPage == idx ? '#cc0000; font-weight:700; margin-bottom: 2px;' : ''}"/> " href="javascript:void(0);" onclick="movePage(${idx},${pagination.cntPerPage},${pagination.pageSize});">
                	<c:out value="${idx}" />
                </a>
            </c:forEach>
            <a class="direction next" href="javascript:void(0);" onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasNextPage == true}">+1</c:if>,${pagination.cntPerPage},${pagination.pageSize});">&gt; </a> 
            <a class="direction next" href="javascript:void(0);" onclick="movePage(${pagination.totalRecordCount},'${pagination.cntPerPage},${pagination.pageSize});">&gt;&gt; </a>
        </div>
    </div>
    <!-- /paginate -->
    
    <div class="bottom">
        <div class="bottom-left" style="margin-left: 1615px; margin-top: 50px;">
            <select id="cntSelectBox" name="cntSelectBox" onchange="changeSelectBox(${pagination.currentPage},${pagination.cntPerPage},${pagination.pageSize});" class="form-control" style="width: 100px;">
                <option value="10" <c:if test="${pagination.cntPerPage == '10'}">selected</c:if>>10??????</option>
                <option value="20" <c:if test="${pagination.cntPerPage == '20'}">selected</c:if>>20??????</option>
                <option value="30" <c:if test="${pagination.cntPerPage == '30'}">selected</c:if>>30??????</option>
            </select>
        </div>
    </div>
	
	</br>
	<button type="button" class="loginBtn" style="float:right;margin-right:190px;" id="bbsRegistBtn" onclick="fnBbsRegist();">??????</button>
	
	</br>
	</br>
	<div id="bbsPwDiv" style="display: none;">
		<table class="boardTable">
			<tbody>
				<th>????????? ????????????</th>
				<tr>
					<td>
						<input type="password" id="boardPw" name="boardPw" value="" />
						<button type="button" class="loginBtn" style="" id="bbsPwChkBtn" onclick="fnBbsPwCheck();">??????</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>

</html>
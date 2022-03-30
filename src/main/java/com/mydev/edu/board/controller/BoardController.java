package com.mydev.edu.board.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mydev.edu.board.service.BoardService;
import com.mydev.edu.board.vo.BoardVO;
import com.mydev.edu.mber.service.MberService;
import com.mydev.edu.mber.vo.MberVO;
import com.mydev.edu.util.PaginationInfo;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "mberService")
	private MberService mberService;

	/**
	 * 게시판 목록
	 * @param request
	 * @param model
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardList.do")
	public String selectBoardList(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
				
		int currentPage = 1;
		int cntPerPage = 10;
		int pageSize = 10;
		
		if (boardVO.getCurrentPage() == 0) {
			boardVO.setCurrentPage(currentPage);
		}
		
		if (boardVO.getCntPerPage() == 0) {
			boardVO.setCntPerPage(cntPerPage);
		}
		
		if (boardVO.getPageSize() == 0) {
			boardVO.setPageSize(pageSize);
		}

		// 페이징처리 
		int totCnt = boardService.selectBoardListCnt(boardVO); // 게시판 목록 갯수
		PaginationInfo pagination = new PaginationInfo(boardVO.getCurrentPage(), boardVO.getCntPerPage(), boardVO.getPageSize());
		pagination.setTotalRecordCount(totCnt);
		pagination.setFirstRecordIndex(pagination.getFirstRecordIndex());
		pagination.setLastRecordIndex(pagination.getLastRecordIndex());
 
		// 페이지네이션 내리기
        model.addAttribute("pagination", pagination);
        
        // 페이지네이션에서 나온 값을 게시판VO에 세팅
        boardVO.setTotalRecordCount(pagination.getTotalPageCount());
        boardVO.setFirstRecordIndex(pagination.getFirstRecordIndex());
        boardVO.setLastRecordIndex(pagination.getLastRecordIndex());
        
		List<BoardVO> boardList = boardService.selectBoardList(boardVO);
		
		// 로그인한 회원 정보 내리기
		MberVO mberVO = new MberVO();
		mberVO.setMberId(boardVO.getMberId());
		
		mberVO = mberService.selectMberConfirmInfo(mberVO);
		
		// 게시판 목록 내리기
		model.addAttribute("boardList", boardList);
		// 로그인한 아이디 내리기
		model.addAttribute("mberId", boardVO.getMberId());
		// 로그인한 정보 내리기
		model.addAttribute("mberVO", mberVO);
		
		return "/com/mydev/edu/board/boardList";
	}
	
	/**
	 * 게시판 상세
	 * @param request
	 * @param model
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardDetail.do")
	public String selectBoardDetail(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
		
		// 로그인한 아이디 내리기
		model.addAttribute("mberId", boardVO.getMberId());
		
		boardVO = boardService.selectBoardDetail(boardVO);
		
		// 게시판 상세정보 내리기
		model.addAttribute("boardVO", boardVO);
		
		return "/com/mydev/edu/board/boardDetail";
	}
	
	/**
	 * 게시판 등록 페이지
	 * @param request
	 * @param model
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardRegist.do")
	public String boardRegist(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
		
		// 로그인한 아이디 내리기
		model.addAttribute("mberId", boardVO.getMberId());
		
		return "/com/mydev/edu/board/boardRegist";
	}
	
	/**
	 * 게시판 등록 액션
	 * @param request
	 * @param model
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardInsert.do")
	public ModelAndView boardInsert(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		int totCnt = 0;
		
		// 등록자 아이디 세팅
		boardVO.setRegId(boardVO.getMberId());
		totCnt = boardService.boardInsert(boardVO);
		
		if (totCnt > 0) { // 성공
			
			mav.addObject("resultCode", "0");
			mav.addObject("resultMsg", "등록 되었습니다.");
		} else { // 실패
			mav.addObject("resultCode", "-1");
			mav.addObject("resultMsg", "등록 되지 않았습니다.\n관리자에게 문의해 주세요.");
		}	
		
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 게시판 수정 페이지
	 * @param request
	 * @param model
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardModify.do")
	public String boardModify(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
		
		// 로그인한 아이디 내리기
		model.addAttribute("mberId", boardVO.getMberId());
		
		boardVO = boardService.selectBoardDetail(boardVO);
		// 게시판 상세정보 내리기
		model.addAttribute("boardVO", boardVO);
		
		return "/com/mydev/edu/board/boardModify";
	}
	
	/**
	 * 게시판 수정 액션
	 * @param request
	 * @param model
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardUpdate.do")
	public ModelAndView boardUpdate(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
			
		ModelAndView mav = new ModelAndView();
		
		int totCnt = 0;
		
		// 수정자 아이디 세팅
		boardVO.setUpdtId(boardVO.getMberId());
		totCnt = boardService.boardUpdate(boardVO);
		
		if (totCnt > 0) { // 성공
			
			mav.addObject("resultCode", "0");
			mav.addObject("resultMsg", "수정 되었습니다.");
		} else { // 실패
			mav.addObject("resultCode", "-1");
			mav.addObject("resultMsg", "수정 되지 않았습니다.\n관리자에게 문의해 주세요.");
		}	
			
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 게시판 삭제 액션
	 * @param request
	 * @param model
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardDelete.do")
	public ModelAndView boardDelete(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		int totCnt = 0;
		
		// 수정자 아이디 세팅
		boardVO.setUpdtId(boardVO.getMberId());
		totCnt = boardService.boardDelete(boardVO);
		
		if (totCnt > 0) { // 성공
			
			mav.addObject("resultCode", "0");
			mav.addObject("resultMsg", " 삭제 되었습니다.");
		} else { // 실패
			mav.addObject("resultCode", "-1");
			mav.addObject("resultMsg", "삭제 되지 않았습니다.\n관리자에게 문의해 주세요.");
		}	
		
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 게시판 조회수 증가
	 * @param request
	 * @param model
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardHitsCntModify.do")
	public ModelAndView boardHitsCntModify(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		int totCnt = 0;
		
		boardVO.setUpdtId("USER");
		totCnt = boardService.boardHitsCntUpdate(boardVO);
		
		mav.addObject("resultCode", "0");
		mav.addObject("resultMsg", "조회수가 증가 되었습니다.");	
		
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 게시판 상세 정보(json)
	 * @param request
	 * @param model
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardDetailInfo.do")
	public ModelAndView boardDetailInfo(HttpServletRequest request, Model model, BoardVO boardVO) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		boardVO = boardService.selectBoardDetail(boardVO);
		
		// 게시판 상세정보 내리기
		model.addAttribute("boardVO", boardVO);
		
		mav.addObject("resultCode", "0");
		mav.addObject("resultMsg", "성공");	
		
		mav.setViewName("jsonView");
		return mav;
	}
	
	
}
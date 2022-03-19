package com.mydev.edu.board.service;

import java.util.List;

import com.mydev.edu.board.vo.BoardVO;

public interface BoardService {
	
	/**
	 * 게시판 목록
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public List<BoardVO> selectBoardList(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시판 목록 갯수
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int selectBoardListCnt(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시판 상세
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public BoardVO selectBoardDetail(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시판 등록
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int boardInsert(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시판 수정
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int boardUpdate(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시판 삭제
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int boardDelete(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시판 조회수 증가
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int boardHitsCntUpdate(BoardVO boardVO) throws Exception;

}

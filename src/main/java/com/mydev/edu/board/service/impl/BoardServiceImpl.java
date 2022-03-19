package com.mydev.edu.board.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mydev.edu.board.mapper.BoardMapper;
import com.mydev.edu.board.service.BoardService;
import com.mydev.edu.board.vo.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name = "boardMapper")
	private BoardMapper boardMapper;
	
	/**
	 * 게시판 목록
	 */
	@Override
	public List<BoardVO> selectBoardList(BoardVO boardVO) throws Exception {
		
		return boardMapper.selectBoardList(boardVO);
	}
	
	/**
	 * 게시판 목록 갯수
	 */
	@Override
	public int selectBoardListCnt(BoardVO boardVO) throws Exception {
		
		return boardMapper.selectBoardListCnt(boardVO);
	}
	
	/**
	 * 게시판 상세
	 */
	@Override
	public BoardVO selectBoardDetail(BoardVO boardVO) throws Exception {
		
		return boardMapper.selectBoardDetail(boardVO);
	}
	
	/**
	 * 게시판 등록
	 */
	@Override
	public int boardInsert(BoardVO boardVO) throws Exception {
		
		return boardMapper.boardInsert(boardVO);
	}
	
	/**
	 * 게시판 수정
	 */
	@Override
	public int boardUpdate(BoardVO boardVO) throws Exception {
		
		return boardMapper.boardUpdate(boardVO);
	}
	
	/**
	 * 게시판 삭제
	 */
	@Override
	public int boardDelete(BoardVO boardVO) throws Exception {
		
		return boardMapper.boardDelete(boardVO);
	}
	
	/**
	 * 게시판 조회수 증가
	 */
	@Override
	public int boardHitsCntUpdate(BoardVO boardVO) throws Exception {
		
		return boardMapper.boardHitsCntUpdate(boardVO);
	}
	
}

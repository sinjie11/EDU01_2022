package com.mydev.edu.mber.mapper;

import java.util.List;

import com.mydev.edu.mber.vo.MberVO;

public interface MberMapper {

	/**
	 * 회원 목록
	 * @param MberVO
	 * @return
	 * @throws Exception
	 */
	public List<MberVO> selectMberList(MberVO MberVO) throws Exception;
	
	/**
	 * 회원 검증 정보
	 * @param MberVO
	 * @return
	 * @throws Exception
	 */
	public MberVO selectMberConfirmInfo(MberVO MberVO) throws Exception;
	
	/**
	 * 회원 ID 중복 체크
	 * @param MberVO
	 * @return
	 * @throws Exception
	 */
	public int selectMberIdDupCheck(MberVO MberVO) throws Exception;
	
	/**
	 * 회원 등록
	 * @param MberVO
	 * @return
	 * @throws Exception
	 */
	public int mberInsert(MberVO MberVO) throws Exception;	
	
}

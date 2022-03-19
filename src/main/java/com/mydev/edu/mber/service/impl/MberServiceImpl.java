package com.mydev.edu.mber.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mydev.edu.mber.mapper.MberMapper;
import com.mydev.edu.mber.service.MberService;
import com.mydev.edu.mber.vo.MberVO;

@Service("mberService")
public class MberServiceImpl implements MberService {
	
	@Resource(name="mberMapper")
	private MberMapper mberMapper;

	/**
	 * 회원 목록
	 */
	@Override
	public List<MberVO> selectMberList(MberVO mberVO) throws Exception {
		
		return mberMapper.selectMberList(mberVO);
	}
	
	/**
	 * 회원 검증 정보
	 */
	@Override
	public MberVO selectMberConfirmInfo(MberVO MberVO) throws Exception {
		
		return mberMapper.selectMberConfirmInfo(MberVO);
	}
	
	/**
	 * 회원ID 중복 체크
	 */
	@Override
	public int selectMberIdDupCheck(MberVO MberVO) throws Exception {
		
		return mberMapper.selectMberIdDupCheck(MberVO);
	}
	
	/**
	 * 회원 등록
	 */
	@Override
	public int mberInsert(MberVO MberVO) throws Exception {
		
		return mberMapper.mberInsert(MberVO);
	}

}

package com.mydev.edu.mber.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mydev.edu.mber.service.MberService;
import com.mydev.edu.mber.vo.MberVO;

@Controller
@RequestMapping(value = "/mber")
public class MberController {
	
	@Resource(name = "mberService")
	private MberService mberService;
	
	/**
	 * 회원 목록
	 * @param request
	 * @param model
	 * @param mberVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mberList.do")
	public String selectMberList(HttpServletRequest request, Model model, MberVO mberVO) throws Exception {
		
		List<MberVO> resultList = mberService.selectMberList(mberVO);
		
		model.addAttribute("resultList", resultList);
		
		return "/com/mydev/edu/mber/mberList";
	}
	
	/**
	 * 회원가입
	 * @param request
	 * @param model
	 * @param mberVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mberJoin.do")
	public String mberJoin(HttpServletRequest request, Model model, MberVO mberVO) throws Exception {
		
		return "/com/mydev/edu/mber/mberJoin";
	}
	
	/**
	 * 회원ID 중복 체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mberIdDupCheck.do")
	public ModelAndView mberIdDupCheck(HttpServletRequest request, Model model, MberVO mberVO) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		int totCnt = 0;
		
		// 회원ID 중복 체크
		totCnt = mberService.selectMberIdDupCheck(mberVO);
		
		if (totCnt < 1) { // 성공
			
			mav.addObject("resultCode", "0");
			mav.addObject("resultMsg", "사용 가능한 아이디 입니다.");
		} else { // 실패
			mav.addObject("resultCode", "-1");
			mav.addObject("resultMsg", "이미 가입 된 아이디 입니다.\n다른 아이디를 입력해 주세요.");
		}	

		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 회원등록
	 * @param request
	 * @param model
	 * @param mberVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mberRegist.do")
	public ModelAndView mberRegist(HttpServletRequest request, Model model, MberVO mberVO) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		int totCnt = 0;
		
		// 등록자ID 세팅
		mberVO.setRegId("admin");
		
		// 회원등록
		totCnt = mberService.mberInsert(mberVO);
		
		if (totCnt > 0) { // 성공
			
			mav.addObject("resultCode", "0");
			mav.addObject("resultMsg", "회원가입이 되었습니다.\n로그인 페이지로 이동합니다.");
		} else { // 실패
			mav.addObject("resultCode", "-1");
			mav.addObject("resultMsg", "회원가입에 실패했습니다.\n확인 후 다시 진행해 주세요.");
		}	

		mav.setViewName("jsonView");
		return mav;
	}
	
}

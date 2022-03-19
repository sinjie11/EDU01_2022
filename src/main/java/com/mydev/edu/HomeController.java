package com.mydev.edu;

import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mydev.edu.mber.service.MberService;
import com.mydev.edu.mber.vo.MberVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Resource(name = "mberService")
	private MberService mberService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/")
	public String home(Locale locale, Model model) {		
		logger.info("===== Main Login Page Start ===== ");
		
		return "main";
	}
	
	/**
	 * 회원 검증
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mberConfirmAjax.do")
	public ModelAndView mberConfirmAjax(HttpServletRequest request, Model model) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		// 파라미터로 보낸 값
		String p_MberId = request.getParameter("mberId");
		String p_MberPw = request.getParameter("mberPw");
		
		// 새로운 인스턴스 생성
		MberVO mberVO = new MberVO();
		
		// vo에 파라미터로 받아온 값을 세팅
		mberVO.setMberId(p_MberId);
		mberVO.setMberPw(p_MberPw);
		
		// 회원 검증 정보 조회
		mberVO = mberService.selectMberConfirmInfo(mberVO);
		
		if (mberVO != null) { // 성공
			mav.addObject("mberId", mberVO.getMberId());
			mav.addObject("mberPw", mberVO.getMberPw());
			
			mav.addObject("resultCode", "0");
			mav.addObject("resultMsg", "성공");
		} else { // 실패
			mav.addObject("resultCode", "-1");
			mav.addObject("resultMsg", "로그인 정보가 일치 하지 않습니다.\n아이디 또는 비밀번호를 확인해 주세요.");
		}	

		mav.setViewName("jsonView");
		return mav;
	}
	
}

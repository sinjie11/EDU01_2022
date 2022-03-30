package com.mydev.edu.mber.controller;

import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
			
			// 회원가입 메일발송
			gmailSend(mberVO.getMberId());
			
			mav.addObject("resultCode", "0");
			mav.addObject("resultMsg", "회원가입이 되었습니다.\n로그인 페이지로 이동합니다.");
		} else { // 실패
			mav.addObject("resultCode", "-1");
			mav.addObject("resultMsg", "회원가입에 실패했습니다.\n확인 후 다시 진행해 주세요.");
		}	

		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 메일발송(Gmail)
	 */
	public static void gmailSend(String regId) {
		// Gmail 계정
		String mail_id = "sinjie111@gmail.com";
		// Gmail 패스워드
		String mail_pw = "sfayduamftbaswcg";
		
		// 회원가입시 작성한 ID
		String getRegId = regId;
		
		// SMTP 서버정보 설정
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() { 
			protected PasswordAuthentication getPasswordAuthentication() { 
				return new PasswordAuthentication(mail_id, mail_pw); 
			} 
		});
		
		try {
			
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(mail_id));
			
			// 수신자 메일주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mail_id));
			
			// 메일 제목
			message.setSubject("회원가입 메일 입니다.");
			
			// 메일 내용
			message.setText("회원ID: " + getRegId + "\n회원가입이 완료 되었습니다.\n로그인을 진행해 주세요.");
			
			// 메일 전송
			Transport.send(message);
			
			System.out.println("message send Success.....");

		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
		
	}
	
}

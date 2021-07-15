package com.kh.finale.service.member;

import java.util.Properties;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.vo.member.MemberVo;

@Service
public class MemberAuthServiceImpl implements MemberAuthService{
	
	@Autowired
	MemberDao memberDao;
	
//	@Autowired
//	MemberAuthDto memberAuthDto;

	
	// 이메일 전송
	@Override
	public MemberAuthDto pwSendEmail(MemberVo memberVo) {
		
		// 인증 난수 생성
		Random r = new Random();
		int authNo = r.nextInt(389258) + 230985;
		
		// 메세지 전송 도구 생성
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost("smtp.gmail.com");
		sender.setPort(587);
		sender.setUsername("finalprojectkh5@gmail.com");
		sender.setPassword("5whvkdlsjf");
		
		Properties props = new Properties();
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.debug", "true");
		
		sender.setJavaMailProperties(props);
		
		// 메세지 생성
		SimpleMailMessage message = new SimpleMailMessage();
		
		message.setTo(memberVo.getMemberEmail());
		
		message.setSubject("[내일로] 비밀번호 찾기 인증번호 발급");
		
		message.setText("안녕하세요 내일로 관리자 입니다. <br><br>"
				+ "비밀번호 찾기 인증 번호는 " + authNo + "입니다. <br><br>"
				+ "인증번호를 홈페이지에 입력해 주세요.");
		
		// 이메일 전송
		sender.send(message);
		
		
		// Auth 테이블 삽입을 위한 MemberAuthDto 반환 
		MemberAuthDto memberAuthDto = MemberAuthDto.builder()
												.authEmail(memberVo.getMemberEmail())
												.authNo(authNo)
												.build();
		return memberAuthDto;
	}

	@Override
	public void authInsert(MemberAuthDto memberAuthDto) {
		memberDao.authInsert(memberAuthDto);
		
	}
	
}

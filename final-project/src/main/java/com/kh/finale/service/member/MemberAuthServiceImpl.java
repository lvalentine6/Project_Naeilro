package com.kh.finale.service.member;

import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.vo.member.MemberVo;

@Service
public class MemberAuthServiceImpl implements MemberAuthService{
	
	@Autowired
	MemberDao memberDao;
	
	// 이메일 전송
	@Override
	public MemberAuthDto pwSendEmail(MemberVo memberVo) throws MessagingException, UnsupportedEncodingException {
		
		// 인증 난수 생성
		Random r = new Random();
		int authNo = r.nextInt(900000) + 99999;
		
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
		
		// 이메일 전송
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		String[] to = {memberVo.getMemberEmail()};
		helper.setFrom(new InternetAddress("finalprojectkh5@gmail.com", "내일로 관리자"));
		helper.setTo(to);
		helper.setSubject("[NAEILRO] 비밀번호 인증 번호");
		helper.setText("안녕하세요 NAEILRO 입니다. <br><br>"
				+ "비밀번호 찾기 인증 번호는 <font color = \"blue\"><strong>" + authNo + "</strong></font> 입니다. <br><br>" 
				+ "인증번호를 5분 이내에 입력해 주세요. <br><br><br>"
				+ "<p><b>[본 메일은 NAEILRO에서 발송한 메일이며 발신전용 메일입니다.]</b></p>", true);
		sender.send(message);
		
		
		// Auth 테이블 삽입을 위한 MemberAuthDto 반환 
		MemberAuthDto memberAuthDto = MemberAuthDto.builder()
												.memberNo(memberVo.getMemberNo())
												.authEmail(memberVo.getMemberEmail())
												.authNo(authNo)
												.build();
		return memberAuthDto;
	}
	
	
	// 비밀번호 찾기 1
	@Override
	public void authInsert(MemberAuthDto memberAuthDto) {
		memberDao.authInsert(memberAuthDto);
	}
	
	// 비밀번호 찾기 2
	@Override
	public Map<String,Object> resultAuth(MemberAuthDto memberAuthDto) {
		return memberDao.resultAuth(memberAuthDto);
	}

	// 비밀번호 찾기 3
	@Override
	public MemberAuthDto selectId(MemberAuthDto memberAuthDto) {
		return memberDao.selectId(memberAuthDto);
	}

	// 비밀번호 찾기 4
	@Override
	public void updatePw(MemberDto memberDto) {
		memberDao.updatePw(memberDto);
	}
	
}

package com.example.demo.mail;

import java.io.UnsupportedEncodingException;

import org.springframework.stereotype.Service;

import com.example.demo.join.JoinDTO;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public interface IMailService {

	// 메일 내용 작성
	MimeMessage creatMessage(String to, JoinDTO joins) throws MessagingException, UnsupportedEncodingException;

	// 랜덤 코드 생성
	String createKey();

	// 메일 발송
	void sendSimpleMessage(String to, JoinDTO joins) throws Exception;

}
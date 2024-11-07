package com.smhrd.Arti.Model;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class QnaBoard {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idx;
	private String title;
	private String writer;
	private String password;
	private String content;
	
	@CreationTimestamp
	private LocalDateTime created_at;
	
	
}

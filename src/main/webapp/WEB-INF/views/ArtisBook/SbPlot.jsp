<%@page import="com.smhrd.Arti.Model.StoryContent"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.Arti.Model.StoryBook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTI</title>
<link rel="stylesheet" href="/css/StoryBook/SbPlot.css">
<link rel="icon" href="/img/favicon.ico">
</head>
<body>
	<%@ include file="SbCreateHeader.jsp"%>
	<%@ include file="LoadingPage.jsp"%>
	<div id="#" class="SbPlot-page">

		<%
		StoryBook story = (StoryBook) session.getAttribute("storybook");
		// 세션에서 storyContentList 가져오기
		List<StoryContent> storyContentList = (List<StoryContent>) session.getAttribute("storyContentList");
		if (storyContentList == null || storyContentList.isEmpty()) {
		%>
		<p>저장된 줄거리가 없습니다.</p>
		<%
		} else {
		%>


		<div>
			<div class="SbPlot-Title plot">줄거리를 토대로 11p 플롯을 생성했어요.</div>
			<div class="SBPlot-SubTitle plot">동화책 각 페이지에 들어갈 이야기를 수정할 수
				있어요.</div>
		</div>


		<div class="SbPlot-view">
			<%
			for (StoryContent content : storyContentList) {
			%>
			<div id="SbPlot-box-<%=content.getPageNum() - 1%>" class="SbPlot-box">
				<div class="SbPlot-index"><%=content.getPageNum()%></div>
				<div id="SbPlot-Content-<%=content.getPageNum() - 1%>"
					class="SbPlot-Content">
					<%=content.getContent()%>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<%
		}
		%>


		<div class="SbPlot-BtnContainer">
			<button class="SbModify-btn" id="SbModifyBtn">
				<img src="/img/modify.svg" class="SbModify-btn-icon">플롯 수정
			</button>
			<div class="SbPlotPagination plot">
				<img src="/img/prev-grey.svg">
				<div class="SbPlotPage-label">
					<div>플롯1</div>
				</div>
				<img src="/img/next-grey.svg">
			</div>
			<button id="SbSubmitBtn" class="SbSubmit-btn plot">
				이 플롯으로 쓸래요 <img class="SbSubmit-Nextbtn"
					src="/img/next-button-icon.svg">
			</button>
		</div>

		<!-- 확인 팝업창 -->
		<div id="SbPlotConfirmModalBack" class="SbPlot-ConfirmModalBack"
			style="display: none">
			<div class="SbPlot-ConfirmModal">
				<img src="/img/close-icon.svg" id="SbPlotModalClose"
					class="SBP-closeBtn"> <img src="/img/plot-confirm.svg"
					class="SbPlotModalIcon">
				<div class="SbPlot-Highlight plot">플롯1</div>
				<div class="SbPlot-ModalTitle">로 동화책을 씁니다.</div>
				<div class="SbPlot-ModalSubTitle">선택한 플롯이 맞는지 확인 후 만들어주세요.</div>
				<div>
					<button id="SbPlot-CancelBtn" class="SbPlot-CancelBtn">취소하기</button>
					<button id="SbPlotModal-Btn" class="SbPlotModal-Btn"
						onclick="showLoadingAndRedirect('/arti/book/edit?book_idx=${storybook.book_idx}')">
						글 편집 단계로</button>

				</div>
			</div>
		</div>

		<!-- 플롯 수정 팝업창 -->
		<div id="SbPlotModifyModalBack" class="SbPlot-ModifyModalBack"
			style="display: none">
			<div class="SbPlot-ModifyModal">
				<img src="/img/close-icon.svg" id="SbPlotModifyModalClose"
					class="SbPlotModalCloseBtn">
				<div class="SbPlot-ModifyTitle">바꾸고 싶은 내용을 적으면 AI가 플롯을 수정합니다.
				</div>
				<textarea class="SbPlot-ModifyInput"
					placeholder="예시) 주인공의 심리를 자세히 묘사해줘, 목표를 가지는 이유를 설명해줘"></textarea>
				<button class="Modify-SBPModal-btn">생성하기</button>
				<br>
				<div class="Modify-SBPModal-credit">잔여 크레딧 : ${user.coin}</div>
			</div>
		</div>
	</div>

	<!-- 로딩 화면 -->
	<div id="loading-screen" style="display: none;">
		<!-- 처음엔 숨김 -->
		<div class="loading-content">
			<img src="/img/ARTI_Loading.gif" alt="로딩 중" />
			<p>동화책 생성 중입니다</p>
		</div>
	</div>

	<script>
		// 모달창 열기
		document.getElementById('SbSubmitBtn').onclick = function() {
			document.getElementById('SbPlotConfirmModalBack').style.display = 'block';
		};

		// 확인모달창 닫기 (닫기 버튼 클릭 시)
		document.getElementById('SbPlotModalClose').onclick = function() {
			document.getElementById('SbPlotConfirmModalBack').style.display = 'none';
		};

		// 확인모달창 닫기 (취소 버튼 클릭 시)
		document.getElementById('SbPlot-CancelBtn').onclick = function() {
			document.getElementById('SbPlotConfirmModalBack').style.display = 'none';
		};

		// 모달창 배경 클릭 시 닫기
		window.onclick = function(event) {
			var confirmModal = document
					.getElementById('SbPlotConfirmModalBack');
			if (event.target == confirmModal) {
				confirmModal.style.display = 'none';
			}

			var modifyModal = document.getElementById('SbPlotModifyModalBack');
			if (event.target == modifyModal) {
				modifyModal.style.display = 'none';
			}
		};

		/* 플롯 수정 모달 관련 JS */

		//"플롯 수정" 버튼을 눌렀을 때 수정 모달 열기
		document.getElementById('SbModifyBtn').onclick = function() {
			document.getElementById('SbPlotModifyModalBack').style.display = 'block';
		};

		// 수정 모달 창 닫기 (닫기 버튼 클릭 시)
		document.getElementById('SbPlotModifyModalClose').onclick = function() {
			document.getElementById('SbPlotModifyModalBack').style.display = 'none';
		};

		//로딩 화면 표시 함수
		function showLoadingScreen() {
			document.getElementById("loading-screen").style.display = "flex";
		}

		// 로딩 화면 숨김 함수 (필요 시 사용)
		function hideLoadingScreen() {
			document.getElementById("loading-screen").style.display = "none";
		}

		// 폼 제출 이벤트와 로딩 화면 연결
		document.querySelector("form").addEventListener("submit",
				function(event) {
					// 로딩 화면 표시
					showLoadingScreen();

					// 폼이 정상적으로 제출되도록 기본 동작 유지
				});

		function showLoadingAndRedirect(url) {
			// 로딩 화면을 표시
			document.getElementById('loading-screen').style.display = 'flex';

			// 약간의 딜레이를 두고 페이지 이동 (로딩 화면이 확실히 보이도록 설정)
			setTimeout(function() {
				window.location.href = url;
			}, 500); // 0.5초 딜레이
		}
	</script>
</body>
</html>
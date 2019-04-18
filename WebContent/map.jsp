<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<input type="text" id="address">
<button type="button" onclick="move()">지도보기</button>
<div id="map" style="width: 500px; height: 400px;"></div>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7afa81dd64fc9dd5e00fa18dfd8e7f83"></script>

<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	function move() {
		address = $("#address").val(); //주소값 넣을때 앞에 # 붙이기

		$.ajax({
			url : 'https://dapi.kakao.com/v2/local/search/address.json',
			type : 'get',
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Authorization",
						"KakaoAK e65383bbd3ba85acac738b6c41940266");
			},
			data : {
				"query" : address
			},
			success : function(result) {
				documents = result.documents;
				doc = documents[0];
				road_address = doc.road_address;
				x = road_address.x;
				y = road_address.y;
				console.log(x, y);
				// 				$("body").append(result);
				// 				console.log(result);
				map(x, y);
			}
		});
	}
	//주소 입력
	//버튼을 누르면 입력된 주소를 위도, 경도 변환 API로 넘겨줌
	//응답결과(JSON)을 분석(파싱)해서 위도, 경도로 입력해줌
	function map(x, y) {
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new daum.maps.LatLng(y, x), //지도의 중심좌표. 
			level : 3
		//지도의레벨(확대, 축소 정도)
		};
		var map = new daum.maps.Map(container, options); //지도생성 및 객체 리턴
		//마커가 표시될 위치입니다 
		var markerPosition = new daum.maps.LatLng(y, x);
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
			position : markerPosition
		});
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);    
	}
</script>
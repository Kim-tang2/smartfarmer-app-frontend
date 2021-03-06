# 지능형 농장 시스템 (스마트팜) 👨‍🌾

> **스마트팜** : 정보통신기술을 활용해 '시간과 공간의 제약없이' 원격으로 작물의 생육환경을 관측하고 최적의 상태로 관리하는 **과학 기반의 농업 방식** -대한민국 정책브리핑-

국민대학교 2020년 하계 현장 실습 프로그램을 통해 콘캣에서 5명의 팀원들과 스마트팜 시스템을 구축했습니다. 하드웨어팀, 웹프론트팀, 앱프론트팀, 백엔드팀으로 나누어 개발을 진행했고, 저는 **스마트팜 제어 및 대시보드 앱 어플리케이션을 개발했습니다.**

# 사용한 라이브러리 
- flutter_svg: ^0.17.4 : svg(벡터이미지)를 사용하기 위한 라이브러리
- clippy_flutter: ^1.1.1 : 다양한 위젯 모형 변경을 위해 사용한 라이브러리
- provider: ^4.3.1 : UI와 데이터 처리 로직(비즈니스 로직)을 분리하기 위해 사용한 라이브러리
- firebase_auth: ^0.16.1 : firebase에서 제공해주는 로그인 기능을 사용하기 위한 라이브러리
- cloud_firestore: ^0.13.7 : firebase에서 제공해주는 리얼타임 데이터베이스인 firestore를 사용하기 위한 라이브러리
- json_annotation: ^3.0.1, json_serializable: ^3.3.0 : json을 serializable하기 위한 라이브러리
- flutter_swiper: ^1.1.6 : Swiper UI를 사용하기 위한 라이브러리
- dotted_line: ^2.0.0 : 점선 표현을 위해 사용한 라이브러리
- fluttertoast: ^7.0.2 : 토스트 메시지를 띄우기 위한 라이브러리
- barcode_scan: ^3.0.1 : 스마트팜 기기 등록을 하기 위한 QR코드 인식 라이브러리
- shared_preferences: ^0.5.8 : 토큰 정보를 저장하기 위한 라이브러리
- simple_animations: ^1.3.3 : 애니메이션 구현을 위한 라이브러리
- fl_chart: ^0.11.0 : 실시간 스마트팜 데이터를 그래프로 표현하기 위한 라이브러리
- async: ^2.4.1 : 비동기식 프로그래밍을 위한 라이브러리


#  Package Structure 
- animation
    - fade_animation.dart : 페이드 애니메이션 구현 코드

- firebase
  - auth_exception_handler.dart : 영문으로 오는 파이어베이스 로그인 에러를 한국어로 처리 및 에러 핸들링 코드
  - auth_result_status.dart : 에러 코드 enum

- model
  - farmer_model 
    - farmer.dart : 회원가입 및 농장 기기 등록시 데이터베이스에 저장하기 위해 구현된 모델
    - profile_farmer.dart : 회원 정보 모델
  - sensor_model
    - sensor_chart_data.dart : 센서 데이터 모델
    - sensor_chart.dart : 측정된 데이터의 시간과 위에서 정의된 센서 데이터 모델이 정의되어 있다
  - api_response.dart : fetch된 데이터 모델 및 에러 핸들링 모델

- screens
  - auth
    - auth_page.dart : 최초 스플래쉬 페이지입니다. 
    - login_page.dart : 로그인 페이지입니다.
    - signup_page.dart : 회원가입 페이지입니다.
    - forget_page.dart : 비밀번호 찾기 페이지입니다.
  - devices_connect
    - connect_page.dart : 농장 기기등록 및 농장 선택 페이지로 가기 위한 페이지입니다.
    - crop_edit_widget.dart : 농장 기기등록 위젯입니다. 이곳에서 각 품종별 관리 데이터를 수동으로 입력할 수 있습니다.
    - scanner_widget.dart : 농장 기기등록을 위한 qr코드 스캔 위젯입니다.
  - drawer
    - drawer_menu_page.dart : Drawer 페이지입니다.
  - farm_dashboard
    - info_page.dart : 측정된 정보를 시각화한 대시보드 페이지입니다.
    - dashboard_widget.dart : 측정된 정보를 보여주는 카드뷰 위젯입니다.
    - chart_widget.dart : 측정된 정보를 그래프로 보여주는 위젯입니다.
  - farm_list
    - farm_list_page.dart : 등록된 농장들을 보여주는 리스트 페이지입니다.
  - services
    - check_device_overlap.dart : 기기 중복 여부를 검사합니다. 
    - farmer_profile.dart : 데이터베이스에서 사용자의 프로필(닉네임과 등록된 스마트팜 정보)을 조회합니다. 사용자 값에 변동에 생기면 구독하고 있는 옵저버들에게 값을 전달하는 역할도 합니다.
    - get_chart_sensor_data : UI를 위한 Provider입니다. 클릭된 데이터의 종류를 파악합니다. 
    - get_sensor_data : 데이터베이스에서 해당 기기의 최근 상태값을 찾아 반환합니다. 
    - register_device.dart : 새로운 기기 정보를 등록합니다.
    - database_provider.dart : 데이터베이스 사용자 정보에 관한 생성 및 삭제를 담당합니다.
    - firebase_provider.dart : 파이어베이스에 등록된 사용자 계정을 관리합니다. 최근 로그인 사용자 정보, 로그인 기능, 회원가입 기능, 로그아웃 기능, 비밀번호 재설정 기능, 회원 탈퇴기능을 제공합니다.
    - scan_data.dart : 제어 중인 기기 정보를 가지고 있습니다.
  - shared
    - smartfarmer_constants.dart : UI에 필요한 정보들을 가지고 있습니다.

# 사용화면
<img width="231" alt="스플" src="https://user-images.githubusercontent.com/25794831/97884827-e7a42d00-1d69-11eb-9c2b-0461bb4d1876.png"><img width="231" alt="로긴" src="https://user-images.githubusercontent.com/25794831/97884088-00601300-1d69-11eb-85fd-03a989a16e8e.png"><img width="231" alt="회원가입" src="https://user-images.githubusercontent.com/25794831/97884097-02c26d00-1d69-11eb-98dc-5d18fdb9a49d.png">
<img width="231" alt="비번찾" src="https://user-images.githubusercontent.com/25794831/97884101-03f39a00-1d69-11eb-904d-de62028da981.png"><img width="250" alt="기기등록" src="https://user-images.githubusercontent.com/25794831/97884307-44ebae80-1d69-11eb-85de-7945a98f5a24.png">
<img width="250" alt="농장선택페이지" src="https://user-images.githubusercontent.com/25794831/97884286-3b624680-1d69-11eb-83b4-59adade29d6f.png"><img width="250" alt="대시보드" src="https://user-images.githubusercontent.com/25794831/97884344-4f0dad00-1d69-11eb-996d-312940c0cce9.png">







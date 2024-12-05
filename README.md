# stock-city
자바 기반 의류 관리 웹 프로그램의 Dev파트를 담당하여 제작하였습니다.

# 로그인 페이지
![image](https://github.com/user-attachments/assets/36e7a74f-3800-4731-b51b-e0e55a1621d4)

# 회원가입 페이지
![image](https://github.com/user-attachments/assets/18e4d134-ed12-4ee4-99ec-b44ca7e1eb15)
![image](https://github.com/user-attachments/assets/5291bde1-6a23-4879-b8cc-1b666d815a4a)
* 회사명의 앞에 3자리와 무작위 난수 6자리를 합하여 아이디를 생성, 관리자의 가입승인이 아직 결재 되지 않아 dinied 상태로 로그인 불가

# 관리자 로그인 페이지
![image](https://github.com/user-attachments/assets/5035cbfb-9f8e-4dc1-9137-50902ad33d8f)
* 관리자 전용 로그인 페이지 - admin 테이블에 단일 아이디 관리

# 관리자 계정 생성
![image](https://github.com/user-attachments/assets/355f7633-5ca6-46df-b473-eccb3c8e8e88)
![image](https://github.com/user-attachments/assets/5406fa72-5a64-4f55-87d3-d16b46ee89f1)
* 데이터베이스에 qwer이라는 관리자 계정이 1개 이상 존재함으로 ID_you_want 라는 계정은 생성 불가능

# 관리자 페이지 - 고객사 관리
![image](https://github.com/user-attachments/assets/9768996c-f21c-4cbe-9634-0d57e5865055)
![image](https://github.com/user-attachments/assets/5eaea706-7fb2-4b02-92de-a596cc9f53f0)
* 좌측노란색에 기존에 없던 데이터베이스가 관리자 승인 후 우측과 같이, 가입요청 시 생성된 초록색 컬럼의 값을 불러와 DB가 생성된 모습

# 데이터베이스 복제 및 생성
![image](https://github.com/user-attachments/assets/9111496d-dae7-4ed6-9430-bfe638fdbfe0)
* 고객사 별로 데이터베이스를 생성하여 데이터 로딩의 간결화 및 고객사 별 데이터가 섞이지 않아 고객사간 버그나 오류로 인해 정보 누출의 우려 방지

![image](https://github.com/user-attachments/assets/7a269466-a407-4553-85ba-632da329fc60)
* 로그를 출력하여 DB간 전환이 원할하게 이루어지는지 확인

#  이메일 - 계정 전송
![image](https://github.com/user-attachments/assets/41f7d9fb-3f64-4449-9c19-7ca87ad40f90)
* 관리자가 회원가입 승인을 했다면, 회원가입 시 입력한 고객사 이메일로 본사 및 요청한 점포 수 만큼의 계정을 발급하여 전송

![image](https://github.com/user-attachments/assets/3f229f49-cf70-4128-9f13-9a67a4cf862a)
![image](https://github.com/user-attachments/assets/35ebbb40-f441-4a1e-9cbf-6a39bfb7349e)
* 고객사의 계정 추가 요청 시, 추가 발급이 가능한 기능 구현

![image](https://github.com/user-attachments/assets/692ee43e-00ae-4dcf-aca9-2852a0d4388d)
* DB에 정상적으로 추가된 것을 확인

# 매장 정보 수정 및 관리

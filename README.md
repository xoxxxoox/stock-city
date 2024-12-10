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
![image](https://github.com/user-attachments/assets/c454e85b-ea14-4f60-9111-99fcc16fa673)
* 고객사의 점포 계정으로 로그인하여 매장 정보를 수정하는 페이지

![image](https://github.com/user-attachments/assets/57b5b79a-d797-4764-a041-9bd361d0026e)
* 고객사의 본사 계정으로 로그인 시, 프로그램 관리자와 다르게 개별 점포의 계정을 정지, 재활성화, 삭제가 가능

![image](https://github.com/user-attachments/assets/6c329898-6016-4254-839b-002929870935)
* 비활성화 계정은 로그인 불가능

# 본사 상품 등록 / 조회, 수정
![image](https://github.com/user-attachments/assets/57fcaa7f-3882-44b7-8bf9-fb68422349aa)
![image](https://github.com/user-attachments/assets/b4566148-1096-4325-81cb-8b558f626cdb)
![image](https://github.com/user-attachments/assets/5a5d068b-b282-4c54-bbd4-c96fa6d72510)
![image](https://github.com/user-attachments/assets/d058ee57-72c7-42b7-a636-c7eadc3d1dca)
![image](https://github.com/user-attachments/assets/5bdded27-1648-4837-9005-0174e9702d39)
* 고객사 본사에서 상품 등록 부터 조회 및 수정할 수 있는 기능을 구현

# 본사 <-> 매장 상품 입*출고 조회
![image](https://github.com/user-attachments/assets/b9b5986b-346e-488b-9933-b45292f35db3)
![image](https://github.com/user-attachments/assets/c00a53be-d0d4-4697-be75-373cb55a387a)
* 본사에서 타 점포로 상품을 출고 및 조회

![image](https://github.com/user-attachments/assets/c2effa8b-6523-4d78-8bb2-2dcf0a0caad4)
![image](https://github.com/user-attachments/assets/18e1aa92-ed81-4637-95f1-38d16fcbb089)
* 점포에서 본사에 입고 요청을 하는 도중 입고 수량이 재고 수량을 초과하였을 때 오류가 출력되는 기능까지 구현

![image](https://github.com/user-attachments/assets/634d3ea6-e69a-4a3f-b142-1f37b5cc103d)
* 점포에서 본사에 입고 요청을 한 현상태를 표시해 현재 본사의 결재 상태 확인 가능

![image](https://github.com/user-attachments/assets/50c93bb3-ded8-4464-b161-b53a4ac1fbb3)
* 본사 계정에서는 재고 요청에 대한 수락 또는 거절 버튼을 눌러 결재 상태를 최신화 가능

# CSV 파일 다운로드
![image](https://github.com/user-attachments/assets/7fb419e1-77b6-4055-96a5-0a0d7eaee0c5)
![image](https://github.com/user-attachments/assets/cc7bf5d7-27df-48b7-b5a4-82266b0cc488)
* 고객사가 관리자 측에 요청없이 모든 매장의 이동 수량 및 승인 거절 내역을 확인할 수 있도록 로그 파일 기록

# 매장 상품 조회
![image](https://github.com/user-attachments/assets/ae910400-dc8f-4d5a-9ad5-32ccc8d95ff2)
![image](https://github.com/user-attachments/assets/2cebcc26-030a-4191-b002-5a9766f4b1c9)
* 입출고 조회는 요청 수량만 표시되는 반면, 조회 페이지는 각 매장에 상품 전체의 현재 재고를 확인 가능

# DB Schema
![image](https://github.com/user-attachments/assets/c56ed541-8e31-472e-97ff-2b427f74d94f)

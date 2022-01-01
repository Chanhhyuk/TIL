# Network

클라이언트 - 웹 - 서버

클라이언트,서버: 동일한 컴퓨터지만 역할이 나눠져 있음
클라이언트에서 웹, 서버에서 웹을 접근하는 여러가지 프로토콜이 존재
통합해서 TCP/IP라고 부름

## HTTP(HyperText Tranfer Protocol)
- 초기에는 하이퍼 문서를 전송하는데 쓰임
- 현재는 이미지, 영상, 음성, 파일, JSON 등 모든 형태의 데이터 전송가능
- 인터넷의 모든 것은 HTTP 프로토콜로 이루어져 있다


- 애플리케이션단에서 편지지를 작성하면 OS에 던져준다 OS는 조각을 내거나 PORT를 붙인다.(각각의 다른 포트번호를 가지고 있다) 그래야 여러개의 일을 동시에 할 수 있음
- 클라이언트에서 서버로 요청, Request라고 하고 query라고도 한다
- 요청이 먼저 무조건 있어야 그 다음 응답이 일어난다.
- 서버에서 클라이언트로 응답, Response라고 하고 data라고도 한다.

* HTTP 요청 메세지
첫줄은 요청하는 방식     // 메소드 + 요청대상(경로) + HTTP버전
header (헤더 필드)    // 모든 부가 정보 (HTTP 전송에 필요한 메타데이터)
공백라인    
message body (메세지 본문)   // 실제 전송할 데이터(JSON / HTML문서 / 이미지 / 영상 등)

* HTTP 응답 메세지
첫줄은 요청하는 방식     // HTTP버전 + 상태코드 + 문구
header (헤더 필드)    // 모든 부가 정보 (HTTP 전송에 필요한 메타데이터)
공백라인    
message body (메세지 본문)   // 실제 전송할 데이터(JSON / HTML문서 / 이미지 / 영상 등)


- PUT은 전체를 바꾸지만 PATCH는 부분변경 ex) 인스타그램 좋아요
- GET,POST,PUT,DELETE를 쉽게 바꿔서 CRUD로 부른다.

- 기존 문법에서 사용하던 애플이 만들어 놓은 API ex) print()
- 서버와 통신하는 API

- 실제주소?쿼리파라미터 형태 ex) www.naver.com:433/search?dhashdjak
- 쿼리 파라미터를 통한 데이터 전송
- ?로 시작, &(엔퍼센드)로 연결 (추가 가능), 또한 &는 이어서 연결한거기 때문에 & 기준으로 순서를 앞뒤로 바꿔도 상관없다.
- key=value의 형태
- 포트번호는 아파트의 호수번호와 같은 거 / 기본값이기때문에 생략함

- 실제 JSON형태로 데이터가 날라오면 앱에서 사용하기 위해 다시 구조체나 클래스로 변형해서 사용
- 다른 언어들도 사용해야 하닌깐 JSON형식으로 통일한거 아닐까?
- 1,2,3,4 이렇게 클라이언트와 서버간의 약속했다면 통신은 할 수 있음 / 다른사람과 협업을 한다든가 직원이 바뀐다면?
- 파악하기가 어려움, REST API 명사형으로 작성

HTTP 프로토콜로 통신할 때
1. URL - 주소가 있어야 하고
2. URLSession 객체가 있다 (애플이 통신하기위해 만들어 놓은것) / 비유를하자면 브라우저를 키는 행위와 비슷
3. dataTask(일거리)를 던져준다. 비유를 하자면 url을 입력후
4. 시작(resume)이 작동됨 비유를 하자면 엔터를 치는것

애플이 서버와 통신하기위해 미리 만들어 놓은 객체 URL(구조체)
```swift
let naverURL = "https://naver.com/search?"

let structUrl = URL(string: naverURL) // naverURL은 문자열이였는데 생성자에 넣어준다.
                                      // URL 은 문자열을 가지고 구조체로 바꿔준다.
                                      // 에러가 날 수도 있기 때문에 옵셔널형태로 선언됨
// URLSession(생성자)
// 따로 변수를 선언할게 아니라 URL(string: )에다가 직접적으로 넣어도 된다. 

let session = URLSession(configuration: . default) // 일반적으로 디폴트값을 준다.
// URLSession: URL세션을 만듬

let session = URLSession.shared     // 싱글톤을 생성하는 타입속성이 있다.
//싱글톤 여러개를 찍어내는게 아니라 유일하게 메모리에서 딱 하나만 존재하는

// URLSession.shared 이것도 따로 변수 선언이 아니라 바로 dataTask 앞에 바로 사용가능
                                      
session.dataTask(with: structUrl, completionHandler:(여기서 엔터를 치면 xcode가 트레일링 형식으로 바꿔준다.)
dataTask라는 함수가 with로 받은 url로 네트워크 통신을 다 한 다음에 그결과를 데이터나 리스폰 에러를 주는것

Data? 데이터가 있을수도 있고 없을수도 있다
URLResponse? 응답이 있을수도 있고 없을수도 있다.
Error? 에러가 있을수도 있고 없을수도 있다.
파라미터를 마음대로 써도 된다 예를들어 앞글자만 따서 d,r,e 하지만 data,response,error로 사용하는거 추천

// 보통은 이런 형식으로 사용
let task = sesseion.dataTask(with: structUrl) { data, response, error in // 변수 task에 넣어서
    if error != nil {       // 에러가 nil이 아니라면 즉 에러가 발생한다면 (일반적으로 에러를 먼저 처리함)
        print(error.localizedDescription)       // 에러 출력
        return              // 종료
    }
    
    if let safeData = data {        // data가 nil이 아니라면 출력하겠다
        print(safeData)
        String(decoding: safeData, as: UTF8.self)   // 보통은 이렇게 사용함 데이터를 문자열로 출력할 때
            // 실제로는 개발자가 사용하려는 형태(구조체 / 클래스)로 변형시키걸 작성해야함 여기다가
    }
    
}.resume()          // 변수 test와 task.resume()을 생략하는 대신에 이렇게 .으로 붙여서 실행도 됨
 
task.resume()       // 작업이 멈춤상태인데 실행하게끔 해줌
```

## URLSession
- GET메서드는 URL주소만 있어도 됨 즉 GET 생략가능
- 서버에서 응답메시지가 오면 메세지가 길게 오는데 불필요한것들은 빼고 필요한것들만 우리가 작성한 클로저로 넘어오는것
- URL: 구조체를 생성해서
- dataTask: http메시지 형식으로 만들고 리퀘스트를 하면 한 결과가 응답으로 온다 그러면 알아서 불필요한것들만 없앤다
- 클로저에 data를 어떻게 처리할지 response를 어떻게 처리할지 error를 어떻게 처리할지 정의를 개발자가 해주면
- resume으로 사용

```swift
guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else{
    print("Error: HTTP request failed")
    return
}
// response 응답이 오면 그 응답을 HTTPURLResponse로 타입캐스팅 한 다음에 변수 let response에 다시 담는다
// response에는 statusCode(응답코드) 가 있는데 그 범위가 200에서 299일 경우 guard문이닌깐 다음으로 넘어감
// 그냥 이렇게도 사용할 수 있다. 외울필요 x
```

## JSON Parsing
JSON 옛날형태도 공부
- quicktype: JSON을 일일이 작성안하게끔 간편하게 만들어줌
- JSONDecoder(): 데이터를 원하는 코드로 변환
- decode 라는 메서드가 있는데 개발자가 변형하고싶은 메서드를 넣어준다 뒤에 self까지 붙여줘야함 여기서 self는 붕어빵 자체가 아니고 붕어빵 틀을 말한다.
- Decodable: 데이터를 코드로변환
- Encodable: 코드를 데이터로 변환
- Codable: Decodable,Encodable을 합해서 사용하는 프로토콜
- Codable: 채택해야지만 자동으로 분석해줌 채택해주지 않으면 JSONDecoder가 따로 분석을 안하기 때문에 분석이 안됨




dump(): print()와 같지만 더 자세하고 더 깔끔하게 출력









## Network communication (네트워크 통신)
네트워크 통신은 Network server와 DB server를 갖추고 안정적으로 운영하기 위해 IDC에 관리를 위탁해야하며 불법적인 접근과 해킹을 막기 위해 firewall(방화벽)을 설치해야 하고 대량의 요청을 처리하기 위해 SLB(부하분산장치)도 추가 해야한다.

종류

Socket(소켓) 방식의 연결 지향 통신
Socket(소켓)을 이용한 네트워크 방식 보통 Low-level(저수준)통신을 통하여 구현된다. 앱과 서버가 연결되면 한쪽에서 명시적으로 끊을 때까지 지속해서 연결을 유지하는 방식.
연결이 계속 유지하므로 재연결할 필요 없이 원하는 만큼 빠르게 메시지를 주고 받는다는 장점이 있지만 네트워크 대역의 많은 소모와 서버 부하가 크다는 단점이 있다.

TCP는 완전한 전송을 보장하지만 상대적으로 덜 빠르다.
UDP는 완전한 전송을 보장하지 않지만 더 빠르다. 

비연결 지향 통신
대표적으로 HTTP/HTTPS 프로토콜이 있으며 웹 서비스에 주로 사용된다.
요청이 들어오면 이에 맞는 응답을 보낸 후 바로 연결을 종료한다. 
단지 연결을 유지하지 않는 것일 뿐.

### HTTP 메시지
주소줄에 도메인을 입력하거나 특정 링크를 클릭하여 원하는 페이지로 이동할 때 일정한 형식을 갖춘 텍스트 기반 메시지로 변환되어 웹 서버로 전달되는데 이 메시지 형식을 HTTP 메시지 라고 한다.

### HTTPS
HTTP 경우 모두 평문 그대로 전송하기 때문에, 누군가 패킷을 훔쳐보는Sniffing(스니핑) 공격에 취약하다. 금융이나 개인정보 메시지처럼 보호될 필요가 있을 때에는 인증서를 통해 패킷을 암호화한 다음에 전송하게 되는데 이것을 HTTP + S(Seciroty)인 HTTPS라고 부른다. HTTPS 통신은 단순히 HTTP통신 프로토콜에 S를 붙여준다고 지원되는게 아니다 보안 통신을 위해서는 신뢰성있는 인증기관에서 발급한 인증서를 서버에 설치해 주어야 한다.

### HTTP 메시지의 구조
HTTP 메시지는 크게 Request(요청)메시지와 Response(응답) 메시지로 나눌 수 있다. 둘다 라인-헤더-바디 세 부분으로 구성된다.
라인은 응답/요청 여부, 메시지 전송 방식 상태 정보 등이 작성됨.
헤더는 메시지 본문에 대한 메타 정보가 들어가는 곳.
바디는 실제로 보내고자 하는 메시지 본문 내용이 들어감.
HTTP는 매우 정형화되어 있어서, 라인은 무조건 한 줄로만 작성된다. 그 아래에는 필요한 만큼 여러 줄로 작성된 헤더가 들어간다.
헤더와 바디는 유동적이므로, 구분을 위해 한 줄의 공백이 삽입된다.
즉 첫번재는 무조건 라인영역이고 다음 내용들은 공백 한줄이 나타날때까지 헤더로 간주한다.
```
POST /userAccount/login HTTP/1.1
Host: swiftapi.naver.com:2029 
Content-Type: application/x-www-form-urlencoded

account=swift%40swift.com&passwd=1234&grant_type=password
```
header는 key : value로 이뤄진다.
두 개이상의 도메인이 연결되어있을 경우 구분하기 위해 포트번호 사용
POST 방식이다. 회원가입 로그인 게시판 글쓰기 등 많은 UI들이 대부분 이 방식을 사용해서 서버로 값을 전송한다.
API 연동을 위해 사용할 메시지 형식이 JSON이라면(대부분이 JSON이다) Content-Type 헤더의 값을 application/json으로 설정해 주어야 한다. 그렇지 않으면 서버에서 메시지 본문을 제대로 해석하지 못할 수 있다.

공백라인 아래는 본문내용이다. 헤더의 Content-Type에 설정된 타입과 일치해야 한다. 예를 들어 account, passwd, grant_type의 세개이므로 이를 x-www-form-urlencoded 타입으로 이들 데이터를 &로 연결하여 메시지 본문을 넣어야 한다. 여기서 특수문자의 경우 URLEncoding 형식으로 변환한다.

```
GET /userAccount/login?account=swift@naver.com&amp;passwd=1234&amp;grand_type=password HTTP/1.1
Host: api.naver.com:2029
Cache-Control: no-cache
```

메시지 본문이 사라지고, 본문에 있어야할 값이 첫 번째 라인의 경로 뒤에 ? 문자열과 함께 연결되었다.
GET 방식에서는 파라미터를 모두 URL 뒤에 연결해서 전달하기 때문이다. 이렇게 연결된 파라미터를 Query String(쿼리 스트링) 이라고 한다.
GET방식은 메시지 본문을 사용하지 않기 때문에 Content-Type 헤더가 사용되지 않는다. 또한 URL 뒤에 쿼리 스트링만 연결하면 되므로 비교적 간결하세 정보를 전달 할 수 있다는 장점이 있다. 하지만 URL경로는 1024Byte 까지만 허용되기 때문에, 긴 값을 GET방식으로 전송할 수 없다. 그래서 데이터를 전송하기 보단 요청할 때 주로 사용된다.

메소드(전송 방식)|목적|
---|---
GET|특정 리소스의 대표적인 정보를 요청할 때
POST|ID 없이 리소스를 생성하거나 수정할 때
PUT|ID 기반으로 리소스를 생성하거나 수정할 때
DELETE|리소스를 삭제할 때
HEAD|GET 방식의 요청이지만 내용 없이 메타정보만 요청할 때
OPTIONS|특정 URL에 대한 보조 메소드 역할

## RESTful API (Representational State Transfer) 
HTTP를 위한 아키텍처의 한 형식. 네트워크 프로토콜이라기 보다는 네트워크 자원을 정의하고 자원에 대한 주소를 관리하는 방법.
HTTP 기반으로 간단히 주고 받기 위해 정의된 간단한 형식의 인터페이스.
기존 HTTP 프로토콜을 사용하기 편하다
REST 구조를 따라 구현된 시스템을 RESTful 이라고 한다.
RESTful 기반으로 서버에서 요청과 응답을 주고 받을 수 있도록 정의된 형식을 RESTful API라고 한다.
특히 RESTful API는 메시지 본문을 JSON형식으로 보내기 때문에 RESTful API 통신을 위해서는 JSON 데이터 형식을 잘 이해하고 있어야 한다.




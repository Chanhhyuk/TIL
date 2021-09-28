# Git?
본인이 있는곳을 Local(지역) 이라고 하고 다른 컴퓨터를 Remote(원격) 이라고 한다.
Git은 Local에서 돌아가는 버전관리 프로그램.
GitHub는 Remote에서 이 버전들을 저장해놓은 저장소.

## Local과 Remote를 연결하는 두가지방법 
1. git remote add origin repository주소
Local에 저장소 폴더를 만들고 git init으로 .git을 만든다.
GitHub에서 repository를 만든다.
git remote 명령어로 repository와 내 Local folder를 연결한다.

2. git clone repository주소
repository를 만들고 주소를 clone 한다.
clone할 폴더를 만들고 git clone 명령어로 local에 repository를 만든다.
git clone은 git init으로 저장소를 만들지 않아도 .git이 생긴다.
.git 폴더 확인 후 내 파일들을 옮긴다.

## git config —global
git을 설치하고 가장 먼저 하는 초기설정.

1. git config —global user.name “Name”
유저 이름 등록
2. git config —global user.email “google@gmail.com”
이메일 등록

git config —list 로 적용됫는지 확인.

## git add
git add - Staging Area에 파일을 넣는다.
git reset HEAD [fileName]
staged 상태된 파일을 Unstaged 상태로 변경된다.
파일명이 없으면 add한 파일 전체를 취소한다.

## git rm
Local에 폴더나 파일을 삭제 및 이동을 하고 push를 할 시 GitHub는 그대로 유지된다. local에서 삭제 한다고 remote에서 삭제가 이루어지지 않는다.
```
git rm <fileName> // 원격 저장소와 로컬 저장소에 있는 파일 삭제
git rm —cached <fileName> // 원격저장소에 있는 파일만 삭제
git rm <file> // 하나씩 제거
git add -u // 전부제거
그 다음 commit과 push를 하면 된다.
```
cached 옵션은 작업시에만 쓰는 파일이나 로그는 작업할 때 필요하지만 저장소에는 올리지 않아될 때 주로 사용한다.

## git reset

1. git reset --hard
마지막 commit 전으로 롤백
2. git reset --hard 커밋해쉬코드
특정 commit 지점으로 롤백
3. git reset HEAD^
commit을 취소하고 unstaged 상태로 변경
4. git reset —soft HEAD^
commit을 취소하고 staged 상태로 변경

## git branch
1. 협업할 때 작업공간을 나눠서(branch) 작업하고 나중에 한번에 합치는것(Marge)
2. 같은파일 같은라인을 수정했다면 conflict를 해결해 주어야 한다. 
그래서 협업 할 때는 파일이 분리가 되어있는것이 좋다.
3. 혼자서 작업할 때도 사용가능.
4. 브랜치를 몰라도 협업은 가능하다 대신 번거롭다.
push로 올리기전에 pull로 내 local을 매번 업데이트를 해줘야 한다.
근데 이 경우는 서로 다른 파일을 변경하거나 생성할 경우고
같은파일의 같은라인을 변경한 상태에서 내가 push를 하면 CONFLICT!! 충돌에러가 난다.

git branch : 현재 생성되어있는 브랜치의 목록을 확인.
git branch name : name이라는 새로운 브랜치를 만든다.
git checkout name : name 브랜치로 이동한다.
git branch -D name : name 브랜치를 삭제한다.
git push origin name : name 브랜치를 푸쉬한다.
git pull origin name : name 브랜치를 GitHub에서 가져와서 Local을 최신화한다.

## git fork
다른사람의 리포지토리를 그대로 복제(Fork)해서 내 리포지토리로 가져오는것
오픈소스에도 기여할 수 있다.
구글이나 애플 코드에 PR을 넣었는데 그게 Merge가 됐다면
그것만으로도 엄청난 실력증명이 된 셈

## git clone
git clone —mirror {기존 Repository 주소}
기존에 작업하던 Repository에서 새로운 Repository로 옮기고 싶을 때 clone하고 push 하면 끝이다. 하지만 commit과 log까지 모두 옮기고 싶을 때 사용.


## gitignore
git push origin main repository 
메인 브랜치에 현재 커밋들을 넣는다.
git pull origin main 
Server에서 변경사항이 일어난 것을 Local로 동기화 한다.
git config - git 환경설정
git config --global core.editor “code” - vscode로 보기
git log // commit history 확인
git commit —amed // commit message를 잘못 적은 경우

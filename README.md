# SafeWorkHat
2024 Smarthon SafeWorkHat

### 1. 커밋(Commit)
커밋은 로컬 저장소에 변경 사항을 저장하는 과정입니다.
1. 변경 파일 확인
2. 작업 디렉토리의 변경 사항을 확인: git status
3. 변경 파일 스테이징
- 변경된 파일을 스테이징 영역에 추가:
git add <파일 이름>      # 특정 파일 추가
git add .                # 모든 변경 파일 추가
4. 커밋 저장
- 변경 사항을 로컬 저장소에 저장:
git commit -m "커밋 메시지"

### 2. 푸시(Push)
로컬 저장소의 커밋을 원격 저장소(GitHub 등)에 업로드합니다.

1. 푸시 명령어 실행
2. 원격 저장소로 변경 사항 업로드:git push origin <브랜치 이름>
- 예시: 기본 브랜치인 main에 푸시하려면: git push origin main
- 원격 저장소 로그인 필요 시 GitHub 계정의 사용자명과 토큰(패스워드)을 입력해야 합니다. 토큰은 GitHub에서 생성하여 사용합니다.

### 3. 풀(Pull)
원격 저장소의 최신 변경 사항을 로컬 저장소에 가져옵니다.
1. 풀 명령어 실행
- 원격 저장소에서 최신 변경 사항 가져오기: git pull origin <브랜치 이름>
- 예시: 기본 브랜치 main을 업데이트하려면: git pull origin main

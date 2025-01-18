# 1. 프로젝트 디렉토리 준비
### 1.1 프로젝트 구조
- 프로젝트 디렉토리가 다음과 같아야 한다:

SafeWorkHat/      
├── asset/   
│   ├── 자동차1.jpeg   
├── src/   
│   ├── test.py   
├── static/   
├── templates/   
└── Dockerfile   

### 1.2 Dockerfile 내용
Dockerfile에는 YOLOv8 및 필요한 라이브러리를 설치하는 명령을 포함한다:


### 1.3 Dockerfile 내용
- 베이스 이미지 설정 (Python 3.11 Slim 버전)
- Dockerfile에는 YOLOv8 및 필요한 라이브러리를 설치하는 명령을 포함한다:

```python
# 베이스 이미지 설정 (Python 3.11 Slim 버전)
FROM python:3.11-slim

# 작업 디렉토리 설정
WORKDIR /app

# 시스템 종속성 설치
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean

# Python 패키지 관리 도구 업데이트
RUN pip install --no-cache-dir --upgrade pip

# YOLOv8 및 기타 종속성 설치
RUN pip install --no-cache-dir ultralytics opencv-python-headless

# 로컬 파일 복사
COPY src/ /app/src
COPY asset/ /app/asset

# 작업 디렉토리로 이동
WORKDIR /app/src

# 기본 실행 명령어 설정
CMD ["python", "test.py"]
```

# 2. Docker Compose 설정 (옵션)
### 2.1 docker-compose.yml 생성
여러 컨테이너를 관리하거나 추가적인 설정이 필요할 경우 docker-compose.yml 파일을 생성: 

```
touch docker-compose.yml
```
### 2.2 docker-compose.yml 내용
YOLOv8를 실행할 환경을 정의:

```python
version: "3.9"

services:
  safeworkhat:
    build: .
    container_name: safeworkhat_app
    volumes:
      - ./src:/app/src
      - ./asset:/app/asset
    ports:
      - "5001:5000"
    command: python /app/src/test.py
```

# 3. 도커 빌드 및 실행
### 3.1 이미지 빌드
- SafeWorkHat 디렉토리에서 다음 명령을 실행하여 도커 이미지를 생성: 
```
docker build -t safeworkhat .
```
### 3.2 컨테이너 실행
생성한 이미지를 기반으로 컨테이너를 실행: 
```
docker run --rm -it -v $(pwd)/src:/app/src -v $(pwd)/asset:/app/asset safeworkhat
```
### 3.3 Docker Compose 사용 (옵션)
docker-compose.yml을 사용하여 실행: 
```
docker-compose up
```
# 4. 팀원들과 환경 공유
- 프로젝트 푸시 프로젝트를 팀의 GitHub 리포지토리에 푸시:
```
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/SafeWorkHat/SafeWorkHat.git
git push -u origin main
```

- 팀원 설정 팀원들은 프로젝트를 클론한 후 다음 명령어를 실행하여 동일한 환경을 구축:

```
git clone https://github.com/SafeWorkHat/SafeWorkHat.git
cd SafeWorkHat
docker-compose up
```

# 4. 동일한 작업 환경에서 작업 단계

## 1. GitHub에서 프로젝트 클론
- 팀원들은 GitHub 리포지토리에서 프로젝트를 클론합니다.
- 이때 해당 작업 공간을 저장할 위치보다 한 단계 상위 폴더에서 진행해야한다!
```
git clone https://github.com/SafeWorkHat/SafeWorkHat.git
cd SafeWorkHat
```


- 클론한 디렉토리 구조는 다음과 같아야 합니다:
```
SafeWorkHat/
├── Dockerfile
├── docker-compose.yml  # (옵션: 있는 경우)
├── src/
│   ├── test.py
├── asset/
│   ├── 자동차1.jpeg
├── static/
├── templates/
```

## 2. 도커 설치
- Docker Desktop을 설치합니다. Mac (Apple Silicon) 용 버전을 선택해야 합니다.
- 혹은 윈도우 버전을 사용해도 무방하다.
- 설치 후, 도커가 정상적으로 작동하는지 확인합니다:
```
docker --version
```
- 출력 결과가 정상적이라면 도커가 제대로 설치된 것입니다.

## 3. Docker 이미지 빌드
- 프로젝트 디렉토리 (SafeWorkHat/)로 이동한 뒤, 도커 이미지를 빌드합니다:
```
docker build -t safeworkhat .
```
- safeworkhat: 이미지를 식별하기 위한 이름입니다.
- 빌드 과정이 완료되면, 도커 이미지 목록에서 확인할 수 있습니다:

```
docker images
```
- 출력 결과에 safeworkhat 이미지가 표시됩니다.

## 4. 도커 컨테이너 실행
### 4.1. 단일 명령어로 실행
- 도커 이미지를 실행하여 컨테이너를 생성합니다:
```
docker run --rm -it -v $(pwd)/src:/app/src -v $(pwd)/asset:/app/asset safeworkhat
```

--rm: 컨테이너 종료 시 삭제합니다.
-it: 대화형 터미널을 제공합니다.
-v: 로컬 디렉토리를 컨테이너 내부에 마운트합니다.

$(pwd)/src:/app/src: 로컬 src 디렉토리를 컨테이너의 /app/src로 연결합니다.
$(pwd)/asset:/app/asset: 로컬 asset 디렉토리를 컨테이너의 /app/asset로 연결합니다.

### 4.2. Docker Compose로 실행 (옵션)
- docker-compose.yml 파일이 포함된 경우, 도커 컴포즈를 사용하여 실행합니다:
```
docker-compose up
```
- 이 방법은 설정 파일에서 환경 및 옵션을 정의하고, 단순히 명령 한 줄로 실행합니다.

## 5. YOLOv8 테스트
- 컨테이너 실행 중 YOLOv8 테스트가 자동으로 실행되도록 설정되어 있으므로 결과가 출력됩니다. 
- src/test.py 파일에서 모델이 로드되고, asset/자동차1.jpeg 이미지에서 객체 탐지를 수행합니다.

## 6. 작업 환경 유지 및 업데이트
### 6.1 새로 업데이트된 Dockerfile 적용
- 만약 도커 파일이나 프로젝트 코드가 업데이트되었다면, 팀원들은 GitHub에서 최신 업데이트를 가져옵니다:
```
git pull origin main
```

- 새로 이미지를 빌드합니다:
```
docker-compose build
```

- 또는, Dockerfile을 기준으로:
```
docker build -t safeworkhat .
```

- 컨테이너를 다시 실행합니다:

```
docker-compose up
```
- 또는:
```
docker run --rm -it -v $(pwd)/src:/app/src -v $(pwd)/asset:/app/asset safeworkhat
```
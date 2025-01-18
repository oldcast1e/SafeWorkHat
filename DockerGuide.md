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

1.2 Dockerfile 내용
Dockerfile에는 YOLOv8 및 필요한 라이브러리를 설치하는 명령을 포함한다:

'''
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

'''

# 2. Docker Compose 설정 (옵션)
### 2.1 docker-compose.yml 생성
여러 컨테이너를 관리하거나 추가적인 설정이 필요할 경우 docker-compose.yml 파일을 생성: touch docker-compose.yml

### 2.2 docker-compose.yml 내용
YOLOv8를 실행할 환경을 정의:

'''
version: "3.9"

services:
  safeworkhat:
    build: .
    container_name: safeworkhat_app
    volumes:
      - ./src:/app/src
      - ./asset:/app/asset
    ports:
      - "5000:5000"
    command: python /app/src/test.py
'''

# 3. 도커 빌드 및 실행
### 3.1 이미지 빌드
- SafeWorkHat 디렉토리에서 다음 명령을 실행하여 도커 이미지를 생성: docker build -t safeworkhat .

### 3.2 컨테이너 실행
생성한 이미지를 기반으로 컨테이너를 실행: docker run --rm -it -v $(pwd)/src:/app/src -v $(pwd)/asset:/app/asset safeworkhat

### 3.3 Docker Compose 사용 (옵션)
docker-compose.yml을 사용하여 실행: docker-compose up

# 4. 팀원들과 환경 공유
- 프로젝트 푸시 프로젝트를 팀의 GitHub 리포지토리에 푸시:
'''
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/SafeWorkHat/SafeWorkHat.git
git push -u origin main
'''

- 팀원 설정 팀원들은 프로젝트를 클론한 후 다음 명령어를 실행하여 동일한 환경을 구축:

'''
git clone https://github.com/SafeWorkHat/SafeWorkHat.git
cd SafeWorkHat
docker-compose up
'''
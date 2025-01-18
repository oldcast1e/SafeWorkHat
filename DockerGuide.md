# 1. 프로젝트 디렉토리 준비
1.1 프로젝트 구조
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
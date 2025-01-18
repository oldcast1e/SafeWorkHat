# 베이스 이미지로 Python 3.8 사용
FROM python:3.8-slim

# 작업 디렉토리 설정
WORKDIR /app

# 필요한 시스템 라이브러리 설치
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0

# Python 패키지 관리 도구 업데이트
RUN pip install --upgrade pip

# YOLOv8 및 기타 종속성 설치
RUN pip install ultralytics opencv-python-headless flask

# 소스 코드 복사
COPY src/ /app/src
COPY static/ /app/static
COPY templates/ /app/templates

# 작업 디렉토리로 이동
WORKDIR /app/src

# 기본 실행 명령어 설정
CMD ["python", "test.py"]

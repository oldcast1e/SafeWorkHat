from ultralytics import YOLO

# YOLOv8 모델 로드
model = YOLO("yolov8n.pt")  # YOLOv8 모델 파일 경로

# 이미지에서 객체 탐지
results = model("/Users/apple/Desktop/Python/Github/SafeWorkHat/asset/자동차1.jpeg")  # 이미지 경로

# 각 결과를 순회하여 표시
for result in results:
    result.show()  # 탐지된 결과를 시각화

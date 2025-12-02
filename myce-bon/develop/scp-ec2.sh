#!/bin/bash

KEY=~/.ssh/test-keypair.pem
BASTION=ec2-43-203-213-253.ap-northeast-2.compute.amazonaws.com
PRIVATE=10.0.3.50
PROXY="ProxyCommand=ssh -i $KEY -W %h:%p ec2-user@$BASTION"

echo "🚀 배포 시작..."
if [ -z "$1" ]; then
    echo "사용법: $0 <파일경로>"
    echo ""
    echo "예시:"
    echo "  $0 .env"
    echo "  $0 build/libs/app.jar"
    exit 1
fi

FILE="$1"  # ← 이 줄이 필요!

# 1. 파일 존재 확인
if [ ! -f "$FILE" ]; then
    echo "❌ J파일을 찾을 수 없습니다: $JAR_FILE"
    exit 1
fi

FILENAME=$(basename "$FILE")

# 전송
echo "📤 $FILE → EC2 ~/app/$FILENAME"
scp -i $KEY -o "$PROXY" "$FILE" ec2-user@$PRIVATE:~/app/$FILENAME

if [ $? -eq 0 ]; then
    echo "✅ 전송 완료!"
else
    echo "❌ 전송 실패!"
    exit 1
fi

# 3. 원격 스크립트 실행
echo "🔄 서버 시작 중..."
ssh -i $KEY -o "$PROXY" ec2-user@$PRIVATE "bash ~/app/start.sh"

echo "✅ 배포 완료!"

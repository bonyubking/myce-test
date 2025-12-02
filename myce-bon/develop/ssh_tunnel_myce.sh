#!/bin/bash

# MYCE RDS 접근을 위한 SSH 터널
# 로컬 포트 3307을 dbtunnel 서버를 통해 RDS 엔드포인트의 3306 포트로 포워딩합니다

RDS_ENDPOINT="terra-bon-terra-mysql.chi8420e4ql5.ap-northeast-2.rds.amazonaws.com"  # 실제 RDS 엔드포인트 주소로 바꿔주세요

REMOTE_HOST="3.36.55.168"
REMOTE_USER="ec2-user"
PRIVATE_KEY="$HOME/.ssh/terra_myce_keypair.pem"
LOCAL_PORT=3307
REMOTE_PORT=3306

echo "SSH 터널 시작: localhost:${LOCAL_PORT} → ${RDS_ENDPOINT}:${REMOTE_PORT} (${REMOTE_USER}@${REMOTE_HOST} 경유)"
ssh -N -L ${LOCAL_PORT}:${RDS_ENDPOINT}:${REMOTE_PORT} ${REMOTE_USER}@${REMOTE_HOST} -i ${PRIVATE_KEY}

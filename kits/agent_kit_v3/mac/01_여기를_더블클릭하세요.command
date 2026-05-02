#!/usr/bin/env bash
# Vericum Agent 원클릭 설치 v3.0 (macOS) — 진입점
# .command 확장자라 macOS 에서 더블클릭 시 Terminal.app 으로 실행됨
# 처음 실행 시 "권한 거부" 뜨면 README 하단의 chmod 안내 따라 진행

# 스크립트가 있는 폴더 이동
cd "$(dirname "$0")" || exit 1

# UTF-8 로케일 강제 (한글 출력)
export LANG="ko_KR.UTF-8"
export LC_ALL="ko_KR.UTF-8"

# 메인 setup.sh 실행
bash "./setup.sh"

# 종료 후 창 유지
echo ""
read -p "Enter 키로 창 닫기"

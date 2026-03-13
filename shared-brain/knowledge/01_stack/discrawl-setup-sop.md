---
title: Discrawl Discord Archiving SOP
description: Standard Operating Procedure for archiving Discord guilds to local SQLite using Discrawl.
tags: [discord, archiver, discrawl, automation, setup]
trigger: 사용자가 Discord 서버 데이터 백업을 요청하거나, 새로운 서버를 추가할 때.
---

# Discrawl Discord Archiving SOP

## 1. 전제 조건 (Prerequisites)
1.  **Discord Bot Token**: 개발자 포털에서 발급받은 봇 토큰.
2.  **Permissions (필수)**:
    - **Intents**: `Presence`, `Server Members`, `Message Content` ON.
    - **Permissions**: `View Channels`, `Read Message History`.
3.  **환경**: `discrawl` 바이너리가 `/usr/local/bin/discrawl`에 설치되어 있어야 함.

## 2. 서버 초대 절차 (Critical)
서버에 봇이 단순히 참여한 것만으로는 부족할 때가 있습니다. 반드시 아래 절차를 준수하십시오.

1.  **OAuth2 URL 생성**: [Discord Developer Portal](https://discord.com/developers/applications) -> [OAuth2] -> [URL Generator].
2.  **Scopes & Permissions**: `bot` 체크 후 `View Channels`, `Read Message History` 권한 선택.
3.  **서버 초대**: 생성된 URL로 봇 초대.
4.  **권한 검증**: 서버의 [서버 설정] -> [통합(Integrations)]에서 봇이 인식되는지 확인.

## 3. 설치 및 동기화 절차 (Setup)

### 3.1. 환경 변수 설정
```bash
export DISCORD_BOT_TOKEN="your-token-here"
```

### 3.2. 초기화 및 서버 탐색
반드시 봇이 초대된 서버의 정확한 **Guild ID**를 사용해야 합니다.
```bash
# 발견된 서버 리스트 확인
discrawl init --guild <GUILD_ID>

# 데이터 동기화 시작
discrawl sync --full --guild <GUILD_ID>
```

## 4. 문제 해결 (Troubleshooting)

### Q: 동기화 시 데이터가 0건으로 나옵니다.
- **원인 1 (권한):** 봇이 서버에 초대되지 않았거나 읽기 권한이 부족함.
- **원인 2 (ID 불일치):** 대화 중인 채널 ID와 서버(Guild) ID를 혼동함. 디스코드 개발자 모드에서 [서버 ID 복사]를 통해 정확한 Guild ID를 획득하십시오.
- **원인 3 (인텐트):** 개발자 포털에서 `MESSAGE CONTENT INTENT`가 꺼져 있으면 메시지를 긁어올 수 없습니다.

### Q: 인증 실패(401 Unauthorized)가 뜹니다.
- **조치:** `DISCORD_BOT_TOKEN` 환경 변수가 올바른지 확인하십시오. 토큰이 올바르다면 [Reset Token] 후 다시 진행하십시오.

---
## 5. 관리 명령어
- **상태 확인**: `discrawl doctor` (토큰 소스, DB 연결 확인)
- **메시지 검색**: `discrawl search "키워드"`
- **실시간 테일링**: `discrawl tail` (대화 실시간 반영)

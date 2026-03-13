---
title: Discord 데이터 서버별 분리 관리 원칙
description: Discrawl을 활용하여 여러 디스코드 서버의 데이터를 데이터베이스 및 설정 경로별로 독립 관리하는 SOP.
tags: [discord, archiver, discrawl, automation, database-management]
trigger: 서버별로 데이터를 분리하여 관리해야 하거나, 새로운 서버를 추가할 때.
---

# Discord 데이터 서버별 분리 관리 원칙

## 1. 개요
`discrawl`은 기본적으로 단일 설정(`config.toml`)을 공유하도록 설계되어 있어, 여러 서버를 관리할 경우 데이터가 섞이거나 길드 ID 매핑 오류가 발생할 수 있습니다. 이를 방지하기 위해 **서버별로 독립된 설정 및 데이터베이스 디렉토리를 구축**하여 데이터를 엄격히 분리합니다.

## 2. 서버별 분리 관리 원칙
1.  **독립 디렉토리:** 각 서버마다 `~/.discrawl_<SERVER_ID>` 디렉토리를 생성합니다.
2.  **독립 설정:** 각 디렉토리 내에 전용 `config.toml`을 생성합니다.
3.  **독립 DB:** `config.toml` 내 `db_path`를 각 디렉토리 내 `discrawl.db`로 지정하여 데이터베이스 파일을 완전히 분리합니다.
4.  **명시적 호출:** 모든 명령어 실행 시 `--config ~/.discrawl_<SERVER_ID>/config.toml` 옵션을 사용하여 작업 대상을 명확히 합니다.

## 3. 관리 명령어 (SOP)
새로운 서버를 추가하거나 기존 서버를 동기화할 때는 반드시 아래 패턴을 따릅니다.

### 3.1. 서버별 초기화 및 동기화
```bash
# 1. 전용 디렉토리 생성
mkdir -p ~/.discrawl_<SERVER_ID>

# 2. 전용 config.toml 작성 (상세 내용은 sop 참고)
# 3. 명시적 호출을 통한 동기화
discrawl --config ~/.discrawl_<SERVER_ID>/config.toml init --guild <SERVER_ID>
discrawl --config ~/.discrawl_<SERVER_ID>/config.toml sync --full --guild <SERVER_ID>
```

### 3.2. 서버별 작업 호출
```bash
# 특정 서버 데이터 검색
discrawl --config ~/.discrawl_<SERVER_ID>/config.toml search "키워드"

# 특정 서버 SQL 분석
discrawl --config ~/.discrawl_<SERVER_ID>/config.toml sql 'SELECT * FROM messages LIMIT 10'
```

---
*본 원칙은 데이터 무결성을 보장하고, 서버별 독립적인 콘텐츠 분석(콘텐츠 팩토리 추출 등)을 위해 필수적으로 준수한다.*

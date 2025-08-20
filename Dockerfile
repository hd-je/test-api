# --------- Build Stage ---------
FROM gradle:8.4.3-jdk21-alpine AS build

# 작업 디렉토리 설정
WORKDIR /home/gradle/src

# 프로젝트 파일 복사
COPY --chown=gradle:gradle . .

# 빌드 실행
RUN gradle clean build --no-daemon

# --------- Runtime Stage ---------
FROM eclipse-temurin:21-jdk-alpine

# 런타임 작업 디렉토리
WORKDIR /app

# 빌드된 jar 파일 복사
COPY --from=build /home/gradle/src/build/libs/*.jar app.jar

# 포트 설정 (Render 기본 10000~)
ENV PORT=10000
EXPOSE $PORT

# 앱 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
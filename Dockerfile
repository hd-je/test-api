# 1단계: 빌드
FROM gradle:8.10.1-jdk21 AS build
WORKDIR /home/gradle/src
COPY . .
WORKDIR /home/gradle/src/test-apis   # gradle 설정이 있는 폴더로 이동
RUN gradle clean build -x test --no-daemon

# 2단계: 실행
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /home/gradle/src/test-apis/build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]
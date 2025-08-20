# 1단계: 빌드
FROM gradle:8.10.1-jdk21 AS build
WORKDIR /home/gradle/src
COPY . .
WORKDIR /home/gradle/src/test-apis   # 👈 여기서 gradle 실행
RUN gradle build -x test --no-daemon

# 2단계: 실행
FROM azul/zulu-openjdk:21
WORKDIR /app
COPY --from=build /home/gradle/src/test-apis/build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]

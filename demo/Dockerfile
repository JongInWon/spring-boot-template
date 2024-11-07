FROM amazoncorretto:17.0.7-al2023-headless
WORKDIR /app

# 보안 설정
RUN useradd -r spring

# GitHub Actions에서 빌드된 JAR 파일 복사
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar

# 파일 권한 설정
RUN chown -R spring:spring /app

USER spring

EXPOSE 8080
ENTRYPOINT ["java"]
CMD ["-jar", "app.jar"]

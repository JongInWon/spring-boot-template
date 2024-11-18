FROM amazoncorretto:17-alpine3.18 AS extractor

WORKDIR /extract
COPY build/libs/*.jar app.jar
RUN java -Djarmode=layertools -jar app.jar extract

# Run stage
FROM amazoncorretto:17-alpine3.18
WORKDIR /app

# Alpine Linux용 유저 생성 및 권한 설정
RUN addgroup -S spring && \
   adduser -S spring -G spring && \
   mkdir /logs && \
   chown -R spring:spring /app /logs

# 계층별 복사 및 권한 설정
COPY --from=extractor /extract/dependencies/ ./
COPY --from=extractor /extract/spring-boot-loader/ ./
COPY --from=extractor /extract/snapshot-dependencies/ ./
COPY --from=extractor /extract/application/ ./
RUN chown -R spring:spring /app

USER spring

EXPOSE 8080
ENTRYPOINT ["java"]
CMD ["org.springframework.boot.loader.JarLauncher", \
    "-XX:+UseContainerSupport", \
    "-XX:MaxRAMPercentage=75.0", \
    "-Djava.security.egd=file:/dev/./urandom"]

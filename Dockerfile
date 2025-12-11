# 1) Stage: build with Maven
FROM maven:3.8.8-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
# Копируем исходники
COPY src ./src
# Собираем jar
RUN mvn -q -DskipTests package


# 2) Stage: минимальный runtime
FROM eclipse-temurin:17-jre
WORKDIR /app
# Копируем собранный jar из предыдущего stage
COPY --from=build /app/target/java-docker-demo-1.0.0.jar /app/app.jar


# Пробрасываем порт
EXPOSE 8080



# Команда запуска
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
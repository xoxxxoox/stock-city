# FROM alpine:latest

# RUN apk --no-cache add openjdk17 gradle
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Copy Gradle Wrapper
COPY gradlew ./
COPY gradlew.bat ./
COPY gradle /app/gradle

# Copy project files
COPY build.gradle settings.gradle /app/
COPY gradle /app/gradle
COPY src /app/src

# Grant execute permission to Gradle Wrapper
RUN chmod +x ./gradlew

# Resolve dependencies and build the application using Gradle Wrapper
RUN ./gradlew build --no-daemon

# Run the application
CMD ["./gradlew", "bootRun"]



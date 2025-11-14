# Production Docker image for MYCE backend
FROM eclipse-temurin:21-jdk

# Set working directory
WORKDIR /app

# Copy application files
COPY build/libs/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Set environment variable for production profile
ENV PROFILE=product

# Run Spring Boot application directly with timezone
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
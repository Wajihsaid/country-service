# Use a valid JDK 21 base image
FROM eclipse-temurin:21-jdk

# Create a writable temp directory
VOLUME /tmp

# Copy your jar file
COPY target/*.jar app.jar

# Run the app
ENTRYPOINT ["java", "-jar", "/app.jar"]

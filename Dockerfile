# Step 1: Build the application using Maven
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Run the application using OpenJDK
FROM openjdk:17-slim
WORKDIR /app

# Copy the WAR file and the webapp-runner jar from the build stage
# Note: pom.xml names the WAR 'EmployeeManagement.war'
COPY --from=build /app/target/EmployeeManagement.war app.war
COPY --from=build /app/target/dependency/webapp-runner.jar webapp-runner.jar

# Render uses the PORT environment variable
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "webapp-runner.jar", "--port", "8080", "app.war"]

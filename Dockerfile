# Use Maven image to build the application
FROM maven:3.8.3-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy the project files to the container's working directory
COPY . .

# Build the Maven project (clean and package with prod profile, skipping tests)
RUN mvn clean package -Pprod -DskipTests

# Use OpenJDK 17 image for the runtime environment
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the Maven build stage to the runtime image
COPY --from=build /app/target/DogsManagementSystem-0.0.1-SNAPSHOT.jar DogsManagementSystem.jar

# Specify the command to run the application
CMD ["java", "-jar", "DogsManagementSystem.jar"]

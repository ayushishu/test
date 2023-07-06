FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    git

# Add OpenJDK 17
RUN apt-get install openjdk-17-jdk openjdk-17-jre -y

# Download and install Maven 3.8
RUN wget -q https://downloads.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz && \
    tar -xf apache-maven-3.8.8-bin.tar.gz -C /opt && \
    rm apache-maven-3.8.8-bin.tar.gz 

# Set environment variables
ENV MAVEN_HOME=/opt/apache-maven-3.8.8
ENV PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH

# Verify installations
RUN java -version && \
    javac -version && \
    mvn -v

# Add Maven settings.xml file
RUN mkdir -p /root/.m2 \
    && wget -q -O /tmp/settings.xml https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml \
    && mv /tmp/settings.xml /root/.m2/settings.xml


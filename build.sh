#!/bin/bash
apt update
apt install default-jdk -y
apt install maven -y
git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /opt
mvn package -f /opt/
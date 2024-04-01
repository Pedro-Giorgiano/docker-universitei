#!/bin/bash

# Define o caminho para o Java
JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

# Adiciona o caminho para o Java ao PATH
export PATH="$JAVA_HOME/bin:$PATH"

# Define o caminho para o Flutter
FLUTTER_HOME="/$HOME/docker-universitei/sdk_universitei_host/flutter"

# Adiciona o caminho para o Flutter ao PATH
export PATH="/$FLUTTER_HOME/bin:$PATH"

# Define o caminho para o Android Studio
ANDROID_HOME="/$HOME/docker-universitei/sdk_universitei_host/android-studio"

# Adiciona o caminho para o Android Studio ao PATH
export PATH="/$ANDROID_HOME/bin:$PATH"

# Define o caminho para o Android SDK
ANDROID_SDK_PATH="/$HOME/docker-universitei/sdk_universitei_host/Android/sdk/platform-tools"

# Adiciona o caminho para o Android SDK ao PATH
export PATH="/$ANDROID_SDK_PATH:$PATH"

# Exibe uma mensagem de confirmação
echo "Caminhos configurados no PATH com sucesso!"

FROM ubuntu:20.04

RUN dpkg --add-architecture i386
# Atualiza e instala as dependências
RUN apt-get update -y && \
    apt-get install -y \
    nano \
    bash \
    file \
    curl \
    git \
    wget \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    lib32z1 \
    libbz2-1.0:i386

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y \
    openjdk-8-jdk-headless

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# Cria um diretório para montar no host
RUN mkdir /sdk_first_setup

# Baixa o Flutter SDK
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.5-stable.tar.xz -P /sdk_first_setup

# Extrai o Flutter SDK
RUN tar xf /sdk_first_setup/flutter_linux_3.19.5-stable.tar.xz -C /sdk_first_setup/ \ 
    && rm /sdk_first_setup/flutter_linux_3.19.5-stable.tar.xz

# Define a variável de ambiente FLUTTER_HOME
ENV FLUTTER_HOME=/sdk_first_setup/flutter

# Adiciona o Flutter ao PATH
ENV PATH="$FLUTTER_HOME/bin:$PATH"

# Baixa o Android Studio
RUN wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.2.1.24/android-studio-2023.2.1.24-linux.tar.gz -P /sdk_first_setup \
    && tar -xf /sdk_first_setup/android-studio-2023.2.1.24-linux.tar.gz -C /sdk_first_setup/ \
    && rm /sdk_first_setup/android-studio-2023.2.1.24-linux.tar.gz

# Define a variável de ambiente ANDROID_HOME
ENV ANDROID_HOME=/sdk_first_setup/android-studio

# Adiciona o Android Studio ao PATH
ENV PATH="$ANDROID_HOME/bin:$PATH"

# Define o diretório de trabalho padrão
WORKDIR /root

# Inicializa os arquivos de configuração do Android Studio
RUN mkdir -p ~/.config/Google/AndroidStudio2023.2

# Cria um arquivo idea.properties para definir o local dos diretórios de configuração e sistema
RUN echo "idea.system.path=/root/.config/Google/AndroidStudio2023.2" >> ~/.config/Google/AndroidStudio2023.2/idea.properties && \
    echo "idea.config.path=/root/.config/Google/AndroidStudio2023.2" >> ~/.config/Google/AndroidStudio2023.2/idea.properties

# Set up Android SDK 
RUN mkdir -p /sdk_first_setup/Android/sdk \
    && mkdir -p /sdk_first_setup/.android \
    && touch /sdk_first_setup/.android/repositories.cfg \
    && wget -O /sdk_first_setup/sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip /sdk_first_setup/sdk-tools.zip -d /sdk_first_setup/Android/sdk \
    && rm /sdk_first_setup/sdk-tools.zip \
    && yes | /sdk_first_setup/Android/sdk/tools/bin/sdkmanager --licenses \
    && /sdk_first_setup/Android/sdk/tools/bin/sdkmanager "build-tools;29.0.2" "platform-tools" "platforms;android-29" "sources;android-29"

# Coloca o Android SDK
ENV PATH="$PATH:/sdk_first_setup/Android/sdk/platform-tools"

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install Node.js 18.x using nvm
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get update -y

RUN apt-get install -y nodejs

# Verifica se a versão correta do Node.js foi instalada
RUN node -v
RUN npm -v



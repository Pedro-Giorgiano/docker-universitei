# Universitei development setup

## Install WSL (Windows only)
- You need any unix OS to run docker

```powershell
    wsl install -d Ubuntu-20.04
```


## Install docker
- Inside your wsl or bash do the following steps
    - Before you can install Docker Engine, you need to uninstall any conflicting packages.
    ```bash
        for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
    ```
    - Install docker using apt repo
        ```Bash
            # Add Docker's official GPG key:
            sudo apt-get update
            sudo apt-get install ca-certificates curl
            sudo install -m 0755 -d /etc/apt/keyrings
            sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
            sudo chmod a+r /etc/apt/keyrings/docker.asc

            # Add the repository to Apt sources:
            echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt-get update
        ```
    - Install the docker packages
        ```bash
            sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        ```
    - Verify that the Docker Engine installation is successful by running the hello-world image.
        ```bash
            sudo docker run hello-world
        ```
    - Now do the following to avoid writing sudo in all docker commands
        ```bash
            sudo groupadd docker

            sudo usermod -aG docker $USER

            newgrp docker
        ```

## Set-up your docker image

- First you must clone this project
    - Preferably clone the repo inside /home

        ```bash
            git clone https://github.com/Pedro-Giorgiano/docker-universitei.git
        ```
    - Now its time to build our image. Inside our clonned dir do:
        - You must run or build only once

        ```bash
            docker build -t Universitei .
        ```
    - Lets run our container

        ```bash
            docker run -it -v $HOME/docker-universitei/sdk_universitei_host:/SDK_universitei front-universitei bash
        ```
    - We can define an alias so we don't need to run this command every time
        ```bash
            alias container-universitei='docker run -it -v $HOME/docker-universitei/sdk_universitei_host:/SDK_universitei front-universitei bash'
        ```
        - Now just type ```container-univesitei``` at the shell
    - 
    - In our container we are using bindMount
        - OH but what is it, BIG PEDRAO
        - Basically it maintains the state of our container, everything we do inside the container will have a host (our PC). The opposite is also valid
    - In our container it works as follows
        - Container -> SDK_universitei
        - PC -> sdk_universitei_host
- Now we need to move our entire SDK to the bindMount folder
- Inside our container do the following
    - List all directories
    ```bash
    ls 
    ```
    - If you do an ```ls``` and no directory appears, first run ```cd ..``` and test again

- If you can see all directories, just move the content

```bash
    mv /sdk_first_setup/* /SDK_universitei
```
- Inside our SDK_universitei folder we are expecting something like:
```bash
    Android  android-studio  flutter
```

# Running android studio

- Outside of our container go to:
```bash
     cd docker-universitei/sdk_universitei_host/android-studio/bin
```
- And than
```bash
 ./studio.sh
```

# Setup all SDKs on android studio
- Create a new flutter project and put the path of Flutter SDK

```bash
    /$HOME/docker-universitei/sdk_universitei_host/flutter
```
- Just proceed with project creation and then, go to settings and SDK Manager
    - Go to Languages & Frameworks -> Android SDK
    - Put our path
    ```bash
    /$HOME/docker-universitei/sdk_universitei_host/Android/sdk
    ```


# ALL DONE MY FRIENDS







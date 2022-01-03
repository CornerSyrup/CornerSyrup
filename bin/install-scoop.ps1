Set-ExecutionPolicy RemoteSigned -scope CurrentUser

Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

scoop install git -g

scoop install 7zip
scoop install 7zip -g

scoop install cmder-full -g
scoop install dotnet-sdk -g
scoop install draw.io -g
scoop install go -g
scoop install make -g
scoop install mingw-winlibs -g # Haskell need its gcc
scoop install nodejs-lts -g
scoop install python -g
scoop install sudo -g
scoop install vim -g

scoop bucket add extras
scoop install github -g
scoop install libreoffice-stable -g
scoop install notion -g
scoop install obs-studio -g
scoop install postman -g
scoop install signal -g
scoop install vcredist2019 -g
scoop install vscode -g

# Haskell
scoop install haskell@8.10.7 -g
scoop install haskell-cabal -g
scoop install stack -g


# Java
scoop bucket add java
scoop install kotlin -g
scoop install maven -g
scoop install openjdk8-redhat -g
scoop install openjdk11 -g

# Adnroid
scoop install android-sdk -g
scoop install adb -g

# JetBrain
scoop bucket add jetbrains
scoop install IntelliJ-IDEA -g
scoop install DotPeek -g
scoop install YouTrack -g

# PHP
scoop bucket add php
scoop install php -g
scoop install php-xdebug -g
scoop install composer -g

# Fonts
scoop bucket add nerd-fonts
scoop install FiraCode-NF -g

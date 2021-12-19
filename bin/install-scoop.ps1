Set-ExecutionPolicy RemoteSigned -scope CurrentUser

Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

scoop install git -g

scoop install 7zip
scoop install 7zip -g

scoop install adb -g
scoop install arduino -g
scoop install cmder-full -g
scoop install dart -g
scoop install dotnet-sdk -g
scoop install draw.ioo -g
scoop install flutter -g
scoop install go -g
scoop install make -g
scoop install maven -g
scoop install notionjs-lts -g
scoop install sudo -g
scoop install vim -g

scoop bucket add extras
scoop install android-sdk -g
scoop install github -g
scoop install libreoffice-stable -g
scoop install notion -g
scoop install obs-studio -g
scoop install postman -g
scoop install signal -g
scoop install vcredist2019 -g
scoop install vscode -g

scoop bucket add nerd-fonts
scoop install FiraCode-NF

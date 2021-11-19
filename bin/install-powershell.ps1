Install-Module oh-my-posh -Scope CurrentUser
Install-Module posh-git -Scope CurrentUser
New-Item -ItemType SymbolicLink -Path $profile -Target (Join-Path -Path $PSScriptRoot -ChildPath '../config/user_profile.ps1')
Copy-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath '../config/klein.omp.json') -Destination (Join-Path -Path $profile -ChildPath '../Modules/oh-my-posh/6.7.0/themes/klein.omp.json')

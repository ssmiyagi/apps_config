function wsl_open_vscode(){
  wsl code .
}
function wsl_debian(){
  wsl -d Debian
}
Set-Alias wsld wsl_debian
Set-Alias wv wsl_open_vscode
Set-Alias w wsl

function dci([string] $target){
  if([String]::IsNullOrEmpty($target)){
    echo 'pls sumthing string arg'
    return
  }
   docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" $target
}
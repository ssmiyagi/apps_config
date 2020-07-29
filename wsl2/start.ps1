if([string]::IsNullorEmpty($Args[0])){
 Write-Host "wslのディストリビューションを指定してください。" 
 wsl -l
 return
}

$distr=$Args[0]
$wsl_distr= wsl -d $distr echo aiueo

if(!$wsl_distr.Contains("aiueo")){
Write-Host "ディストリビューションが存在しません。" 
 wsl -l
 return
}


#if([string]::IsNullorEmpty($Args[1])){
#   $message="${distr}のuserを指定してください。" 
#   Write-Host $message
#   $users= wsl -d $distr ./user_list.sh
#   Write-Host --users--
#   Write-Host $users
#   return
#}
#$wsl_user=$Args[1]
#
#$wsl_distr= wsl -u $wsl_user -d $distr echo aiueo
#
#if(!$wsl_distr.Contains("aiueo")){
#  Write-Host "ユーザーが存在しません。" 
#   $users= wsl -d $distr ./user_list.sh
#   Write-Host --users--
#   Write-Host $users
#   return
#}
#wsl -u $wsl_user -d $distr ./init_wsl.sh
#wsl --shutdown
#wsl -u $wsl_user -d $distr ./init_lang.sh
#wsl --shutdown
#wsl -u $wsl_user -d $distr ./init_package.sh
#wsl -u $wsl_user -d $distr ./init_config.sh

wsl -u root -d $distr ./init_wsl.sh
wsl --shutdown
wsl -u root -d $distr ./init_lang.sh
wsl --shutdown
wsl -u root -d $distr ./init_package.sh
wsl -d $distr ./init_config.sh

$welcome = "welcome ${distr}"
 Write-Host "everthing done!!"
Write-Host $welcome

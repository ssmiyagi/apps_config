function cddesktop
{
    Set-Location ([Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory))
}
function rmrf([string]$file_path){
  rm -Recurse -Force $file_path
  return
}
function remake([string]$file_path){
  rmrf $file_path
  mkdir $file_path
  return
}
function remake([string]$file_path){
  rmrf $file_path
  mkdir $file_path
  return
}
function remakein([string]$file_path,[string]$item_path){
  remake $file_path
  copy $item_path $file_path
  return
}
function dh() {
  [Console]::SetCursorPosition(0, 0)
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8
  $reverse_dir_history = reverse_txt $peco_dir_history
  $reverse_dir_history | peco | %{cd $_}
  dl
  peco_finalize
}

function fh() {
  [Console]::SetCursorPosition(0, 0)
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8
  $reverse_dir_history = reverse_txt $peco_file_history
  $reverse_dir_history| peco | %{ii $_}
  peco_finalize
}

function reverse_txt([string] $file_path){
  [String[]]$Text = Get-Content $file_path
  [String[]]$RText 
    for ($I=$Text.Count-1; $I -ge 0; $I--){
        $RText += $Text[$I]
        $RText += "`n"
    }
  return $RText
}
function _peco(){
  [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,
                   ValueFromPipeline=$True)]
        [string[]]$texts
    )

    
    begin {
       $OutputEncoding = [System.Text.Encoding]::UTF8
       peco_init
    }

    process {
        #echo "nameproces called."
        #peco $texts
    }

    end {
        #peco $texts
        peco $texts
        echo "end called."
    }
}

function pecoadInit(){
  if(Test-Path $peco_folder){
  }else{
    New-Item $peco_folder -ItemType Directory 
  }
}

function adb(){
  pecoadInit
  $add_dir =  (pwd).path
  if(Test-Path $peco_bookmark){
  }else{
    New-Item $peco_bookmark
  }
  Add-Content $peco_bookmark  $add_dir
}
function ada(){
  pecoadInit
  $add_dir =  (pwd).path
k  Set-Content $peco_active_dir  $add_dir
}
function addh([string] $dir){
  pecoadInit
  $add_dir
  if([String]::IsNullOrEmpty($dir)){
    $add_dir =  (pwd).path
  }else{
    $add_dir = $dir
  }
  Add-Content $peco_dir_history  $add_dir
}
function adfh([string] $add_dir){
  pecoadInit
  Add-Content $peco_file_history  $add_dir
}

function dl(){
  Param([int] $depth,[switch] $recurse,[string] $exclude)
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8
  $isWork = _dl $depth $recurse $exclude
  #$isWork = _dl 
  while(1){

    if($isWork -eq $True){
      addh
      $isWork = _dl
    }elseif($isWork -eq $False){
      addh
      $OutputEncoding =[Text.Encoding]::Default
      peco_finalize
      break;
    }else{
      break;
    }
  }
}

function _dl([int] $depth,[bool] $recurse,[string] $exclude){
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8

  $selected
  if(($recurse -eq $true) -And (-not [string]::IsNullOrEmpty($exclude))){
    #$selected = dir -Exclude "*node_modules*" | dir  -Recurse -name | peco
    #$selected = dir -Exclude $exclude | dir  -Recurse | peco
    $dir_list  = dir -Exclude $exclude | dir  -Recurse 
    #$dir_list | % {Resolve-Path -relative $_.fullname } | peco
    $selected = $dir_list | % {Resolve-Path -relative $_.fullname } | peco 
    #$dir_list | peco
    #peco $dir_list 
  }elseif($recurse -eq $true){
    $selected = dir -name -recurse | peco
  }elseif($depth -ne 0){
    $selected = dir -name -depth $depth | peco
  }else {
    $selected = dir -name | peco
  }
  if([string]::IsNullOrEmpty($selected)){
    peco_finalize
    $OutputEncoding =[Text.Encoding]::Default
    return $False
  }
  $isDir = (Get-Item $selected) -is [System.IO.DirectoryInfo] 
  if($isDir){
    cd $selected
  }else{
    $application =userInputforOpenApp
    $result = $selected| %{echo ($application + " " +"./" + $_)}  
    $selected
    $sel_ex = (Get-Item $selected).Extension
    if($sel_ex -eq ".exe"){
      $excutesion_path = './' + $selected
      Start-Process $excutesion_path -Wait -NoNewWindow
    }else{
      if($application -eq 'ii'){
        ii $selected
      }else{
      Start-Process $application $selected -Wait -NoNewWindow
      }
    }
    $OutputEncoding =[Text.Encoding]::Default
    peco_finalize

    return $False
  }
  peco_finalize
  $OutputEncoding =[Text.Encoding]::Default
  return $True
}

function cdb([int] $backCount){
  if($backCount -eq 0){
  cd ../
  }else{
    while($backCount -ne 0){
      cd ../
      $backCount--
      if($backCount -le 0){
        return
      }
    }
  }
}

function cdmyrepo(){
  cd $my_repo
}
function cdl(){
  #clear
  [Console]::SetCursorPosition(0, 0)
  $OutputEncoding = [System.Text.Encoding]::UTF8
  peco_init
  $res = dir -dir -name |peco | %{cd $_}
  peco_finalize
}
Set-Alias cl cdl

function cdlr(){
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8
  while(1){
    $before = (pwd).path
    cdl
    $after = (pwd).path

    if($before -eq $after){
      addh
      peco_finalize
      $OutputEncoding =[Text.Encoding]::Default
      break;
    }
  }
}
Set-Alias clr cdlr


function copyNas([string]$target_file){
  $date = getDate
  $fileName = $target_file.Replace('.\','')
  echo $fileName
  $unique_name = $my_nas_dir_tmp +"\\" + $date + $fileName
  echo $unique_name
  copy $target_file $unique_name
}
function ol(){
  Param([string] $app,[string] $m)
  $application = $app
  $mode = $m
  #clear
  [Console]::SetCursorPosition(0, 0)
  $OutputEncoding = [System.Text.Encoding]::UTF8
  peco_init
  $file_list = dir -file -name
  $selected
  if([string]::IsNullOrEmpty($mode)){
    $selected = $file_list|peco
  }else{
    $selected = $file_list|peco  --initial-filter=Migemo
  }
  if([string]::IsNullOrEmpty($selected)){
    return
    }
  if([string]::IsNullOrEmpty($application)){
    ii $selected
  }else{
   $result = $selected| %{echo ($application + " " +"./" + $_)}  
   $OutputEncoding =[Text.Encoding]::Default
    Invoke-Expression $result
  }
  $OutputEncoding =[Text.Encoding]::Default
  $fullpath = (pwd).path + "/" + $selected
  adfh $fullpath
  peco_finalize
}
function olj(){
 ol -m "j"
}
function orl(){
  Param([string] $app,[string] $m)
  $application = $app
  $mode = $m
  clear
  [Console]::SetCursorPosition(0, 0)
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8
  $dir_list = dir -file -name -recurse -depth 3 
  $selected
  if([string]::IsNullOrEmpty($mode)){
    $selected = $dir_list|peco
  }else{
    $selected = $dir_list|peco  --initial-filter=Migemo
  }
  if([string]::IsNullOrEmpty($selected)){
    return
    }

  $fullpath = (pwd).path + "/" + $selected
  $targetDir = [System.IO.Path]::GetDirectoryName($fullpath)
  adfh $fullpath
  addh $targetDir
  if([string]::IsNullOrEmpty($application)){
    ii $selected
  }else{
   $result = $selected| %{echo ($application + " " +"./" + $_)}  
   $OutputEncoding =[Text.Encoding]::Default
    peco_finalize
    Invoke-Expression $result
  }
  peco_finalize
  clear
}
function orlj(){
  Param([string] $app)
  orl -app $app -m j 
}

function cdpb(){
  Param([string]$cmdString,[switch] $r)
  [Console]::SetCursorPosition(0, 0)
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8
  $selected = Get-Content $peco_bookmark | peco 
  if([string]::IsNullOrEmpty($selected)){
    return
  }
  cd $selected
  dl
  if($r -eq $True){
    cdlr
  }
  if(![string]::IsNullOrEmpty($cmdString)){
    Invoke-Expression $cmdString
  }
  peco_finalize
}
Set-Alias cb cdpb

function cdpbl(){
  cdpb -r
}
function cdrl(){
  Param([string] $m)
  $mode = $m
  clear
  [Console]::SetCursorPosition(0, 0)
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8
  $dir_list =dir -dir -name -Depth 3
   $selected
  if([string]::IsNullOrEmpty($mode)){
    $selected = $dir_list|peco
  }else{
    $selected = $dir_list|peco  --initial-filter=Migemo
  }
  cd $selected 
  addh
  peco_finalize
  clear
}
Set-Alias crl cdrl

function cdrlj(){
 cdrl -m j
}
Set-Alias crlj cdrlj

function userInputforOpenApp(){
  pecoadInit
  if(Test-Path $peco_command_list){
  }else{
    New-Item $peco_command_list
    Add-Content $peco_command_list  "vim"
    Add-Content $peco_command_list  "code"
  }
  #$useCommand = cat $peco_command_list
  #$command_selected = $useCommand | peco
  $command_selected = cat $peco_command_list  | peco
  #$command_selected = cat $peco_command_list  | fzf
  if($command_selected -eq 'defalut'){
    return "ii"
  }
  $input 

  if([string]::IsNullOrEmpty($command_selected)){
    $input = Read-Host "what open app(enter is defalut)"
  }else{
    return $command_selected
  }

  if([string]::IsNullOrEmpty($input)){
    return "ii"
  }else{
    return $input
  }
}
function select_peco([array]$selection_list){
  $OutputEncoding = [System.Text.Encoding]::UTF8
  $selected
  if($null -eq $selection_list){
    peco_finalize
    $OutputEncoding =[Text.Encoding]::Default
    return ""
  }
  $selected = $selection_list | peco
  peco_finalize
  $OutputEncoding =[Text.Encoding]::Default
  if([string]::IsNullOrEmpty($selected)){
    return
  }
  return $selected
}
function cdbl(){
  $bk_list = @()
  $current_dir = pwd
  $bk_list += Split-Path $current_dir
  for($counter = 0; $counter -lt 3; $counter++){
    $parent_dir = Split-Path $bk_list[$counter]
    $bk_list += $parent_dir
  }
  $selected = select_peco $bk_list
  if([string]::IsNullOrEmpty($selected)){
    return
  }
  $selected = Out-String -InputObject $selected
  $selected = $selected -replace "`r",""
  $selected = $selected -split "`n"
  if([string]::IsNullOrEmpty($selected)){
    return
  }
  cd $selected[1]
  dl
}

function dlr(){
  #dl -recurse
  dl -exclude node_modules -recurse
}

function dlf([bool] $preview){
  $selected
  if([string]::IsNullOrEmpty($preview)){
    $selected = fzf  --reverse
  }else{
    $selected = fzf  --reverse --preview 'type {}'
  }
  if([string]::IsNullOrEmpty($selected)){
    return $False
  }
  $application = userInputforOpenApp
  $result = $selected| %{echo ($application + " " +"./" + $_)}  
  $selected
  $sel_ex = (Get-Item $selected).Extension
  if($sel_ex -eq ".exe"){
    $excutesion_path = './' + $selected
    Start-Process $excutesion_path -Wait -NoNewWindow
  }else{
    if($application -eq 'ii'){
      ii $selected
    }else{
    Start-Process $application $selected -Wait -NoNewWindow
    }
  }
}

function dlfp(){
  dlf -true
}
function dlrn(){
  dl -recurse -exclude "*node_modules*"
}

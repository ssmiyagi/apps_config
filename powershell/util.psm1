function photometa([string]$file_path_s){
  $currentDir = Convert-Path .
  $target_file_path = $currentDir  + $file_path_s
  echo $target_file_path
  & $photometa $target_file_path
}
function sudo{
  $currentDir = Convert-Path .
  # echo $currentDir
  # Start-Process powershell.exe  -WorkingDirectory $currentDir
  Start-Process powershell.exe  -WorkingDirectory $currentDir -Verb runas
  # Start-Process powershell.exe -Verb runas -WorkingDirectory $currentDir
}
function makeDummyFile([string]$file_name,[int64]$file_byte_size){
  fsutil file createnew $file_name $file_byte_size
}
function numToGigaByte([int] $use_input){
  return [math]::round($use_input *1Gb, 3);
}
function numToMegaaByte([int] $use_input){
  return [math]::round($use_input *1Mb, 3);
}
function byteToMegaByte([int64] $use_input){
  return [math]::round($use_input /1Mb, 3);
}
function pwdc(){
  Convert-Path . | Set-Clipboard
}
[void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") 
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
function saveScreenCapture([String]$outputPath)
{
  $rect = [System.windows.forms.Screen]::PrimaryScreen.Bounds
  $bitmap = new-object System.Drawing.Bitmap( `
  $rect.Width, `
  $rect.Height, `
  [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.CopyFromScreen( `
  $rect.X, `
  $rect.Y, `
  0, `
  0, `
  $rect.Size, `
  [System.Drawing.CopyPixelOperation]::SourceCopy)
  $bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
}

function getDate(){
  $result = Get-Date -Format "yyyy_MM_dd_HHmm";
  return $result
  }
function mp4ToGif([string]$mp_file_name,[string]$output_name){
  ffmpeg.exe -i $mp_file_name -vf scale=1000:-1 -r 10  -f gif $output_name
}
function pngToIco([string]$target_file,[string]$dest_file){
  magick $target_file -define icon:auto-resize $dest_file
}

function makeIndex(){
  ctags -R --exclude=.git --exclude=node_modules --exclude=test
}


function getFullPermmision($folder_path){
  $fc_user_name = 'miyag'
  $acl = Get-Acl $folder_path
  $permission = ($fc_user_name,"FullControl","ContainerInherit, ObjectInherit", "None","Allow")
# 引数：ユーザー名,アクセス権,下位フォルダへ継承,下位オブジェクトへ継承,継承の制限,アクセス許可
  $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
  $acl.SetAccessRule($accessRule)
  $acl | Set-Acl $folder_path
}

function touch([string] $filename){
  Out-File -encoding Default $filename
}


function nrun(){
  npm run | fzf | %{$_.trim()}|%{npm run $_}
}

function grepr([string] $grep_target,[string] $excludeTarget){
  $dir_list
  if([String]::IsNullOrEmpty($excludeTarget)){
    $dir_list = dir -Exclude "*node_modules*" | dir  -Recurse 
  }else{
    $dir_list = dir -Exclude $excludeTarget | dir  -Recurse 
  }
  $dir_list | grep $grep_target
  #echo $dir_list
}

function fzc(){
  fzf --reverse | scb
}

function list ([string]$param){
  if([String]::IsNullOrEmpty($param)){
    $Input = Read-Host "[f] func [v] var"
      echo ''
    if($Input -eq "f"){
      list_func
    }elseif($Input -eq "v"){
      list_var
    }else{
      list_func
      echo ''
      list_var
    }
  }else{
    if($param -eq "f"){
      list_func
    }elseif($param -eq "v"){
      list_var
    }else{
      echo "f or v"
    }
  }
}
function getClipboardHashCode(){
  $clipboardImage = [Windows.Forms.Clipboard]::GetImage()
  Add-Type -AssemblyName System.Windows.Forms, System.Drawing
  $sha1 = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
  $stream = New-Object -TypeName System.IO.MemoryStream
  $clipboardImage.Save($stream, [System.Drawing.Imaging.ImageFormat]::Png)
  [void]$stream.Seek(0,'Begin')
  $hashString = ($sha1.ComputeHash($stream.ToArray()) | %{ "{0:x2}" -f $_ }) -Join
  $stream.Dispose()
  return $hashString
}
function desktopPasteClipboard([string] $count){
  Add-Type -AssemblyName System.Windows.Forms
  $clipboardImage = [Windows.Forms.Clipboard]::GetImage()
  if ($clipboardImage -ne $null)
  {
    $dateString = Get-Date -Format yyyy_MMdd_hhmm_ss
    $fileName = "clip" + $count + "_" + $dateString + ".png"
    $outputFilePath = Join-Path (Join-Path $Env:UserProfile "Desktop") $fileName
    $clipboardImage.Save($outputFilePath)
  }
}
function hasImage(){
  Add-Type -AssemblyName System.Windows.Forms
  $clipboardImage = [Windows.Forms.Clipboard]::GetImage()
  if ($clipboardImage -ne $null)
  {
    return $true
  }else{
    return $false
  }
}
function watchClipboardImage(){
  $beforeImageHash = 0;
  $copyCounter=1;
  if(hasImage -eq $true){
      $beforeImageHash = getClipboardHashCode
  }
  while ($true -eq $true) { 
    if(hasImage -eq $true){
      $nowHash = getClipboardHashCode
      if($beforeImageHash -ne $nowHash){
        $status = "copy"+$copyCounter
        echo $status
        desktopPasteClipboard $copyCounter
        $beforeImageHash = $nowHash
        $copyCounter++
      }
    }
    sleep 1  
    }
}


function lf(){
 dir -file
}

Set-Alias -Name lsf lf
function ld(){
 dir -dir
}
Set-Alias -Name lsd ld
function ls(){
 dir
}

function rgp([string]$target){
  $selected = rg $target ---line-number | peco 
  if([String]::IsNullOrEmpty($selected)){
    return
  }else{
   $splitString = $selected.split(":")
   vim -c $splitString[1]  $splitString[0]
  }

}

function grepp([string] $target_string){

  $ex="node_modules"
  $exextension="*.db","*.png","*.gyp","*.css","*.jpg","*.svg","*.rtf", "*deliverable_data_output_window*","*deliverable_data_input_window*","*test\contents*","*test\lib*"
  $target_match=$target_string
  echo $target_match
  $output_file_name="grep_" + $target_match + ".txt"
  #$inc="*.js"
  #$inc="*.html"
  $outputResult=""
  #$grepResults = dir -Exclude $ex -dir|dir -file -Recurse |sls "facilityNames" -Include $inc -Exclude $exextension
  #$grepResults = dir -Exclude $ex -dir|dir -file -Recurse |sls "knack" -Include $inc -Exclude $exextension | %{$_.ToString()} > grep_test.txt
  #$grepResults = dir -Exclude $ex -dir|dir -file -Recurse |sls "knack" -Exclude $exextension | %{$_.ToString()} > grep_test.txt
  $grepResults = dir -Exclude $ex -dir|dir -file -Recurse |sls $target_match -Exclude $exextension 

  $beforeFilePath = ""
  foreach($result in $grepResults){
    if($beforeFilePath -ne $result.Path){
      #ファイルごとで改行する場合はコメントを外す
      #$outputResult+="`n"
      
      $outputResult+="`n"
      $outputResult+= $result.Path
      $beforeFilePath=$result.Path
    }
    $outputResult+="`n"
    $content = ($result.LineNumber).ToString()+":" + ($result.Line).ToString() 
    $outputResult+= $content
  }
  Out-file -filepath $output_file_name -InputObject $outputResult
  moved $output_file_name
}

function renameAuto([string] $targetFile){
  $nowDate = Get-Date -Format "yyyy_MM_dd_HHmm"
  $rename = $targetFile + "_" + $nowDate
  echo $rename
  if(Test-Path $rename){
    echo exsits
  } else {
    ren $targetFile $rename
  }
}
Set-Alias ra renameAuto

function memo(){
  #echo $quickely_memo
  vim $quickely_memo
}
function imemo(){
  vim $quickely_memo_iiot
}

function serachIp([string] $base,[int] $to, [int] $from ){
  1..254 | ForEach-Object {echo $_;Test-Connection -ComputerName "192.168.53.$_" -Count 1 -ErrorAction SilentlyContinue }
}

function moved([string] $target_file){
  $userDesktop =  ([Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory))
  move $target_file $userDesktop
}

function copyVscodeSettingFiles(){
 copy $vscode_settingfile_template -Recurse
}

function copydir([string] $target_file,[string] $dest_dir){
  copy $target_file $dest_file -Recurse
}
function slpr(){
  [Console]::SetCursorPosition(0, 0)
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8
  $selected = dir -name -recurse | peco
  peco_finalize
  return $selected
}
function slp_copy_path(){
  Param([string] $m,[switch] $name)
  $mode = $m
  $selected
  if([string]::IsNullOrEmpty($mode)){
    $selected = slp 
  }else{
    $selected = slpr 
  }
  if([string]::IsNullOrEmpty($selected)){
    return
  }
  if($name -eq $True){
    echo $selected
    $selected | %{scb $_}
  }else{
    $fullpath = Join-Path (pwd).path $selected 
    $fullpath | %{scb $_}
  }
}

function slp(){
  [Console]::SetCursorPosition(0, 0)
  peco_init
  $OutputEncoding = [System.Text.Encoding]::UTF8
  $selected = dir -name | peco
  peco_finalize
  return $selected
}

function copyd(){
  [CmdletBinding()]
    param(
      [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
      [string]$target_file
    )

    
    begin {
    }

    process {
      $userDesktop =  ([Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory))
      copy $target_file $userDesktop
    }
    end {
    }
}
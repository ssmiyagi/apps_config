function gba(){
  git branch -a
}

function gb(){
  git branch
}

function selectedBrach(){
  $selected_braches = gba |peco
  if([String]::IsNullOrEmpty($selected_braches)){ return }

  $selected_braches = $selected_braches.trim() 
  return $selected_braches
}

function gitcheckoutpeco(){
  $selected_braches = selectedBrach
  if([String]::IsNullOrEmpty($selected_braches)){ return }

  $selected_braches = $selected_braches.Replace('remotes/origin/','')
  git checkout $selected_braches

}
Set-Alias gcb gitcheckoutpeco

function gitcheckoutlocal([string] $local_branche_name){
  $selected_braches = selectedBrach
  if([String]::IsNullOrEmpty($selected_braches)){ return }


  if([String]::IsNullOrEmpty($local_branche_name)){ 
    $display_word
    echo $selected_braches
    if($selected_braches.Contains("develop")){
      $display_word = selectedBrach
      #$display_word.Replace('remotes/origin/','') | scb
    }else{
      $display_word = $selected_braches
    }

    if([String]::IsNullOrEmpty($display_word)){ return }

   $display_word = $display_word.Replace('remotes/origin/','')
    #$local_branche_name = Read-Host $display_word
    $local_branche_name = readHostInDef $display_word
  }
  git checkout -b $local_branche_name $selected_braches

}
Set-Alias gcbl gitcheckoutlocal

function gitdiffbranche(){
  $selected_brache_base = selectedBrach
  if([String]::IsNullOrEmpty($selected_brache_base)){ return }


  $selected_brache_new = selectedBrach
  if([String]::IsNullOrEmpty($selected_brache_new)){ return }

  git windiff $selected_brache_base $selected_brache_new

}

Set-Alias dib gitdiffbranche
function gic(){
  git commit .
}

function gitpull(){
  git pull
}

Set-Alias p gitpull

function git_braches_vv(){
  git branch -vv
 }

Set-Alias gbv git_braches_vv

function su(){
  svn up
}

function svnUpdateInfinity(){
  svn update --set-depth infinity
  #cd ../
}

function svnUpdateImmediatesThenUp(){
  svn update --set-depth immediates
  cd ../
}
function svnUpdateImmediates(){
  svn update --set-depth immediates
}

function svnBlame([string] $target){
  svn blame $target
}

function svnlp([int] $limit_num){
  [Console]::SetCursorPosition(0, 0)
  clear
  #peco_init
  #$OutputEncoding = [System.Text.Encoding]::UTF8
  if($limit_num -eq 0){
    $limit_num = 10
  }
  svn log -l $limit_num 
  #svn log -l $limit_num | peco
  #svn log -l $limit_num |nkf32 -S -w |echo
  #svn log -l $limit_num |iconv -f SJIS -t UTF-8 |echo
  #$result = svn log -l $limit_num |iconv -f SJIS -t UTF-8 
  #svn log -l $limit_num |nkf32 |peco
  #[Console]::OutputEncoding = [Text.Encoding]::Default
  #peco_finalize
  #clear
}

function svnurl(){
  $svn_info = svn info | sls "URL: h" | Out-String
  $_svn_info = $svn_info.split(":")
  $svn_url = $_svn_info[1] + ":" + $_svn_info[2]  
  $svn_url | %{scb $_}
  # $_svn_info[0] | %{scb $_}
  echo $svn_url
}

function svnClip(){
  svn info | sls "URL: h"|%{scb $_}
}

function readHostInDef([string] $default){
  if(($result = Read-Host "Press enter to accept default value [$default]") -eq ''){"$default"}else{$result}
}
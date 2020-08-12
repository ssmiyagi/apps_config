function vhosts(){
 vim C:\Windows\System32\drivers\etc\hosts
}

function vver
{
  vim $powershell_veriable
}

function vpecofile(){
  cd $peco_folder
  [Console]::SetCursorPosition(0, 0)
  dir -file -name |peco --select-1 | %{vim $_}
}
function vp(){
  vim $PROFILE
}
function vvs(){
 vim $vim_setting_file
}

function vvc(){
 vim $vim_command_file
}

Set-Alias nq nvim-qt.exe

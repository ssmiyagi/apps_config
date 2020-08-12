@echo off
cd /d %~dp0

REM <ここから>実行権限と引数で分岐
REM :管理者特権で実行しないとエラーになる処理
REM :上記処理がエラー（ユーザー権限）であれば一般権限で実行する処理に移動
openfiles > NUL 2>&1
if NOT %ERRORLEVEL% EQU 0 goto promotion
REM :実行権限と引数で分岐<ここまで>

REM :<ここから>管理者権限で実行させたい処理を記述

echo 管理者権限です。
echo homePath: %HOME%
set pdir=%homedrive%%homepath%\Documents\WindowsPowerShell
echo pdir: %pdir%
IF NOT EXIST "%pdir%" (
  echo No extists powershell dir
  echo making dir...
  mkdir %pdir%
) ELSE (
  echo OK
)
REM make sybolic link
mklink %pdir%\init.ps1 %~dp0init.ps1
mklink %pdir%\sys_veriable.ps1 %~dp0sys_veriable.ps1
mklink %pdir%\peco_util.psm1 %~dp0peco_util.psm1
mklink %pdir%\dir_util.psm1 %~dp0dir_util.psm1
mklink %pdir%\repo_util.psm1 %~dp0repo_util.psm1
mklink %pdir%\vm_util.psm1 %~dp0vm_util.psm1
mklink %pdir%\shrotcut.psm1 %~dp0shrotcut.psm1
mklink %pdir%\util.psm1 %~dp0util.psm1
mklink %pdir%\private.psm1 %~dp0private.psm1
mklink %pdir%\Microsoft.PowerShell_profile.ps1 %~dp0Microsoft.PowerShell_profile.ps1

pause
:管理者権限で実行させたい処理を記述<ここまで>
goto end


:promotion
echo ユーザー権限です。
REM :管理者権限で自分自身を実行（昇格処理）
powershell start-process %~nx0 -verb runas


REM :↓の記述で管理者権限のときに一般権限の処理を実行しないようにしています②
:end
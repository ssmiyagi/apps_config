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
set destDir=%homedrive%%homepath%
echo destDir: %destDir%
IF NOT EXIST "%destDir%" (
  echo No extists powershell dir
  echo making dir...
  mkdir %destDir%
) ELSE (
  echo OK
)
REM make sybolic link
mklink %destDir%\.vimrc %~dp0.vimrc
mklink %destDir%\command.vim %~dp0command.vim
goto end


:promotion
echo ユーザー権限です。
REM :管理者権限で自分自身を実行（昇格処理）
powershell start-process %~nx0 -verb runas


REM :↓の記述で管理者権限のときに一般権限の処理を実行しないようにしています②
:end

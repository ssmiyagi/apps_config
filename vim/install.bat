@echo off
cd /d %~dp0

REM <��������>���s�����ƈ����ŕ���
REM :�Ǘ��ғ����Ŏ��s���Ȃ��ƃG���[�ɂȂ鏈��
REM :��L�������G���[�i���[�U�[�����j�ł���Έ�ʌ����Ŏ��s���鏈���Ɉړ�
openfiles > NUL 2>&1
if NOT %ERRORLEVEL% EQU 0 goto promotion
REM :���s�����ƈ����ŕ���<�����܂�>

REM :<��������>�Ǘ��Ҍ����Ŏ��s���������������L�q

echo �Ǘ��Ҍ����ł��B
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
echo ���[�U�[�����ł��B
REM :�Ǘ��Ҍ����Ŏ������g�����s�i���i�����j
powershell start-process %~nx0 -verb runas


REM :���̋L�q�ŊǗ��Ҍ����̂Ƃ��Ɉ�ʌ����̏��������s���Ȃ��悤�ɂ��Ă��܂��A
:end

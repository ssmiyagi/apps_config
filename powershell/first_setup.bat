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
:�Ǘ��Ҍ����Ŏ��s���������������L�q<�����܂�>
goto end


:promotion
echo ���[�U�[�����ł��B
REM :�Ǘ��Ҍ����Ŏ������g�����s�i���i�����j
powershell start-process %~nx0 -verb runas


REM :���̋L�q�ŊǗ��Ҍ����̂Ƃ��Ɉ�ʌ����̏��������s���Ȃ��悤�ɂ��Ă��܂��A
:end
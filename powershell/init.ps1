Import-Module Get-ChildItemColor
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Import-Module -Name Terminal-Icons
Set-Alias grep Select-String
# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
#Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Helper function to change directory to my development workspace
# Change c:\ws to your usual workspace and everytime you type
# in cws from PowerShell it will take you directly there.
function cws { Set-Location c:\ws }

# Helper function to set location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

# Helper function to show Unicode character
function U
{
    param
    (
        [int] $Code
    )
 
    if ((0 -le $Code) -and ($Code -le 0xFFFF))
    {
        return [char] $Code
    }
 
    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
    {
        return [char]::ConvertFromUtf32($Code)
    }
 
    throw "Invalid character code $Code"
}

# Ensure posh-git is loaded
#Import-Module -Name posh-git
# Ensure posh-svn is loaded
#Import-Module -Name posh-svn

# Start SshAgent if not already
# Need this if you are using github as your remote git repository
#if (! (ps | ? { $_.Name -eq 'ssh-agent'})) {
#    Start-SshAgent
#}

# Ensure oh-my-posh is loaded
Import-Module -Name oh-my-posh
Set-Theme Paradox

#上/下矢印でコマンドを検索するのは本当に便利です。の
#オプション「最後に移動」は、カーソルを最後に置きたい場合に便利です
#検索なしで履歴を巡回する際の行の番号、
#そのオプションがないと、カーソルは元の位置に残ります
#矢印を使用した場合、正確なものを忘れた場合に役立ちます
#検索を開始した文字列。
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward



# overwrite gcb == get-clipboard
Set-Alias gcb gitcheckoutpeco
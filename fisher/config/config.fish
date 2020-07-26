#set -g theme_newline_cursor yes
#set -g theme_display_git_master_branch yes
#set -g theme_color_scheme dracula
#set -g theme_powerline_fonts no
#set -g theme_display_date no
#set -g theme_display_cmd_duration no

echo -n Setting abbreviations...
abbr m 'make'
abbr mi 'make;make install'
abbr mc 'make clean'
abbr mcm 'make clean;make'
abbr mcmi 'make clean;make;make install'
abbr tt 'echo abbr test is OK'
abbr cli './clisample'
abbr ii 'explorer.exe'
abbr rmrf 'rm -rf '
echo 'Done'

set -x SPD_PATH /mnt/c/dev/ss/time_series_db
set -x ASAN_OPTIONS detect_stack_use_after_return=1
#set -x LSAN_OPTIONS verbosity=1:log_threads=1

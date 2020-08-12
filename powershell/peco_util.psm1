function peco_init(){
  $OutputEncoding = [System.Text.Encoding]::UTF8
  [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
}
function peco_finalize(){
  $OutputEncoding =[Text.Encoding]::Default
  [Console]::OutputEncoding = [Text.Encoding]::Default
}
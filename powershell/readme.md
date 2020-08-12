

## powershellのUtilのインストール方法

1. powershellでinstall_powershell_module.ps1を実行してpowershellプラグインをインストールしてください
2. first_setup.batファイルの実行(管理者権限が必要です。実行するだけで昇格するので、クリックしてください)

### 依存モジュール
```
peco
fzf
```

pecoとfzfがPATHが通っている状態にしてください
choloteyを使っていれば以下のコマンドを実行するだけでいいです
```
choco install peco fzf -y
```

## powershellのデフォルト動作変更

1. tabを押すとbashのように保管が聞くようになります。
1. gitブランチの場合は今いる場所が表示されるようになります

## peco画面について
peco画面はインクリメントサーチ画面です。

その画面を抜けるにはEscを押してください

## 便利コマンド

### ディレクトリリストの取得してディレクトリであれば移動。ファイルであれば任意のファイルで開く
```
dl
```
direcotry list

### ブックマークに追加
```
adb
```
add bookmark

### ブックマークを開いてそこに移動
```
cb
```
cd bookrmarklist

### Gitブランチをチェックアウト
```
gcb
```
git checkout branche

### Gitブランチをチェックアウトして任意の名前をつける
```
gcbl
```
git checkout branche local name

### Gitブランチのリスト
```
gba
```
git brache all

### Gitのローカルブランチがどのリポートリポジトリと紐づいているか
```
gbv
```
git brache -vのコマンドの意味

## 改造用コマンド
### vimでPowershellファイルを編集する
```
vp
```

### vimで(ブックマーク、コマンド)リストを開く
```
vpecofile
```

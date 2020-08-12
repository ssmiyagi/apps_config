

## powershellのUtilのインストール方法

1. install_powershell_module.ps1をpowershellで実行してpowershellモジュールをインストールしてください
2. first_setup.batファイルの実行(管理者権限が必要です。実行するだけで昇格するので、そのままクリックしてください)

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

## 便利コマンド

### ディレクトリリストの取得
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


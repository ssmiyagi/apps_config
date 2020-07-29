#!/bin/bash
# 2．日本語言語パックのインストール
sudo apt -y install language-pack-ja

# 3．ロケールを日本語に設定
sudo update-locale LANG=ja_JP.UTF8

#!/bin/sh

cd "$(dirname "$0")"

# rootかの確認
if [ $(id -u) -ne 0 ]; then
    echo "このスクリプトは root ユーザーでのみ実行できます。" >&2
    exit 1
fi

error() {
    echo "インストールに失敗しました。"
    echo "インストールを中断します。"
    exit 1
}
# 確認
printf "本当に autoswap をインストールしますか？ [Y/n] "
read really
if [ "${really}" = "Y" ] || [ "${really}" = "y" ] || [ "${really}" = "" ]; then
    # インストール
    echo "実行ファイルをインストールしています..."
    cp ./autoswap /usr/local/bin/autoswap > /dev/null || error
    chmod +x /usr/local/bin/autoswap > /dev/null || error

    echo "設定ファイルをインストールしています..."
    cp ./autoswap.conf /usr/local/etc/autoswap.conf > /dev/null || error

    echo "サービスファイルをインストールしています..."
    cp ./autoswap.service /etc/systemd/system/autoswap.service > /dev/null || error
    systemctl daemon-reload > /dev/null || error

    echo "インストールが完了しました。"
    exit 0

else
    echo "インストールを中断しました。"
    exit 0
fi

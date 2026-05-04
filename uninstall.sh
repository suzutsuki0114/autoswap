#!/bin/sh

cd "$(dirname "$0")"

# rootかの確認
if [ $(id -u) -ne 0 ]; then
    echo "このスクリプトは root ユーザーでのみ実行できます。" >&2
    exit 1
fi

error() {
    echo "アンインストールに失敗しました。"
    echo "アンインストールを中断します。"
    exit 1
}

# 確認
printf "本当に autoswap をアンインストールしますか？ [Y/n] "
read really
if [ "${really}" = "Y" ] || [ "${really}" = "y" ] || [ "${really}" = "" ]; then
    # アンインストール
    echo "サービスを停止しています..."
    systemctl stop autoswap.service > /dev/null || error

    echo "サービスを無効化しています..."
    systemctl disable autoswap.service > /dev/null || error

    echo "サービスファイルを削除しています..."
    rm /etc/systemd/system/autoswap.service > /dev/null || error
    systemctl daemon-reload > /dev/null || error

    echo "設定ファイルを削除しています..."
    rm /usr/local/etc/autoswap.conf > /dev/null || error

    echo "実行ファイルを削除しています..."
    rm /usr/local/bin/autoswap > /dev/null || error

    if [ -e /usr/local/share/autoswap ]; then
        echo "作業ディレクトリを削除しています..."
        rm -rf /usr/local/share/autoswap > /dev/null || error
    fi

    echo "アンインストールが完了しました。"
    exit 0

else
    echo "インストールを中断しました。"
    exit 0
fi

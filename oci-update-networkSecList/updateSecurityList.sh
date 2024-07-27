#!/bin/bash
pushd "$(dirname "$0")" || exit

# 対象のセキュリティリストID
LIST_ID=[replace security-list id]

# グローバルIPv4アドレス取得
HOME_IPADDR=$(curl https://checkip.amazonaws.com/)

if [ "$HOME_IPADDR" = "$(cat bef_ip.txt)" ]; then
    echo "$(date '+%y/%m/%d %H:%M:%S') skip"
    popd || exit
    exit
fi

# IPアドレス置換
sed -e "s/<HOME_IPADDR>/${HOME_IPADDR}/g" ./security-list.json > security-list_home.json

# Oracle Cloud反映
oci network security-list update --security-list-id "$LIST_ID" --ingress-security-rules file://security-list_home.json --force

# 反映済みIPアドレス保存
echo "$HOME_IPADDR" > bef_ip.txt
popd || exit
exit

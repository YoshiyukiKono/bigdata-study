# AWS利用時のChromeブラウザ経由プロキシ設定

### SwitcyOmega PAC Script

* Proxy SwitchyOmegaエクステンションをインストール
* Profile の SwitchyOmega Options で、New profile を選択
* PAC Profile を選択
  * 以下の PAC Script を入力
    * "// Important: replace ..."の次の行を自分のVPCのサブネットのIPに合わせて変更。例：*10.0.0.*

```
function regExpMatch(url, pattern) {
  try { return new RegExp(pattern).test(url); } catch(ex) { return false; }
 }
 function FindProxyForURL(url, host) {
  // Important: replace ip address below with the proper prefix for your VPC subnet
  if (shExpMatch(url, "*10.0.0.*")) return "SOCKS5 localhost:8157";
  if (shExpMatch(url, "*ec2*.amazonaws.com*")) return 'SOCKS5 localhost:8157';
  if (shExpMatch(url, "*.compute.internal*") || shExpMatch(url,
 "*://compute.internal*")) return 'SOCKS5 localhost:8157';
  if (shExpMatch(url, "*ec2.internal*")) return 'SOCKS5 localhost:8157';
  return 'DIRECT';
 }
```

### ダイナミックポートフォワーディング(-D)オプション付きでSSH
```socks.sh
if [ $# -ne 1 ]; then
  echo "Usage: socks.sh <hostname>"
  exit 1
fi
echo $#
# nohup ssh -i ykono-sase-tokyo.pem -CND 8157 centos@$1 &
ssh -i ykono-sase-tokyo.pem -CND 8157 centos@$1 
```

### オプション付きでブラウザ起動
```proxy.sh
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --user-data-dir="$HOME/chrome-with-proxy" --proxy-server="socks5://localhost:8157"
```

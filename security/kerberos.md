Java GSS-APIを使用した、JAASプログラミングなしのセキュアなメッセージ交換

https://docs.oracle.com/javase/jp/8/docs/technotes/guides/security/jgss/tutorials/BasicClientServer.html#useSub

Java GSS-API および JSSE をいつ使用するか

https://docs.oracle.com/javase/jp/6/technotes/guides/security/jgss/tutorials/JGSSvsJSSE.html


A Secure HDFS Client Example

https://community.hortonworks.com/articles/56702/a-secure-hdfs-client-example.html

https://tools.ietf.org/html/rfc5653

---

Javaのセキュリティに詳しいかたでご存知の方がいらっしゃれば教えていただきたいんですが、
JavaからKerberosに接続する際、javax.security.auth.useSubjectCredsOnlyプロパティをfalseにする必要がある？
[1] https://community.hortonworks.com/articles/56702/a-secure-hdfs-client-example.html
[2] https://docs.oracle.com/javase/jp/8/docs/technotes/guides/security/jgss/tutorials/BasicClientServer.html#useSub
10 replies

川崎さんのURLなど、いくつか情報見てみました。
https://docs.oracle.com/javase/jp/6/technotes/guides/security/jgss/tutorials/JGSSvsJSSE.html

Yoshiyuki Kono   [21 hours ago]
クレデンシャルの委譲
Java GSS-API を使用すると、Kerberos の使用時に、クライアントからサーバーへクレデンシャルを委譲できます。アプリケーションが、バックエンド層との通信時に中間的存在がクライアントを装う必要がある多層環境に配備されている場合は、Java GSS-API の方が適しています。

選択的暗号化
Java GSS-API はトークンベースであるため、特定のメッセージ (すべてではない) を選択的に暗号化できます。使用するアプリケーションでプレーンテキストと暗号テキストを混在させる必要がある場合には、Java GSS-API の方が適しています。

プロトコル要件
JSSE は RFC 2246 に定義されている TLS プロトコルの実装を提供します。 Java GSS-API は、RFC 2853 に定義されている GSS-API フレームワークの実装と、RFC 1964 に定義されている Kerberos バージョン 5 機構 (Microsoft Windows プラットフォームでは「SSPI with Kerberos」と呼ばれる) の実装を提供します。TLS を使用する HTTPS などのサーバーの場合、JSSE の方が適しています。SASL を使用する LDAP サーバーなどの他のサーバーでは、Kerberos 付きの GSS-API が必要な場合があります。この場合、Java GSS-API の方が適しています。

Yoshiyuki Kono   [21 hours ago]
問い合わせされたケースで、Kerberosに何を利用しているかがわかれば、どのプロトコルが適用されているか、GSS-API利用のケースではない、と言えるか(useSubjectCredsOnly=falseが適切か)が、クリアになるのではないかと思いました。 (edited)

Yoshiyuki Kono   [21 hours ago]
ちなみに、O’reilly Safariで、useSubjectCredsOnlyで検索すると、Weblogicの本が３冊のみヒットし、全て=falseになっている例でした。Internetをみていても、また、上記引用の記述（「バックエンド層との通信時に中間的存在がクライアントを装う必要がある多層環境に配備されている場合は、Java GSS-API の方が適しています」、「Kerberos 付きの GSS-API が必要な場合があります。」）をみていても、RFC 2853/RFC 1964よりも、RFC 2246が主流ということなのかな、という印象を受けましたが …（印象では弱いですが） (edited)

Tatsuo Kawasaki   [21 hours ago]
ありがとうございます。ETLやミドルウェアは軒並みfalseになっていますね。
なぜそうしないといけないのか、は言及されていませんが。

Yoshiyuki Kono   [21 hours ago]
上記のプロトコル要件を参考情報としてお伝えし、お使いのKerberos実装と比べていただく、というのが良いのかな？と思いました。

Yoshiyuki Kono   [21 hours ago]
つまり、GSS-APIでなければ、falseは適切な設定ということで。

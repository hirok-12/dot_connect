# APIモックサーバー
フロントエンドはバックエンドAPIが完成しなくてもモックサーバーを利用して開発出来れば良いなと思い作成。

設計からAPIのスタブを自動生成はswagger-codegenを利用。

nodejsで実行。

# 起動方法
サービスのビルドを実行します。
```
docker-comose build
```
コンテナを作成して、起動します。
```
docker-compose up
```

http://localhost:8080/docs にアクセスすると、Swagger UI のAPI仕様を確認できます。

wagger Specで定義したURLにアクセスするとサンプルデータが表示されます。
例）localhost:8080/v2/user/1

# イメージ：
FROM swaggerapi/swagger-codegen-cli:2.4.14 as builder
# ワークディレクトリをmock-seedとする
WORKDIR /mock-seed
# ホストマシンのswagger.ymlをコピー
COPY ./swagger.yml ./
WORKDIR /mock-server
# モックサーバーアプリケーションを生成する(モックサーバーのファイルを生成)
# -iは元になるjsonを-lは言語を-o 出力先のフォルダを指定するオプション
RUN java -jar /opt/swagger-codegen-cli/swagger-codegen-cli.jar \
    generate -i /mock-seed/swagger.yml -l nodejs-server -o ./

# swagger-codegen-cliはモックサーバーのファイルを生成してくれますが、ホスティングまではしてくれません。
# なのでDockerのマルチステージビルドを利用してnodeでhostingする
FROM node:14.2.0-alpine3.10 as executor
WORKDIR /mock-server
# 上記で作ったモックサーバーのファイル群をコピー
COPY --from=builder /mock-server ./
# パッケージ類のインストール
RUN npm install
# 8080ポートを受ける
EXPOSE 8080
# コンテナ起動でサーバーが起動するようにする
CMD ["npm", "start"]




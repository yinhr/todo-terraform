# todo-terraform
Terraformによるtodo管理アプリの本番稼働環境の定義

## Description
バックエンド（[yinhr/todo-backend](https://github.com/yinhr/todo-backend), [yinhr/todo-nginx](https://github.com/yinhr/todo-nginx)）用の環境と、フロントエンド([yinhr/todo-client](https://github.com/yinhr/todo-frontend)）用の環境をそれぞれterraformにより定義。環境の全体構成は以下の「todo管理アプリについて」のAWSアプリ構成を参照

## todo管理アプリ
以下参照 
[todo管理アプリについて](https://www.notion.so/prmcy/ToDo-14f83b283c4b4bd088ee9f11ebe5be13)

## 機能
* フロントエンド
	* Route53による独自ドメインの管理
	* S3を使用した静的ファイル（html, css, js）の配信
	* CloudFront（CDN）の利用
	* ACMでの証明書発行によるhttps対応
* バックエンド
	* Route53による独自ドメインの管理
	* ACMでの証明書発行によるhttps対応
	* VPCの作成（Multi-AZ）
	* セキュリティグループ
	* Application Load Balancerを使用した負荷分散
	* RDS（MySQL）
	* Elasticache（Redis）
	* KMSを利用したDB暗号化
	* SSMによるECSタスク内で使用する環境変数、機密情報の管理
	* ECRへのDockerイメージホスティング
	* ECS Fargateによるコンテナを利用したアプリケーション実行環境の構築
	* Service Discoveryを用いたECSサービス間通信の実現
	* CloudWatch Logsを使用したECSタスクのログ保管

## Note
* このリポジトリの内容で環境を構築するとAWSの料金が発生します。ご了承の上ご参考下さい。
* この環境はRoute53で既に管理されたゾーン情報を使用しています。あらかじめ独自ドメインの取得が必要です。

## Usage

### ディレクトリ構成
```
[project root]
├── backend/
└── client/
```

### Terraform、AWS-CLIのインストール
以下を参照  
[https://learn.hashicorp.com/terraform/getting-started/install](https://learn.hashicorp.com/terraform/getting-started/install)
[https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-install.html](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-install.html)


### client, backendの各フォルダで以下を実行
初期化
```
terraform init
```
構築内容の確認
```
terraform plan
```
環境構築
```
terraform apply
```
### 構築した環境の削除
```
terraform destroy
```

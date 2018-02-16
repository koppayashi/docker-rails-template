# README

Mac上で動作するDocker & Rails環境のテンプレート

### 以下を事前にインストールしておく

* Docker  
[Docker For Mac](https://www.docker.com/docker-mac "Docker For Mac")  

* Docker Compose  
[Docker Compose](https://docs.docker.com/compose/install/ "Docker Compose")

### 使用方法

1. git cloneする
1. docker-composeでビルドする

```
# Gemを追加した場合とかもbuildが必要
docker-compose build 
```

* Rails起動

```
# -dを付けるとバックグラウンドで起動する
docker-compose up -d
```

* ブラウザで開く  
http://localhost:3000/

* 停止する

```
docker-compose down
```

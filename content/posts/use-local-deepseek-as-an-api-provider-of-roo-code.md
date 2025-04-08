---
date: 2025-04-08
# description: ""
# image: ""
lastmod: 2025-04-08
showTableOfContents: false
tags: ["tech", "Roo Code"]
title: "Use Local DeepSeek as an API Provider of Roo Code"
type: "post"
---

[Roo Codeをお試ししたとき](../roo-code-first-impression/)にAPI代で90ドルくらいかかり、
このままガッツリ使うと破産しそうなのでもうちょっと安く済む方法を探している。

候補の一つである、"バックエンドのAPIを自分で用意してそれを使う"をやってみた。

結論からいうと今回利用した[OLLAMA DeepSeek R1 32B](https://ollama.com/library/deepseek-r1:32b)というモデルではRoo CodeのAPI Providerとしては力不足らしい。

## 実現したいこと

- DeepSeek R1をローカルのコンテナで動かす
- Roo CodeのAPI ProviderとしてローカルのDeepSeekを利用する

## 環境

- OS: Ubuntu24.04
- GPU: NVIDIA RTX4090

## やったこと

### NVIDIA Driverとかをインストールする

以前にやっていたので今回は特に何もしていない

### nvidia-container-runtimeをインストールする

コンテナからGPUを使えるようにするやつ

https://developer.nvidia.com/container-runtime

### Ollamaのコンテナを立てる

image: https://hub.docker.com/r/ollama/ollama

### 立てたコンテナにattachしてモデルをダウンロード&実行する

```sh
docker exec -it ollama ollama pull deepseek-r1:32b
```

この辺はDockerfileに書こうとしたけど何やってもOllamaのサービスが立ち上がっておらずでうまくいかなかった

試してないけどsleepとか挟むといけたりするかも

https://github.com/ollama/ollama/issues/258

モデルのダウンロードが終わったらCLIが立ち上がるのでモデルが動作していることは確認できる。

### devcontainerのRoo CodeからローカルのDeepSeek見る

Roo Codeで以下のprofileを追加する

|key|value|
|---|---|
|API Provider|OpenAI Compatible|
|Base URL|http://172.17.0.1:11434/v1|
|OpenAI API Key|any|
|Model|deepseek-r1:32b|

OllamaがOpenAI互換APIを生やしてくれているのでgateway IP(172.17.0.1)を使ってBase URLを指定する

## 問題

ここまででRoo CodeからDeepSeekを利用できる状態にはなっているのだけど、

なにか指示を投げると、指示と関係なさそうなことを考えたのち、`Roo is having trouble...`となってしまう。

適当にissueを見た感じ、Roo Codeのシステムプロンプトがモデルへの入力としては複雑すぎる、長すぎるらしい。

https://github.com/RooVetGit/Roo-Code/issues/612

## 感想

アウトプットが遅すぎるとか質が低すぎて使い物にならないとかは想定していたけど、そもそもインプットすらできなくて厳しい。

issueの回答にもある`Foot Gun System Prompting`で適当にシステムプロンプトを縮めるとか、別のモデルを試すとか
まだ手はあるけど望みは薄そうな感じがしている。

他の手段としてはClaude Code+Claude Desktopとかもあるっぽいけどコンテナで完結しないのでいまいちやる気がでない。

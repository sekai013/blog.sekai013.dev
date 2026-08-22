---
title: "20268022"
date: 2026-08-22
lastmod: 2026-08-22
showTableOfContents: false
tags:
  - tech
type: post
---
最近やったことまとめ

## DeskMiniにMCPのエンドポイントを立ててTunnel機能でChatGPTから利用する

最初はGitHub PluginでChatGPTからGitHub操作して満足していたけど、結局ChatGPTのワークスペースでは大したことはできず、GitHub Actionsをハックしてなんとか処理を実行しようとしたりするので、DeskMiniを作業環境として与えることにした

適当に権限制御したユーザでChatGPTからいろいろ実行できる

全てが変わりすぎてヤバい

DeskMini持て余している感があったけど、今は間違いなく心の底からあってよかったと言える

## メインPCをK3sのノードとして参加させる

ChatGPTからDeskMiniを操作できるようになったけど、DeskMiniもある程度のCPUとRAMがあるだけなので、GPUも扱えるようにメインPCもノードとして参加させることにして、ChatGPT経由でモデルを指示してベンチマークを取らせたり、GPUを使った学習とかができるようになった

ホストのよくわかんないパスをマウントできないような設定とかをしてある

## ChatGPTからKaggleの過去コンペをやってみる

https://www.kaggle.com/competitions/home-credit-default-risk/overview

に取り組むよう指示してみて、メインPCのGPUを使った学習しながら改善し続けて、丸1日でリーダーボードの上位11％相当のprivate.794まできた\
ほぼ常にjobが投げられてGPUが使用されているおかげでゲームができなくて困る

次はGPUとjobに関する監視や通知がないのでそのあたりを追加して\
ジョブが終わったら通知がきて次の指示を出せるような感じにしたい

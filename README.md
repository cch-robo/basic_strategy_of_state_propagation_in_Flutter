# Basic Strategy of State Propagation and Access Restriction in Flutter

[DroidKaigi 2019](https://droidkaigi.jp/2019/timetable/70887)  
DAY.02 (Feb 8th, 2019)  
JA Room 6 － 2019/02/08 17:40-18:10  
初心者歓迎 クロスプラットフォーム  
FlutterでのWidgetツリーへの状態伝播とアクセス制限の基本戦略 のサンプルソースです。

- リポジトリの doc ディレクトリに[セッション資料の PDF](doc/basic_strategy_of_state_propagation_in_Flutter.pdf) があります。


## サンプルソースについて

Flutterのネストが深くならないように気をつけたり、
基本ウィジェット (*1) のみを使った、アプリ全体での状態や
ロジックの共有とアクセスの制限について説明するためのサンプルソースです。

_初学者が対象ですので、BLOCなど応用技術の説明ではありません。_
- 基本ウィジェット：InheritedWidget

## サンプルアプリについて

サンプルソースは、個別のアプリとしてラウンチャーで起動できるようになっています。  
サンプルソースでは、ビルドフローの変化を Android Studio などのログ出力で確認できるよう、
Scaffold や Text ウィジェットなどをラップした MyScaffold や MyText ウィジェットを使っていることに留意ください。

- サンプルソース選択画面＆実行画面  
<img src="doc/sample_app_image.png" width="600px" border="1" />

- normal widget build flow
カウンタアプリに表示や再表示時のビルドフロー・ログ出力を追加したサンプルです。  
(ログ表示確認用)

- rebuildable widget build
カウンタアプリにピンポイントで再表示と再表示抑止ができるようにするウィジェットのサンプルです。  
(ソースコードとログ表示確認用)

- deep nested widget tree
カウンタアプリをデコってネストを深くしたサンプルです。  
(ソースコードの確認用)

- build divided by component
深くなったネストをコンポーネントを作って外出しするサンプルです。  
(ソースコードの確認用)

- state on page transition
カウンタアプリに画面遷移を追加しただけのサンプルです。  
(挙動とソースコードの確認用)

- State Propagation
InheritedWidgetを使って状態とロジックを外出ししたサンプルです。  
(挙動とソースコードの確認用)

- lifecycle observer
[Flutter Meetup Tokyo #6](https://flutter-jp.connpass.com/event/105834/)、[Flutter lifecycle ハンドリングの実践](https://docs.google.com/presentation/d/1grxIVw8WmE1LmFKo9Bx8QHuDjJKSL2BBFfvzKwiUuqk/edit) で発表した、ページレベルのライフサイクルを監視できるようにするウィジェットのサンプルです。  
(ソースコードとログ表示確認用)


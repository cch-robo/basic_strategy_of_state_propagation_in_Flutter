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

- [normal widget build flow](https://github.com/cch-robo/basic_strategy_of_state_propagation_in_Flutter/blob/master/lib/src/normal_widget_build_flow.dart)
カウンタアプリに表示や再表示時のビルドフロー・ログ出力を追加したサンプルです。  
(ログ表示確認用)

- [rebuildable widget build](https://github.com/cch-robo/basic_strategy_of_state_propagation_in_Flutter/blob/master/lib/src/rebuildable_widget_build.dart)  
カウンタアプリにピンポイントで再表示と再表示抑止ができるようにするウィジェットのサンプルです。  
(ソースコードとログ表示確認用)

- [deep nested widget tree](https://github.com/cch-robo/basic_strategy_of_state_propagation_in_Flutter/blob/master/lib/src/deep_nested_widget_tree.dart)  
カウンタアプリをデコってネストを深くしたサンプルです。  
(ソースコードの確認用)

- [build divided by component](https://github.com/cch-robo/basic_strategy_of_state_propagation_in_Flutter/blob/master/lib/src/build_divided_by_component.dart)  
深くなったネストをコンポーネントを作って外出しするサンプルです。  
(ソースコードの確認用)

- [state on page transition](https://github.com/cch-robo/basic_strategy_of_state_propagation_in_Flutter/blob/master/lib/src/state_on_page_transition.dart)  
カウンタアプリに画面遷移を追加しただけのサンプルです。  
(挙動とソースコードの確認用)

- [State Propagation](https://github.com/cch-robo/basic_strategy_of_state_propagation_in_Flutter/blob/master/lib/src/strategy_of_state_propagation.dart)  
InheritedWidgetを使って状態とロジックを外出ししたサンプルです。  
(挙動とソースコードの確認用)

- [lifecycle observer](https://github.com/cch-robo/basic_strategy_of_state_propagation_in_Flutter/blob/master/lib/src/lifecycle_observer.dart)  
[Flutter Meetup Tokyo #6](https://flutter-jp.connpass.com/event/105834/)、[Flutter lifecycle ハンドリングの実践](https://docs.google.com/presentation/d/1grxIVw8WmE1LmFKo9Bx8QHuDjJKSL2BBFfvzKwiUuqk/edit) で発表した、ページレベルのライフサイクルを監視できるようにするウィジェットのサンプルです。  
(ソースコードとログ表示確認用)

- [proxy_types.dart](https://github.com/cch-robo/basic_strategy_of_state_propagation_in_Flutter/blob/master/lib/src/base/proxy_types.dart)  
Proxy クラスは、任意のオブジェクトの身代わりとなりソースコードを変更することなく、メソッドの挙動を置き換えたり、メソッド実行前後に横断的関心事を追加できるようにします。  
オブジェクトのクラス型とProxy型は異なるため、適用するオブジェクトの変数や引数の型を dybnamic にする必要があるので利用はテストやデバッグ時に限定されますが、よろしければ御利用下さい。  
使い方については、[proxy_unit_test.dart](https://github.com/cch-robo/basic_strategy_of_state_propagation_in_Flutter/blob/master/test/proxy_unit_test.dart) のテスト実装を御参照ください。



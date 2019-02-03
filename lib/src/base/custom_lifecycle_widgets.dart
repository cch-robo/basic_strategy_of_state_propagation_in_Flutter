import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// アプリ全体で、フォアグラウンドのページウイジェット・ライフサイクル状態変化を通知する Widget
/// AppLifecycleObserverWidget は、
/// 各ページウイジェットを管理する PageWidgetLifecycleObserverWidget と連携して、
/// フォアグラウンドになっているウイジェットツリーのライフサイクル状態変更を通知する Widgetです。
///
/// child: で指定されたアプリ・ウイジェットツリーの Visibility や foreground の変更による、
/// AppLifecycleState ⇒ inactive, pause, resumed, suspending の最新状態を捕捉できるようにして、
/// 各ページウイジェットごとの PageWidgetLifecycleObserverWidget オブジェクトと、
/// AppLifecycleState.pushPageWidgetObserver(), AppLifecycleState.popPageWidgetObserver() で連携をはかり、
/// 各ライフサイクル状態変更コールバックに initialize ~ dispose, inactive, pause, resumed, suspending の最新状態を通知します。
///
/// (補足)全ての生存中ウイジェットのライフサイクルが監視されますが、スタック・トップのウイジェットのコールバック関数のみに通知を行います。
/// (補足)全ての生存中ウイジェットのライフサイクルが監視されますが、スタック・ボトム(ルート)のウイジェットのみ dispose が無視されます。
///
/// 【利用サンプル】
///   void main() => runApp(
///       new AppLifecycleObserverWidget(
///         child: new MyApp(),
///       ),
///   );
///
/// 【参考】
/// 　WidgetsBindingObserver class
/// 　https://docs.flutter.io/flutter/widgets/WidgetsBindingObserver-class.html
///
/// 　AppLifecycleState enum
/// 　https://docs.flutter.io/flutter/dart-ui/AppLifecycleState-class.html
///
/// 　Flutter App lifecycle (Android/ Ios )
/// 　https://stackoverflow.com/questions/50131598/flutter-app-lifecycle-android-ios
///
///   How to Activate position listener only when page is shown?
///   https://stackoverflow.com/questions/50191933/how-to-activate-position-listener-only-when-page-is-shown
///
class AppLifecycleObserverWidget extends StatefulWidget {

  /// フォアグラウンド・ページウイジェット・ライフサイクル状態値
  PageWidgetLifecycleState _pageWidgetLifecycleState;

  /// ライフサイクル監視ページウイジェット・リスト
  static final List<PageWidgetLifecycleObserverWidget> _pageWidgetNames = <PageWidgetLifecycleObserverWidget>[];

  /// ライフサイクル監視ページウイジェット・状態変更を通知先（コールバック関数）・マップ
  /// （key: ページウィジェット名, value: コールバック関数）
  static final Map<PageWidgetLifecycleObserverWidget, void Function(PageWidgetLifecycleState pageWidgetLifecycleState)>
  _pageWidgetListeners = <PageWidgetLifecycleObserverWidget, void Function(PageWidgetLifecycleState)>{};

  /// ライフサイクル状態を監視するアプリのウイジェットツリー・ルートウイジェット
  final Widget _child;


  AppLifecycleObserverWidget({
    Key key,
    @required Widget child,
  }) : this._child = child, super(key: key);


  /// フォアグラウンド・ページウイジェット
  PageWidgetLifecycleObserverWidget get pageWidgetObserver => _pageWidgetNames.isNotEmpty ? _pageWidgetNames.last : null;

  /// フォアグラウンド・ページウイジェット名
  String get pageName => _pageWidgetNames.isNotEmpty ? _pageWidgetNames.last.pageName : null;

  /// フォアグラウンド・ページウイジェット型
  Type get pageType => _pageWidgetNames?.last?.pageType ?? null;

  /// フォアグラウンド・ページウイジェット・ライフサイクル状態値
  PageWidgetLifecycleState get pageWidgetLifecycleState => _pageWidgetLifecycleState;

  /// フォアグラウンド・ページウイジェット・ライフサイクル変更通知先（コールバック関数）
  void Function(PageWidgetLifecycleState pageWidgetLifecycleState) get pageWidgetReaction => _pageWidgetNames.isNotEmpty ? _pageWidgetListeners[_pageWidgetNames.last] : null;

  /// ページウイジェットを追加
  static void pushPageWidgetObserver(PageWidgetLifecycleObserverWidget pageWidgetObserver) {
    _pageWidgetNames.add(pageWidgetObserver);
    _pageWidgetListeners[pageWidgetObserver] = pageWidgetObserver.pageWidgetListener;
  }

  /// ページウイジェットを削除
  static void popPageWidget(PageWidgetLifecycleObserverWidget pageWidgetObserver) {

    // 【注意】ライフサイクル監視オブジェクトは、initState() 時と dispose() 時でインスタンスが異なります。
    // PageWidgetLifecycleObserverWidget は、Flutter システム内部で initState() 後に再生成し直されます、
    // このためリストから引数に該当するライフサイクル監視オブジェクトを取得します。
    PageWidgetLifecycleObserverWidget removePageWidgetObserver;
    _pageWidgetNames.forEach((PageWidgetLifecycleObserverWidget widget){
      if (pageWidgetObserver.pageType == widget.pageType) {
        removePageWidgetObserver = widget;
      }
    });

    _pageWidgetListeners.remove(removePageWidgetObserver);
    _pageWidgetNames.remove(removePageWidgetObserver);

    // WidgetsBindingObserver は、
    // 子ウイジェットの削除による、親ウイジェットの再表示イベントを捕捉しないため、
    // 親ページウイジェットが存在する場合のみ、再表示イベントを強制的に通知します。
    if (_pageWidgetNames.isNotEmpty) {
      _pageWidgetListeners[_pageWidgetNames.last](PageWidgetLifecycleState.resumed);
    }
  }

  @override
  _AppLifecycleObserverState createState() => new _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserverWidget> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    // Widget Lifecycle observer 登録
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Widget Lifecycle observer 削除
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._child;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // WidgetsBindingObserver のメソッド実装

    // アプリ・ライフサイクル状態値との対応変換
    switch (state) {
      case AppLifecycleState.resumed:
        widget._pageWidgetLifecycleState = PageWidgetLifecycleState.resumed;
        break;
      case AppLifecycleState.inactive:
        widget._pageWidgetLifecycleState = PageWidgetLifecycleState.inactive;
        break;
      case AppLifecycleState.paused:
        widget._pageWidgetLifecycleState = PageWidgetLifecycleState.paused;
        break;
      case AppLifecycleState.suspending:
        widget._pageWidgetLifecycleState = PageWidgetLifecycleState.suspending;
        break;
    }

    // ページウイジェット・リアクション実行（ページ状態変更イベント通知）
    if (widget.pageWidgetReaction != null) widget.pageWidgetReaction(widget.pageWidgetLifecycleState);
  }

  @override
  void didChangeAccessibilityFeatures() {
  }

  @override
  void didChangeLocales(List<Locale> locale) {
  }

  @override
  void didChangeMetrics() {
  }

  @override
  void didChangeTextScaleFactor() {
  }

  @override
  void didHaveMemoryPressure() {
  }

  @override
  Future<bool> didPopRoute() async {
    /*
    // true を返すようにオーバライドすると Android の BackKey イベントが封印されます。
    return true;
    */
    return false;
  }

  @override
  Future<bool> didPushRoute(String route) async {
    return false;
  }
}

/// ページウイジェットのライフサイクル状態変化を通知する Widget
///
/// PageWidgetLifecycleObserverWidget は、
/// 各ページウイジェットをラップして、initState ~ dispose および、
/// Visibility や foreground の変更による inactive, pause, resumed, suspending の
/// ライフサイクル状態変更イベントが、ページウイジェットごとのコールバック関数に通知できるよう、
/// AppLifecycleObserverWidget との連携をはかる Widgetです。
///
/// child: で指定されたページウイジェットと、
/// reaction: で指定されたページウイジェット・ライフサイクル状態変更通知のコールバック関数を
/// AppLifecycleObserverWidget に登録して、ライフサイクル状態変更イベントが通知できるようにします。
///
/// ページウイジェットの initState ~ dispose および Visibility や foreground の変更のイベントは、
/// 対応する PageWidgetLifecycleState イベント種別を引数にして、コールバック関数に通知されます。
///
/// 【利用サンプル】
///   Navigator.of(_initContext).push(
///       new MaterialPageRoute(
///           builder: (BuildContext context) =>
///             new PageWidgetLifecycleObserverWidget(
///               child: new MyHomePage(),
///               listener: (PageWidgetLifecycleState pageWidgetLifecycleState) {
///                 print("MyHomePage  state=${pageWidgetLifecycleState.toString()}");
///               },
///             ),
///       )
///   );
///
class PageWidgetLifecycleObserverWidget extends StatefulWidget {

  /// ライフサイクル監視対象のページウイジェット（ライフサイクル状態を監視するウイジェットツリー）
  final Widget _pageWidget;

  /// ライフサイクル監視対象のページウイジェット・ライフサクル状態変更通知/コールバック関数
  final void Function(PageWidgetLifecycleState pageWidgetLifecycleState) _pageWidgetListener;

  /// コンストラクタ
  PageWidgetLifecycleObserverWidget({
    Key key,
    @required Widget child,
    @required void Function(PageWidgetLifecycleState pageWidgetLifecycleState) listener,
  }) : this._pageWidget = child, this._pageWidgetListener = listener, super(key: key);

  /// ページウイジェット名
  String get pageName => _pageWidget.runtimeType.toString();

  /// ページウイジェット型
  Type get pageType => _pageWidget.runtimeType;

  /// ページウイジェット・ライフサクル状態変更通知関数
  void Function(PageWidgetLifecycleState pageWidgetLifecycleState) get pageWidgetListener => _pageWidgetListener;

  @override
  _PageWidgetLifecycleObserverState createState() => new _PageWidgetLifecycleObserverState();
}

class _PageWidgetLifecycleObserverState extends State<PageWidgetLifecycleObserverWidget> {

  @override
  void initState() {
    super.initState();
    // アプリ・ライフサイクル監視に追加
    AppLifecycleObserverWidget.pushPageWidgetObserver(widget);

    // リアクション実行（ページ状態変更イベント通知）
    widget.pageWidgetListener(PageWidgetLifecycleState.initialized);
  }

  @override
  void dispose() {
    // リアクション実行（ページ状態変更イベント通知）
    widget.pageWidgetListener(PageWidgetLifecycleState.disposed);

    // アプリ・ライフサイクル監視から削除
    AppLifecycleObserverWidget.popPageWidget(widget);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._pageWidget;
  }
}

/// ページウイジェット・ライフサイクル状態値 列挙子
enum PageWidgetLifecycleState {
  /// ページが visible であり、ユーザイベントを捕捉できるようにうなったことを示す状態値
  /// （AppLifecycleState.resumed 相当）
  resumed,

  /// ページが visible であるが foreground でなくなり、ユーザイベントを捕捉できなくなったことを示す状態値
  /// （AppLifecycleState.inactive 相当）
  inactive,

  /// ページが visible でも foreground でもなくなり、ユーザイベントを捕捉できなくなることを示す状態値
  /// （AppLifecycleState.paused 相当）
  paused,

  /// ページが visible でなく foreground でもなくなったことを示す状態値（Androidのみ paused 後に至る状態）
  /// （AppLifecycleState.suspending 相当）
  suspending,

  /// ページが 生成されて初期化されたことを示す状態値
  /// （StatefulWidget#initState メソッド実行タイミング相当）
  initialized,

  /// ページが 破棄されたことを示す状態値
  /// （StatefulWidget#dispose メソッド実行タイミング相当）
  disposed,
}
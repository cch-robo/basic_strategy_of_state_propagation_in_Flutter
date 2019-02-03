import 'package:flutter/material.dart';
import 'package:basic_of_state_propagation/src/base/custom_lifecycle_widgets.dart';
import 'package:basic_of_state_propagation/src/base/log_widgets.dart';
import 'package:basic_of_state_propagation/main.dart' as launcher;

void main() => runApp(
                MyAppInheritedWidget(
                  // アプリ全体のライフサイクルを監視するウィジェット
                  child: AppLifecycleObserverWidget(
                    child: MyApp(),
                  ),
                )
              );

class MyApp extends MyStatelessWidget {

  MyApp({ Key key, String name = "MyApp" })
      : super(name: name, key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");
    return
      MaterialApp(
        title: 'Basic Strategy of State Propagation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyPage1InheritedWidget(
            // MyNavigatorPushPopPage ページのライフサイクルを監視するウィジェット
            child: PageWidgetLifecycleObserverWidget(
              child: MyNavigatorPushPage(),
              listener: (PageWidgetLifecycleState pageWidgetLifecycleState) {
                debugPrint(" \nPageWidgetLifecycleState[#1]  lifecycle state=${pageWidgetLifecycleState.toString()}");
              },
            ),
        ),
      );
  }
}

/// 第１のページ
class MyNavigatorPushPage extends MyStatefulWidget {
  MyNavigatorPushPage({String name, Key key, this.title = "Lifecycle Overver Page#1"})
      : super(name: "MyNavigatorPushPage[#1]", key: key);

  final String title;

  @override
  _MyNavigatorPushPageState createState() {
    debugPrint("$name#createState()  instance=${this.hashCode}");
    return createStateHolder(
        _MyNavigatorPushPageState(name: "$name:State"));
  }
}

class _MyNavigatorPushPageState extends MyState<MyNavigatorPushPage> {

  _MyNavigatorPushPageState({String name}) : super(name: name);

  @override
  Widget build(BuildContext context) {
    // MyWidgetを使った、Widget Tree ビルドフローログ出力
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    MyPageLogic logic = MyPage1InheritedWidget.getLogic(context);

    return MyScaffold(
      key: logic.myScaffoldGlobalKey,
      name: "MyScaffold[#1]",
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () =>launcher.main(),
          ),
        ]
      ),

      body: MyContainer(
        name: "MyContainer[#1]",
        alignment: Alignment.center,
        child: MyColumn(
          name: "MyColumn[#1]",
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // ラベル表示部のコンポーネント
            MyLabelStatelessComponent(name: "[#1]",
                outerColor: Colors.green, innerColor: Colors.lightGreen),

            // RebuildableWidget は、rebuild() 指定で、子ウィジェットを再生成する(可変にする) Widget。
            MyRebuildableWidget(
              key: logic.myRebuildableWidgetKey,
              builder: (BuildContext context, StateSetter setState) {

                // カウンター表示部のコンポーネント
                return MyCounterStatelessComponent(
                    name: "[#1]",
                    parameter: logic.counter,
                    outerColor: Colors.blue, innerColor: Colors.lightBlue);
              },
            ),

            MyRaisedButton(
              name: "pushMyRaisedButton[#1]",
              color: Colors.lightGreenAccent,
              onPressed: () {
                debugPrint(" \nMyNavigatorPushPage#1  push to#2");
                // Navigator．push() 時には、次ページの生成と現ページを含む全ての前ページの再buildが行われます。
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                        // PageRoute 下の InheritedWidget は、他のPageRouteを参照できません。
                        MyPage2InheritedWidget(
                          // MyNavigatorPushPopPage ページのライフサイクルを監視するウィジェット
                          child: PageWidgetLifecycleObserverWidget(
                              child: MyNavigatorPushPopPage(),
                              listener: (PageWidgetLifecycleState pageWidgetLifecycleState) {
                                debugPrint(" \nPageWidgetLifecycleState[#2]  lifecycle state=${pageWidgetLifecycleState.toString()}");
                              },
                          ),
                        ),
                  ),
                );
              },
              child: Text("Navigator PUSH to#2"),
            ),

          ],
        ),
      ),

      floatingActionButton: MyFloatingActionButton(
        name: "MyFAB[#1]",
        onPressed: () {
          logic.incrementCounter();
          /*
          // Scaffold Elementの全ツリー構造のデバッグ出力
          logic.debugChildElements();
          */
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


/// 第２のページ
class MyNavigatorPushPopPage extends MyStatefulWidget {
  MyNavigatorPushPopPage({String name, Key key, this.title: "Lifecycle Overver Page#2"})
      : super(name: "MyNavigatorPushPopPage[#2]", key: key);

  final String title;

  @override
  _MyNavigatorPushPopPageState createState() {
    debugPrint("$name#createState()  instance=${this.hashCode}");
    return createStateHolder(
        _MyNavigatorPushPopPageState(name: "$name:State"));
  }
}

class _MyNavigatorPushPopPageState extends MyState<MyNavigatorPushPopPage> {

  _MyNavigatorPushPopPageState({String name}) : super(name: name);

  @override
  Widget build(BuildContext context) {
    // MyWidgetを使った、Widget Tree ビルドフローログ出力
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    MyPageLogic logic = MyPage2InheritedWidget.getLogic(context);

    return MyScaffold(
      key: logic.myScaffoldGlobalKey,
      name: "MyScaffold[#2]",
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: MyContainer(
        name: "MyContainer[#2]",
        alignment: Alignment.center,
        child: MyColumn(
          name: "MyColumn[#2]",
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // ラベル表示部のコンポーネント
            MyLabelStatelessComponent(name: "[#2]",
                outerColor: Colors.deepOrange, innerColor: Colors.orange),

            // RebuildableWidget は、rebuild() 指定で、子ウィジェットを再生成する(可変にする) Widget。
            MyRebuildableWidget(
              key: logic.myRebuildableWidgetKey,
              builder: (BuildContext context, StateSetter setState) {

                // カウンター表示部のコンポーネント
                return MyCounterStatelessComponent(
                    name: "[#2]",
                    parameter: logic.counter,
                    outerColor: Colors.blue, innerColor: Colors.lightBlue);
              },
            ),

            MyRaisedButton(
              name: "pushMyRaisedButton[#2]",
              color: Colors.lightGreenAccent,
              onPressed: () {
                debugPrint(" \nMyNavigatorPushPopPage#2  push to#3");
                // Navigator．push() 時には、次ページの生成と現ページを含む全ての前ページの再buildが行われます。
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                        // PageRoute 下の InheritedWidget は、他のPageRouteを参照できません。
                        MyPage3InheritedWidget(
                          // MyNavigatorPushPopPage ページのライフサイクルを監視するウィジェット
                          child: PageWidgetLifecycleObserverWidget(
                            child: MyNavigatorPopPage(),
                            listener: (PageWidgetLifecycleState pageWidgetLifecycleState) {
                              debugPrint(" \nPageWidgetLifecycleState[#3]  lifecycle state=${pageWidgetLifecycleState.toString()}");
                            },
                          ),
                        ),
                  ),
                );
              },
              child: Text("Navigator PUSH to#3"),
            ),

            MyRaisedButton(
              name: "popMyRaisedButton[#2]",
              color: Colors.yellowAccent,
              onPressed: () {
                debugPrint(" \nMyNavigatorPushPopPage#2  pop to#1");
                // Navigator．pop() 時には、全ての前ページの再buildが行われます。
                Navigator.pop(context);
              },
              child: Text("Navigator POP to#1"),
            ),

          ],
        ),
      ),

      floatingActionButton: MyFloatingActionButton(
        name: "MyFAB[#2]",
        onPressed: () {
          logic.incrementCounter();
          /*
          // Scaffold Elementの全ツリー構造のデバッグ出力
          logic.debugChildElements();
          */
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

}


/// 第３のページ
class MyNavigatorPopPage extends MyStatefulWidget {
  MyNavigatorPopPage({String name, Key key, this.title: "Lifecycle Overver Page#3"})
      : super(name: "MyNavigatorPopPage[#3]", key: key);

  final String title;

  @override
  _MyNavigatorPopPageState createState() {
    debugPrint("$name#createState()  instance=${this.hashCode}");
    return createStateHolder(
        _MyNavigatorPopPageState(name: "$name:State"));
  }
}

class _MyNavigatorPopPageState extends MyState<MyNavigatorPopPage> {

  _MyNavigatorPopPageState({String name}) : super(name: name);

  @override
  Widget build(BuildContext context) {
    // MyWidgetを使った、Widget Tree ビルドフローログ出力
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    MyPageLogic logic = MyPage3InheritedWidget.getLogic(context);

    return MyScaffold(
      key: logic.myScaffoldGlobalKey,
      name: "MyScaffold[#3]",
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: MyContainer(
        name: "MyContainer[#3]",
        alignment: Alignment.center,
        child: MyColumn(
          name: "MyColumn[#3]",
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // ラベル表示部のコンポーネント
            MyLabelStatelessComponent(name: "[#3]",
                outerColor: Colors.deepPurple,
                innerColor: Colors.purpleAccent),

            MyRebuildableWidget(
              key: logic.myRebuildableWidgetKey,
              builder: (BuildContext context, StateSetter setState) {

                // カウンター表示部のコンポーネント
                return MyCounterStatelessComponent(
                    name: "[#3]",
                    parameter: logic.counter,
                    outerColor: Colors.blue, innerColor: Colors.lightBlue);
              },
            ),

            MyRaisedButton(
              name: "popMyRaisedButton[#3]",
              color: Colors.yellowAccent,
              onPressed: () {
                debugPrint(" \nMyNavigatorPopPage#3  pop to#2");
                // Navigator．pop() 時には、全ての前ページの再buildが行われます。
                Navigator.pop(context);
              },
              child: Text("Navigator POP to#2"),
            ),

          ],
        ),
      ),

      floatingActionButton: MyFloatingActionButton(
        name: "MyFAB[#3]",
        onPressed: () {
          logic.incrementCounter();
          /*
          // Scaffold Elementの全ツリー構造のデバッグ出力
          logic.debugChildElements();
          */
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}



/// Business Logic 提供の抽象コンポーネント
abstract class MyLogicInheritedWidget extends MyInheritedWidget {

  MyLogicInheritedWidget({
    String name = "MyLogicInheritedWidget",
    Key key,
    Widget child
  }) :  super(name: name, key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    super.updateShouldNotify(oldWidget);
    // 更新が発生した場合は、再構築するとします。
    return true;
  }
}

/// アプリ全体で共有する Business Logic を提供するコンポーネント
class MyAppInheritedWidget extends MyLogicInheritedWidget {

  MyAppInheritedWidget({
    String name = "MyAppInheritedWidget",
    Key key,
    Widget child
  }) :  super(name: name, key: key, child: child);

  /// アプリ全体共有のロジック＆状態提供
  static MyAppInheritedWidget of(BuildContext context) {
    debugPrint("MyAppInheritedWidget#of(context:${context.hashCode}:${context.runtimeType.toString()}), caller widget=${context.widget.hashCode}:${context.widget.runtimeType.toString()}");
    return context.inheritFromWidgetOfExactType(MyAppInheritedWidget);
  }

  /// ページ１からのアクセスのときのみ ページ１のロジックを返します。
  static MyPageLogic ofPage1(BuildContext context) {
    MyAppInheritedWidget appLogic = MyAppInheritedWidget.of(context);
    return appLogic.checkPermission(context, MyPage1InheritedWidget) ? appLogic._page1Logic : null;
  }

  /// ページ２からのアクセスのときのみ ページ２のロジックを返します。
  static MyPageLogic ofPage2(BuildContext context) {
    MyAppInheritedWidget appLogic = MyAppInheritedWidget.of(context);
    return appLogic.checkPermission(context, MyPage2InheritedWidget) ? appLogic._page2Logic : null;
  }

  /// ページ３からのアクセスのときのみ ページ３のロジックを返します。
  static MyPageLogic ofPage3(BuildContext context) {
    MyAppInheritedWidget appLogic = MyAppInheritedWidget.of(context);
    return appLogic.checkPermission(context, MyPage3InheritedWidget) ? appLogic._page3Logic : null;
  }

  // 簡便化のため、このクラスに直接 アプリ全体の state や logic を記述しています。

  // ページ１〜３のロジック
  final _page1Logic = new MyPageLogic(name: "MyPageLogic[#1]");
  final _page2Logic = new MyPageLogic(name: "MyPageLogic[#2]");
  final _page3Logic = new MyPageLogic(name: "MyPageLogic[#3]");

  /// 指定クラスのインスタンス(継承物は除外)が、context に含まれるか否かを返します。
  bool checkPermission(BuildContext context, Type targetType) {
    return context.ancestorWidgetOfExactType(targetType) != null;
  }
}

/// ページ１〜３のロジッククラス
class MyPageLogic {
  final String name;
  final GlobalKey<MyRebuildableWidgetState> _myRebuildableWidgetKey = new GlobalKey<MyRebuildableWidgetState>();
  final GlobalKey<MyScaffoldState> _myScaffoldGlobalKey = GlobalKey();
  MyStatefulElement myScaffoldElement;

  int _counter;

  MyPageLogic({this.name = "MyPageLogic"}) {
    clear();
  }

  int get counter => _counter;
  GlobalKey<MyRebuildableWidgetState> get myRebuildableWidgetKey => _myRebuildableWidgetKey;
  GlobalKey<MyScaffoldState> get myScaffoldGlobalKey => _myScaffoldGlobalKey;

  void clear() {
    _counter = 0;
  }

  void incrementCounter() {
    debugPrint(" \n$name  incrementCounter, _counter=$counter");
    _counter++;
    _myRebuildableWidgetKey.currentState.rebuild();
  }

  void debugChildElements() {
    if (myScaffoldElement == null) {
      myScaffoldElement = (myScaffoldGlobalKey.currentWidget as MyScaffold).elementHolder.object;
    }
    debugPrint(" \ndebugChildElements()");
    myScaffoldElement.debugChildElements();
  }
}

/// ページ１の Business Logic を提供するコンポーネント
class MyPage1InheritedWidget extends MyLogicInheritedWidget {

  final String message = "this is MyPage1InheritedWidget's message.";

  MyPage1InheritedWidget({
    String name = "MyPage1InheritedWidget",
    Key key,
    Widget child
  }) : super(name: name, key: key, child: child);

  /// ページ１のコンポーネントを取得
  static MyPage1InheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyPage1InheritedWidget);
  }

  /// アプリ全体共有のロジックからページ１のロジックを取得
  static MyPageLogic getLogic(BuildContext context) {
    return MyAppInheritedWidget.ofPage1(context);
  }
}

/// ページ２の Business Logic を提供するコンポーネント
class MyPage2InheritedWidget extends MyLogicInheritedWidget {

  final String message = "this is MyPage2InheritedWidget's message.";

  MyPage2InheritedWidget({
    String name = "MyPage2InheritedWidget",
    Key key,
    Widget child
  }) : super(name: name, key: key, child: child);

  /// ページ２のコンポーネントを取得
  static MyPage2InheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyPage2InheritedWidget);
  }

  /// アプリ全体共有のロジックからページ２のロジックを取得
  static MyPageLogic getLogic(BuildContext context) {
    return MyAppInheritedWidget.ofPage2(context);
  }
}

/// ページ３の Business Logic を提供するコンポーネント
class MyPage3InheritedWidget extends MyLogicInheritedWidget {

  final String message = "this is MyPage3InheritedWidget's message.";

  MyPage3InheritedWidget({
    String name = "MyPage3InheritedWidget",
    Key key,
    Widget child
  }) : super(name: name, key: key, child: child);

  /// ページ３のコンポーネントを取得
  static MyPage3InheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyPage3InheritedWidget);
  }

  /// アプリ全体共有のロジックからページ３のロジックを取得
  static MyPageLogic getLogic(BuildContext context) {
    return MyAppInheritedWidget.ofPage3(context);
  }
}


/// ラベル表示部のコンポーネント (StatelessWidget)
class MyLabelStatelessComponent<T> extends MyStatelessWidget {
  final T parameter;
  final  BuildContext ownerContext;
  final Color outerColor;
  final Color innerColor;
  final String indexLabel;

  MyLabelStatelessComponent({
    this.parameter,
    this.ownerContext,
    @required this.outerColor,
    @required this.innerColor,
    String name,
    Key key,
  }) :  this.indexLabel = name,
        super(name: "MyLabelComponent$name", key: key);

  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");

    return
      MyContainer(
        name: "labelOuterMyContainer$indexLabel",
        color: outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "labelMyContainer$indexLabel",
          color: innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),

          child: MyText(
            'You have pushed the button this many times:',
            name: "labelMyText$indexLabel",
          ),

        ),

      );
  }
}

/// カウンター表示部のコンポーネント (StatelessWidget)
class MyCounterStatelessComponent<T> extends MyStatelessWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;
  final String indexLabel;

  MyCounterStatelessComponent({
    this.parameter,
    @required this.outerColor,
    @required this.innerColor,
    String name,
    Key key,
  }) :  this.indexLabel = name,
        super(name: "MyCounterComponent$name", key: key);

  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");

    return
      MyContainer(
        name: "counterOuterMyContainer$indexLabel",
        color: outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "counterMyContainer$indexLabel",
          color: innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),

          child: MyText(
            '$parameter',
            name: "counterMyText$indexLabel",
            style: Theme.of(context).textTheme.display1,
          ),

        ),

      );
  }
}


/// ラベル表示部のコンポーネント (StatefulWidget)
class MyLabelStatefulComponent<T> extends MyStatefulWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;
  final String indexLabel;

  MyLabelStatefulComponent({
    this.parameter,
    @required this.outerColor,
    @required this.innerColor,
    String name,
    Key key,
  }) :  this.indexLabel = name,
        super(name: "MyLabelComponent$name", key: key);

  @override
  State<StatefulWidget> createState() {
    debugPrint("$name#createState()  instance=${this.hashCode}");
    return createStateHolder(
        new MyLabelStatefulComponentState(name: "$name:State"));
  }
}
class MyLabelStatefulComponentState extends MyState<MyLabelStatefulComponent> {

  MyLabelStatefulComponentState({String name}) : super(name: name);

  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    return
      MyContainer(
        name: "labelOuterMyContainer${widget.indexLabel}",
        color: widget.outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "labelMyContainer${widget.indexLabel}",
          color: widget.innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),

          child: MyText(
            'You have pushed the button this many times:',
            name: "labelMyText${widget.indexLabel}",
          ),

        ),

      );
  }
}

/// カウンター表示部のコンポーネント (StatefulWidget)
class MyCounterStatefulComponent<T> extends MyStatefulWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;
  final String indexLabel;

  MyCounterStatefulComponent({
    this.parameter,
    @required this.outerColor,
    @required this.innerColor,
    String name,
    Key key,
  }) :  this.indexLabel = name,
        super(name: "MyCounterComponent$name", key: key);

  @override
  State<StatefulWidget> createState() {
    debugPrint("$name#createState()  instance=${this.hashCode}");
    return createStateHolder(
        new MyCounterStatefulComponentState(name: "$name:State"));
  }
}
class MyCounterStatefulComponentState extends MyState<MyCounterStatefulComponent> {

  MyCounterStatefulComponentState({String name}) : super(name: name);

  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    return
      MyContainer(
        name: "counterOuterMyContainer${widget.indexLabel}",
        color: widget.outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "counterMyContainer${widget.indexLabel}",
          color: widget.innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),

          child: MyText(
            '${widget.parameter}',
            name: "counterMyText${widget.indexLabel}",
            style: Theme.of(context).textTheme.display1,
          ),

        ),

      );
  }
}
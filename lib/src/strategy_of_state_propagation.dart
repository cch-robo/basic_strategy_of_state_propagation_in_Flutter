import 'package:flutter/material.dart';
import 'package:basic_of_state_propagation/src/base/custom_widgets.dart';
import 'package:basic_of_state_propagation/main.dart' as launcher;

void main() => runApp(
                  AppInheritedWidget(
                    child: MyApp()
                  )
                );

class MyApp extends StatelessWidget {

  MyApp({ Key key })
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        title: 'Basic Strategy of State Propagation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Page1InheritedWidget(
          child: NavigatorPushPage(),
        ),
      );
  }
}

/// 第１のページ
class NavigatorPushPage extends StatefulWidget {
  NavigatorPushPage({Key key, this.title = "State Propagation Page#1"})
      : super(key: key);

  final String title;

  @override
  _NavigatorPushPageState createState() {
    return _NavigatorPushPageState();
  }
}

class _NavigatorPushPageState extends State<NavigatorPushPage> {

  _NavigatorPushPageState() : super();

  @override
  Widget build(BuildContext context) {

    PageLogic logic = Page1InheritedWidget.getLogic(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () =>launcher.main(),
          ),
        ]
      ),

      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // ラベル表示部のコンポーネント
            LabelStatelessComponent(
                outerColor: Colors.green, innerColor: Colors.lightGreen),

            // RebuildableWidget は、rebuild() 指定で、子ウィジェットを再生成する(可変にする) Widget。
            RebuildableWidget(
              key: logic.rebuildableWidgetKey,
              builder: (BuildContext context, StateSetter setState) {

                // カウンター表示部のコンポーネント
                return CounterStatelessComponent(
                    parameter: logic.counter,
                    outerColor: Colors.blue, innerColor: Colors.lightBlue);
              },
            ),

            RaisedButton(
              color: Colors.lightGreenAccent,
              onPressed: () {
                // Navigator．push() 時には、次ページの生成と現ページを含む全ての前ページの再buildが行われます。
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        // PageRoute 下の InheritedWidget は、他のPageRouteを参照できません。
                        return Page2InheritedWidget(
                            child: NavigatorPushPopPage());
                      }
                  ),
                );
              },
              child: Text("Navigator PUSH to#2"),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logic.incrementCounter();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


/// 第２のページ
class NavigatorPushPopPage extends StatefulWidget {
  NavigatorPushPopPage({Key key, this.title: "State Propagation Page#2"})
      : super(key: key);

  final String title;

  @override
  _NavigatorPushPopPageState createState() {
    return _NavigatorPushPopPageState();
  }
}

class _NavigatorPushPopPageState extends State<NavigatorPushPopPage> {

  _NavigatorPushPopPageState() : super();

  @override
  Widget build(BuildContext context) {

    PageLogic logic = Page2InheritedWidget.getLogic(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // ラベル表示部のコンポーネント
            LabelStatelessComponent(
                outerColor: Colors.deepOrange, innerColor: Colors.orange),

            // RebuildableWidget は、rebuild() 指定で、子ウィジェットを再生成する(可変にする) Widget。
            RebuildableWidget(
              key: logic.rebuildableWidgetKey,
              builder: (BuildContext context, StateSetter setState) {

                // カウンター表示部のコンポーネント
                return CounterStatelessComponent(
                    parameter: logic.counter,
                    outerColor: Colors.blue, innerColor: Colors.lightBlue);
              },
            ),

            RaisedButton(
              color: Colors.lightGreenAccent,
              onPressed: () {
                // Navigator．push() 時には、次ページの生成と現ページを含む全ての前ページの再buildが行われます。
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        // PageRoute 下の InheritedWidget は、他のPageRouteを参照できません。
                        return Page3InheritedWidget(child: NavigatorPopPage());
                      }
                  ),
                );
              },
              child: Text("Navigator PUSH to#3"),
            ),

            RaisedButton(
              color: Colors.yellowAccent,
              onPressed: () {
                // Navigator．pop() 時には、全ての前ページの再buildが行われます。
                Navigator.pop(context);
              },
              child: Text("Navigator POP to#1"),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logic.incrementCounter();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

}


/// 第３のページ
class NavigatorPopPage extends StatefulWidget {
  NavigatorPopPage({Key key, this.title: "State Propagation Page#3"})
      : super(key: key);

  final String title;

  @override
  _NavigatorPopPageState createState() {
    return _NavigatorPopPageState();
  }
}

class _NavigatorPopPageState extends State<NavigatorPopPage> {

  _NavigatorPopPageState() : super();

  @override
  Widget build(BuildContext context) {

    PageLogic logic = Page3InheritedWidget.getLogic(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // ラベル表示部のコンポーネント
            LabelStatelessComponent(
                outerColor: Colors.deepPurple,
                innerColor: Colors.purpleAccent),

            RebuildableWidget(
              key: logic.rebuildableWidgetKey,
              builder: (BuildContext context, StateSetter setState) {

                // カウンター表示部のコンポーネント
                return CounterStatelessComponent(
                    parameter: logic.counter,
                    outerColor: Colors.blue, innerColor: Colors.lightBlue);
              },
            ),

            RaisedButton(
              color: Colors.yellowAccent,
              onPressed: () {
                // Navigator．pop() 時には、全ての前ページの再buildが行われます。
                Navigator.pop(context);
              },
              child: Text("Navigator POP to#2"),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logic.incrementCounter();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}



/// Business Logic 提供の抽象コンポーネント
abstract class LogicInheritedWidget extends InheritedWidget {

  LogicInheritedWidget({
    Key key,
    Widget child
  }) :  super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // 更新が発生した場合は、再構築するとします。
    return true;
  }
}

/// アプリ全体で共有する Business Logic を提供するコンポーネント
class AppInheritedWidget extends LogicInheritedWidget {

  AppInheritedWidget({
    Key key,
    Widget child
  }) :  super(key: key, child: child);

  /// アプリ全体共有のロジック＆状態提供
  static AppInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppInheritedWidget);
  }

  /// ページ１からのアクセスのときのみ ページ１のロジックを返します。
  static PageLogic ofPage1(BuildContext context) {
    AppInheritedWidget appLogic = AppInheritedWidget.of(context);
    return appLogic.checkPermission(context, Page1InheritedWidget) ? appLogic._page1Logic : null;
  }

  /// ページ２からのアクセスのときのみ ページ２のロジックを返します。
  static PageLogic ofPage2(BuildContext context) {
    AppInheritedWidget appLogic = AppInheritedWidget.of(context);
    return appLogic.checkPermission(context, Page2InheritedWidget) ? appLogic._page2Logic : null;
  }

  /// ページ３からのアクセスのときのみ ページ３のロジックを返します。
  static PageLogic ofPage3(BuildContext context) {
    AppInheritedWidget appLogic = AppInheritedWidget.of(context);
    return appLogic.checkPermission(context, Page3InheritedWidget) ? appLogic._page3Logic : null;
  }

  // ページ１〜３のロジック
  final _page1Logic = new PageLogic(name: "MyPageLogic[#1]");
  final _page2Logic = new PageLogic(name: "MyPageLogic[#2]");
  final _page3Logic = new PageLogic(name: "MyPageLogic[#3]");

  /// 指定クラスのインスタンス(継承物は除外)が、context に含まれるか否かを返します。
  bool checkPermission(BuildContext context, Type targetType) {
    return context.ancestorWidgetOfExactType(targetType) != null;
  }
}

/// ページ１〜３のロジッククラス
class PageLogic {
  final String name;
  final GlobalKey<RebuildableWidgetState> _rebuildableWidgetKey = new GlobalKey<RebuildableWidgetState>();

  int _counter;

  PageLogic({this.name = "MyPageLogic"}) {
    clear();
  }

  int get counter => _counter;
  GlobalKey<RebuildableWidgetState> get rebuildableWidgetKey => _rebuildableWidgetKey;

  void clear() {
    _counter = 0;
  }

  void incrementCounter() {
    debugPrint(" \n$name  incrementCounter, _counter=$counter");
    _counter++;
    _rebuildableWidgetKey.currentState.rebuild();
  }
}

/// ページ１の Business Logic を提供するコンポーネント
class Page1InheritedWidget extends LogicInheritedWidget {

  final String message = "this is MyPage1InheritedWidget's message.";

  Page1InheritedWidget({
    Key key,
    Widget child
  }) : super(key: key, child: child);

  /// ページ１のコンポーネントを取得
  static Page1InheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(Page1InheritedWidget);
  }

  /// アプリ全体共有のロジックからページ１のロジックを取得
  static PageLogic getLogic(BuildContext context) {
    return AppInheritedWidget.ofPage1(context);
  }
}

/// ページ２の Business Logic を提供するコンポーネント
class Page2InheritedWidget extends LogicInheritedWidget {

  final String message = "this is MyPage2InheritedWidget's message.";

  Page2InheritedWidget({
    Key key,
    Widget child
  }) : super(key: key, child: child);

  /// ページ２のコンポーネントを取得
  static Page2InheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(Page2InheritedWidget);
  }

  /// アプリ全体共有のロジックからページ２のロジックを取得
  static PageLogic getLogic(BuildContext context) {
    return AppInheritedWidget.ofPage2(context);
  }
}

/// ページ３の Business Logic を提供するコンポーネント
class Page3InheritedWidget extends LogicInheritedWidget {

  final String message = "this is MyPage3InheritedWidget's message.";

  Page3InheritedWidget({
    Key key,
    Widget child
  }) : super(key: key, child: child);

  /// ページ３のコンポーネントを取得
  static Page3InheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(Page3InheritedWidget);
  }

  /// アプリ全体共有のロジックからページ３のロジックを取得
  static PageLogic getLogic(BuildContext context) {
    return AppInheritedWidget.ofPage3(context);
  }
}


/// ラベル表示部のコンポーネント (StatelessWidget)
class LabelStatelessComponent<T> extends StatelessWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;
  final String indexLabel;

  LabelStatelessComponent({
    this.parameter,
    @required this.outerColor,
    @required this.innerColor,
    String name,
    Key key,
  }) :  this.indexLabel = name,
        super(key: key);

  Widget build(BuildContext context) {

    return
      Container(
        color: outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: Container(
          color: innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),

          child: Text(
            'You have pushed the button this many times:',
          ),

        ),

      );
  }
}

/// カウンター表示部のコンポーネント (StatelessWidget)
class CounterStatelessComponent<T> extends StatelessWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;
  final String indexLabel;

  CounterStatelessComponent({
    this.parameter,
    @required this.outerColor,
    @required this.innerColor,
    String name,
    Key key,
  }) :  this.indexLabel = name,
        super(key: key);

  Widget build(BuildContext context) {

    return
      Container(
        color: outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: Container(
          color: innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),

          child: Text(
            '$parameter',
            style: Theme.of(context).textTheme.display1,
          ),

        ),

      );
  }
}


/// ラベル表示部のコンポーネント (StatefulWidget)
class LabelStatefulComponent<T> extends StatefulWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;

  LabelStatefulComponent({
    this.parameter,
    @required this.outerColor,
    @required this.innerColor,
    Key key,
  }) :  super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LabelStatefulComponentState();
  }
}
class LabelStatefulComponentState extends State<LabelStatefulComponent> {

  LabelStatefulComponentState() : super();

  Widget build(BuildContext context) {

    return
      Container(
        color: widget.outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: Container(
          color: widget.innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),

          child: Text(
            'You have pushed the button this many times:',
          ),

        ),

      );
  }
}

/// カウンター表示部のコンポーネント (StatefulWidget)
class CounterStatefulComponent<T> extends StatefulWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;

  CounterStatefulComponent({
    this.parameter,
    @required this.outerColor,
    @required this.innerColor,
    String name,
    Key key,
  }) :  super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CounterStatefulComponentState();
  }
}
class CounterStatefulComponentState extends State<CounterStatefulComponent> {

  CounterStatefulComponentState() : super();

  Widget build(BuildContext context) {

    return
      Container(
        color: widget.outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: Container(
          color: widget.innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),

          child: Text(
            '${widget.parameter}',
            style: Theme.of(context).textTheme.display1,
          ),

        ),

      );
  }
}
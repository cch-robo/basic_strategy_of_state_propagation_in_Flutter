import 'package:flutter/material.dart';
import 'package:basic_of_state_propagation/src/base/log_widgets.dart';
import 'package:basic_of_state_propagation/main.dart' as launcher;

void main() => runApp(MyApp());

class MyApp extends MyStatelessWidget {

  MyApp({ Key key, String name = "MyApp" })
      : super(name: name, key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");
    return MaterialApp(
      title: 'Basic Strategy of State Propagation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePageInheritedWidget(child: MyHomePage(title: 'put state to out and no param')),
    );
  }
}

class MyHomePage extends MyStatefulWidget {
  MyHomePage({String name = "MyHomePage", Key key, this.title})
      : super(name: name, key: key);

  final String title;

  @override
  _MyHomePageState createState() {
    debugPrint("$name#createState()  instance=${this.hashCode}");
    return createStateHolder(
        _MyHomePageState(name: "$name:State"));
  }
}

class _MyHomePageState extends MyState<MyHomePage> {
  final GlobalKey<MyScaffoldState> myScaffoldGlobalKey = GlobalKey();
  MyStatefulElement myScaffoldElement;

  _MyHomePageState({String name}) : super(name: name);

  void _incrementCounter() {
    /*
    // Scaffold Elementの全ツリー構造のデバッグ出力
    if (myScaffoldElement == null) {
      myScaffoldElement = (myScaffoldGlobalKey.currentWidget as MyScaffold).elementHolder.object;
    }
    debugPrint(" \ndebugChildElements()");
    myScaffoldElement.debugChildElements();
    */

    debugPrint(" \n$name  _incrementCounter, name=${widget.name}, widget=${widget.hashCode}:${widget.runtimeType.toString()}, _counter=${MyHomePageInheritedWidget.of(context).logic.counter}");
    setState(() {
      MyHomePageInheritedWidget.of(context).logic.increment();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    // MyWidgetを使った、Widget Tree ビルドフローログ出力

    return MyScaffold(
      key: myScaffoldGlobalKey,
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
        alignment: Alignment.center,
        child: MyColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // ラベル表示部のコンポーネント
            MyLabelStatelessComponent(),

            // カウンター表示部のコンポーネント
            MyCounterStatelessComponent(),

          ],
        ),
      ),

      floatingActionButton: MyFloatingActionButton(
        onPressed: _incrementCounter,
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

/// MyHomePageのロジッククラス
class MyPageLogic {
  int _counter;

  MyPageLogic() {
    clear();
  }

  int get counter => _counter;

  void increment() => _counter++;

  void clear() {
    _counter = 0;
  }
}

/// MyHomePageの Business Logic を提供するコンポーネント
class MyHomePageInheritedWidget extends MyLogicInheritedWidget {

  final String message = "this is MyPage1InheritedWidget's message.";

  MyHomePageInheritedWidget({
    String name = "MyPage1InheritedWidget",
    Key key,
    Widget child
  }) : super(name: name, key: key, child: child);

  /// MyHomePageのコンポーネントを取得
  static MyHomePageInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyHomePageInheritedWidget);
  }

  MyPageLogic get logic => _myHomePageLogic;

  // MyHomePageのロジック
  final _myHomePageLogic = new MyPageLogic();
}


/// ラベル表示部のコンポーネント (StatelessWidget)
class MyLabelStatelessComponent<T> extends MyStatelessWidget {
  final Color outerColor;
  final Color innerColor;

  MyLabelStatelessComponent({
    this.outerColor = Colors.green,
    this.innerColor = Colors.lightGreen,
    String name = "MyLabelComponent",
    Key key,
  }) :  super(name: name, key: key);

  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");

    return
      MyContainer(
        name: "labelOuterMyContainer",
        color: outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "labelMyContainer",
          color: innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),

          child: MyText(
            'You have pushed the button this many times:',
            name: "labelMyText",
          ),

        ),

      );
  }
}

/// カウンター表示部のコンポーネント (StatelessWidget)
class MyCounterStatelessComponent<T> extends MyStatelessWidget {
  final Color outerColor;
  final Color innerColor;

  MyCounterStatelessComponent({
    this.outerColor = Colors.blue,
    this.innerColor = Colors.lightBlue,
    String name = "MyCounterComponent",
    Key key,
  }) :  super(name: name, key: key);

  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");

    return
      MyContainer(
        name: "counterOuterMyContainer",
        color: outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "counterMyContainer",
          color: innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),

          child: MyText(
            '${MyHomePageInheritedWidget.of(context).logic.counter}',
            name: "counterMyText",
            style: Theme.of(context).textTheme.display1,
          ),

        ),

      );
  }
}


/// ラベル表示部のコンポーネント (StatefulWidget)
class MyLabelStatefulComponent<T> extends MyStatefulWidget {
  final Color outerColor;
  final Color innerColor;

  MyLabelStatefulComponent({
    this.outerColor = Colors.green,
    this.innerColor = Colors.lightGreen,
    String name = "MyLabelComponent",
    Key key,
  }) : super(name: name, key: key);

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
        name: "labelOuterMyContainer",
        color: widget.outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "labelMyContainer",
          color: widget.innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),

          child: MyText(
            'You have pushed the button this many times:',
            name: "labelMyText",
          ),

        ),

      );
  }
}

/// カウンター表示部のコンポーネント (StatefulWidget)
class MyCounterStatefulComponent<T> extends MyStatefulWidget {
  final Color outerColor;
  final Color innerColor;

  MyCounterStatefulComponent({
    this.outerColor = Colors.blue,
    this.innerColor = Colors.lightBlue,
    String name = "MyCounterComponent",
    Key key,
  }) : super(name: name, key: key);

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
        name: "counterOuterMyContainer",
        color: widget.outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "counterMyContainer",
          color: widget.innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),

          child: MyText(
            '${MyHomePageInheritedWidget.of(context).logic.counter}',
            name: "counterMyText",
            style: Theme.of(context).textTheme.display1,
          ),

        ),

      );
  }
}

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
      home: MyNavigatorPushPage(),
    );
  }
}


/// 第１のページ
class MyNavigatorPushPage extends MyStatefulWidget {
  MyNavigatorPushPage({String name, Key key, this.title = "Navigator Page#1"})
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
  int _counter = 0;
  final GlobalKey<MyScaffoldState> myScaffoldGlobalKey = GlobalKey();
  MyStatefulElement myScaffoldElement;

  _MyNavigatorPushPageState({String name}) : super(name: name);

  void _incrementCounter() {
    /*
    // Scaffold Elementの全ツリー構造のデバッグ出力
    if (myScaffoldElement == null) {
      myScaffoldElement = (myScaffoldGlobalKey.currentWidget as MyScaffold).elementHolder.object;
    }
    debugPrint(" \ndebugChildElements()");
    myScaffoldElement.debugChildElements();
    */

    debugPrint(" \n$name  _incrementCounter, name=${widget.name}, widget=${widget.hashCode}:${widget.runtimeType.toString()}, _counter=$_counter");
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MyWidgetを使った、Widget Tree ビルドフローログ出力
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    return MyScaffold(
      key: myScaffoldGlobalKey,
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

            // カウンター表示部のコンポーネント
            MyCounterStatelessComponent(name: "[#1]", parameter: _counter,
                outerColor: Colors.blue, innerColor: Colors.lightBlue),

            MyRaisedButton(
              name: "pushMyRaisedButton[#1]",
              color: Colors.lightGreenAccent,
              onPressed: () {
                debugPrint(" \nMyNavigatorPushPage#1  push to#2");
                // Navigator．push() 時には、次ページの生成と現ページを含む全ての前ページの再buildが行われます。
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return MyNavigatorPushPopPage();
                      }
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


/// 第２のページ
class MyNavigatorPushPopPage extends MyStatefulWidget {
  MyNavigatorPushPopPage({String name, Key key, this.title: "Navigator Page#2"})
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
  int _counter = 0;
  final GlobalKey<MyScaffoldState> myScaffoldGlobalKey = GlobalKey();
  MyStatefulElement myScaffoldElement;

  _MyNavigatorPushPopPageState({String name}) : super(name: name);

  void _incrementCounter() {
    /*
    // Scaffold Elementの全ツリー構造のデバッグ出力
    if (myScaffoldElement == null) {
      myScaffoldElement = (myScaffoldGlobalKey.currentWidget as MyScaffold).elementHolder.object;
    }
    debugPrint(" \ndebugChildElements()");
    myScaffoldElement.debugChildElements();
    */

    debugPrint(" \n$name  _incrementCounter, name=${widget.name}, widget=${widget.hashCode}:${widget.runtimeType.toString()}, _counter=$_counter");
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MyWidgetを使った、Widget Tree ビルドフローログ出力
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    return MyScaffold(
      key: myScaffoldGlobalKey,
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

            // カウンター表示部のコンポーネント
            MyCounterStatelessComponent(name: "[#2]", parameter: _counter,
                outerColor: Colors.blue, innerColor: Colors.lightBlue),

            MyRaisedButton(
              name: "pushMyRaisedButton[#2]",
              color: Colors.lightGreenAccent,
              onPressed: () {
                debugPrint(" \nMyNavigatorPushPopPage#2  push to#3");
                // Navigator．push() 時には、次ページの生成と現ページを含む全ての前ページの再buildが行われます。
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return MyNavigatorPopPage();
                      }
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


/// 第３のページ
class MyNavigatorPopPage extends MyStatefulWidget {
  MyNavigatorPopPage({String name, Key key, this.title: "Navigator Page#3"})
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
  int _counter = 0;
  final GlobalKey<MyScaffoldState> myScaffoldGlobalKey = GlobalKey();
  MyStatefulElement myScaffoldElement;

  _MyNavigatorPopPageState({String name}) : super(name: name);

  void _incrementCounter() {
    /*
    // Scaffold Elementの全ツリー構造のデバッグ出力
    if (myScaffoldElement == null) {
      myScaffoldElement = (myScaffoldGlobalKey.currentWidget as MyScaffold).elementHolder.object;
    }
    debugPrint(" \ndebugChildElements()");
    myScaffoldElement.debugChildElements();
    */

    debugPrint(" \n$name  _incrementCounter, name=${widget.name}, widget=${widget.hashCode}:${widget.runtimeType.toString()}, _counter=$_counter");
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MyWidgetを使った、Widget Tree ビルドフローログ出力
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    return MyScaffold(
      key: myScaffoldGlobalKey,
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
                outerColor: Colors.deepPurple, innerColor: Colors.purpleAccent),

            // カウンター表示部のコンポーネント
            MyCounterStatelessComponent(name: "[#3]", parameter: _counter,
                outerColor: Colors.blue, innerColor: Colors.lightBlue),

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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}



/// ラベル表示部のコンポーネント (StatelessWidget)
class MyLabelStatelessComponent<T> extends MyStatelessWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;
  final String indexLabel;

  MyLabelStatelessComponent({
    this.parameter,
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
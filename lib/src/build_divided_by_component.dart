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
      home: MyHomePage(title: 'build divided by component'),
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
  int _counter = 0;
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

    debugPrint(" \n$name  _incrementCounter, name=${widget.name}, widget=${widget.hashCode}:${widget.runtimeType.toString()}, _counter=$_counter");
    setState(() {
      _counter++;
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
            MyCounterStatelessComponent(parameter: _counter),

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



/// ラベル表示部のコンポーネント (StatelessWidget)
class MyLabelStatelessComponent<T> extends MyStatelessWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;

  MyLabelStatelessComponent({
    this.parameter,
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
  final T parameter;
  final Color outerColor;
  final Color innerColor;

  MyCounterStatelessComponent({
    this.parameter,
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
            '$parameter',
            name: "counterMyText",
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

  MyLabelStatefulComponent({
    this.parameter,
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
  final T parameter;
  final Color outerColor;
  final Color innerColor;

  MyCounterStatefulComponent({
    this.parameter,
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
            '${widget.parameter}',
            name: "counterMyText",
            style: Theme.of(context).textTheme.display1,
          ),

        ),

      );
  }
}

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
      home: MyHomePage(title: 'build splited by method'),
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
            _buildLabelComponent(),

            // カウンター表示部のコンポーネント
            _buildCounterComponent(context),

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

  /// build(context) の ラベル表示部のコンポーネント生成メソッド
  Widget _buildLabelComponent() {
    return
      MyContainer(
        name: "labelOuterMyContainer",
        color: Colors.green,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "labelMyContainer",
          color: Colors.lightGreen,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),

          child: MyText(
            'You have pushed the button this many times:',
            name: "labelMyText",
          ),

        ),

      );
  }

  /// build(context) の カウンター表示部のコンポーネント生成メソッド
  Widget _buildCounterComponent(BuildContext context) {
    return
      MyContainer(
        name: "counterOuterMyContainer",
        color: Colors.blue,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "counterMyContainer",
          color: Colors.lightBlue,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),

          child: MyText(
            '$_counter',
            name: "counterMyText",
            style: Theme.of(context).textTheme.display1,
          ),

        ),

      );
  }
}

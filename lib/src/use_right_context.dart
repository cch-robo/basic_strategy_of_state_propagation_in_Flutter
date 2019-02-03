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
      home: MyHomePage(title: 'use right context'),
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

            MyText(
              'You have pushed the button this many times:',
              name: "labelMyText",
            ),

            MyText(
              '$_counter',
              name: "counterMyText",
              style: Theme.of(context).textTheme.display1,
            ),

            // build(context) で提供された context には、Scaffold が含まれていません。
            // build で渡された context は、MyHomePage の context なので、
            // まだ Scaffold 生成前のものだからです。
            MyRaisedButton(
              name: "wrongContextMyRaisedButton",
              child: Text('SnackBar with wrong context'),
              color: Colors.red,
              onPressed: () {
                final SnackBar snackBar = SnackBar(content: Text('hello'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
            ),

            // Scaffold が含まれた context を取得するため、
            // Scaffold ネスト内部で、Build (ウィジェット) を生成して、
            // Scaffold が含まれた Build の context を SnackBar に提供します。
            MyBuilder(
              name: "rightContextMyBuilder",
              builder: (BuildContext context) =>
                MyRaisedButton(
                  name: "rightContextMyRaisedButton",
                  child: Text('SnackBar with right context'),
                  color: Colors.lightBlue,
                  onPressed: () {
                    final SnackBar snackBar = SnackBar(content: Text('hello'));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                ),
            ),

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

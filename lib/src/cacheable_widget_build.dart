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
      home: MyHomePage(title: 'cacheable widget build'),
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

  _MyHomePageState({String name}): super(name: name);

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

  // build(context)で再定義されないようにする。
  MyScaffold myScarffold;
  AppBar myAppbar;
  MyContainer myContainer;
  MyColumn myColumn;
  MyText myLabelText;
  MyText myCounterText;
  FloatingActionButton myFloatingActionButton;

  // Widget Tree の 各Widget の新旧比較ができるよう、
  // Widget Tree の Element を取得しておきます。
  MyStatefulElement               myScarffoldElement;
  MyStatelessElement              myContainerElement;
  MyMultiChildRenderObjectElement myColumnElement;
  MyStatelessElement              myLabelTextElement;
  MyStatelessElement              myCounterTextElement;

  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    // Widget Tree の新規作成か更新かを判定できるようにする。
    bool isUpdateFactory = myScarffold != null;
    bool isFirstUpdateFactory = isUpdateFactory && myScarffoldElement == null;

    // Widget Tree の 各Widget の新旧比較ができるよう、
    // Widget Tree 新規生成時(あるいはツリー構造変更時)のみ作成される Element を取得しておきます。
    // 注意：Widget Tree 構築による Element インスタンスが生成されるのは、build(context):Widget 終了後です。
    if (isFirstUpdateFactory) {
      myScarffoldElement   = myScarffold.elementHolder.object;
      myContainerElement   = myContainer.elementHolder.object;
      myColumnElement      = myColumn.elementHolder.object;
      myLabelTextElement   = myLabelText.elementHolder.object;
      myCounterTextElement = myCounterText.elementHolder.object;
    }

    myFloatingActionButton = myFloatingActionButton ?? FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );

    myLabelText = myLabelText ?? MyText(
      'You have pushed the button this many times:',
      name: "labelMyText",
    );

    myCounterText = /*myCounterText ?? */MyText(
      '$_counter',
      name: "counterMyText",
      style: Theme.of(context).textTheme.display1,
    );
    // UI構成Tree に登録された Widget (初期生成時のインスタンス)がもつ Element に、新規生成 Widget を比較させます。
    // Element に、新規生成 Widget を比較させると変化があるため Widget の build(context) が発生する。
    if (isUpdateFactory) {
      // element.update(newWidget) の実行後は、
      // newWidget が Widget Tree のノードに差し替えられることに注意
      myCounterTextElement.update(myCounterText);
    }

    myColumn = myColumn ?? MyColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          myLabelText,
          myCounterText,
        ]
    );

    myContainer = myContainer ?? MyContainer(
      alignment: Alignment.center,
      child: myColumn,
    );

    myAppbar = myAppbar ?? AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () =>launcher.main(),
        ),
      ]
    );

    myScarffold = myScarffold ?? MyScaffold(
      key: myScaffoldGlobalKey,
      appBar: myAppbar,
      body: myContainer,
      floatingActionButton: myFloatingActionButton,
    );

    return myScarffold;
  }
}

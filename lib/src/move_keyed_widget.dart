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
      home: MyHomePage(title: 'move keyd widget'),
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

  /// コンポーネント・ケースの切替フラグ
  /// 0: キー指定のない StatelessWidget型コンポーネント
  /// 1: キー指定のない StatefulWidget型コンポーネント
  /// 2: キー指定のある StatelessWidget型コンポーネント
  /// 3: キー指定のある StatefulWidget型コンポーネント
  final int switchCase = 3;

  /// グリーンのコンポーネント・固定インスタンス
  Widget _greenComponent;

  /// オレンジのコンポーネント・固定インスタンス
  Widget _orangeComponent;


  @override
  void initState() {
    super.initState();

    switch(switchCase) {
      case 0:
        // キー指定のない、コンポーネント・インスタンス (StatelessWidget)
        _greenComponent = new MyStatelessComponent(outerColor: Colors.lightGreen, innerColor: Colors.green);
        _orangeComponent = new MyStatelessComponent(outerColor: Colors.deepOrange, innerColor: Colors.orange);
        break;
      case 1:
        // キー指定のない、コンポーネント・インスタンス (StatefulWidget)
        _greenComponent = new MyStatefulComponent(outerColor: Colors.lightGreen, innerColor: Colors.green);
        _orangeComponent = new MyStatefulComponent(outerColor: Colors.deepOrange, innerColor: Colors.orange);
        break;
      case 2:
        // Flutter framework が、同じ型のオブジェクト同士でも区別できるよう、キーを指定する (StatelessWidget)
        _greenComponent = new MyStatelessComponent(key: new GlobalKey(), outerColor: Colors.lightGreen, innerColor: Colors.green);
        _orangeComponent = new MyStatelessComponent(key: new GlobalKey(), outerColor: Colors.deepOrange, innerColor: Colors.orange);
        break;
      case 3:
        // Flutter framework が、同じ型のオブジェクト同士でも区別できるよう、キーを指定する (StatefulWidget)
        _greenComponent = new MyStatefulComponent(key: new GlobalKey(), outerColor: Colors.lightGreen, innerColor: Colors.green);
        _orangeComponent = new MyStatefulComponent(key: new GlobalKey(), outerColor: Colors.deepOrange, innerColor: Colors.orange);
        break;
      default:
        assert(true);
        break;
    }
  }

  /// カウンターによりコンポーネントの並び順を切り替える。
  /// ・カウンターが偶数の場合、グリーン、オレンジ、カウンター の順番
  /// ・カウンターが奇数の場合、オレンジ、グリーン、カウンター の順番
  List<Widget> switchComponents(int counter) {
    // コンポーネントのリスト
    List<Widget> components;

    // カウンターにより表示位置を差替
    if (counter % 2 == 0) {
      components =<Widget>[
        _greenComponent,  // グリーン表示は、同じインスタンスを使いまわす
        _orangeComponent, // オレンジ表示は、同じインスタンスを使いまわす
        MyCounterStatelessComponent(parameter: counter), // カウンター表示は毎回生成
      ];
    } else {
      components =<Widget>[
        _orangeComponent, // オレンジ表示は、同じインスタンスを使いまわす
        _greenComponent,  // グリーン表示は、同じインスタンスを使いまわす
        MyCounterStatelessComponent(parameter: counter), // カウンター表示は毎回生成
      ];
    }
    return components;
  }

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
          children: switchComponents(_counter), // コンポーネントの順序切替
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



/// StatelessWidget コンポーネント
/// コンストラクタ引数により、外枠の色と内側の色を設定できます。
class MyStatelessComponent extends MyStatelessWidget {
  final Color outerColor;
  final Color innerColor;

  MyStatelessComponent({
    @required this.outerColor,
    @required this.innerColor,
    String name = "MyStatelessComponent",
    Key key,
  }) :  super(name: name, key: key);

  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");

    return
      MyContainer(
        name: "outerMyContainer",
        color: outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "innerMyContainer",
          color: innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),

          child: MyText(
            'MyStatelessComponent',
            name: "MyText",
          ),

        ),

      );
  }
}

/// StatefulWidget コンポーネント
/// コンストラクタ引数により、外枠の色と内側の色を設定できます。
class MyStatefulComponent extends MyStatefulWidget {
  final Color outerColor;
  final Color innerColor;

  MyStatefulComponent({
    @required this.outerColor,
    @required this.innerColor,
    String name = "MyStatefulComponent",
    Key key,
  }) : super(name: name, key: key);

  @override
  State<StatefulWidget> createState() {
    debugPrint("$name#createState()  instance=${this.hashCode}");
    return createStateHolder(
        new MyStatefulComponentState(name: "$name:State"));
  }
}
class MyStatefulComponentState extends MyState<MyStatefulComponent> {

  MyStatefulComponentState({String name}) : super(name: name);

  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");

    return
      MyContainer(
        name: "outerMyContainer",
        color: widget.outerColor,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),

        child: MyContainer(
          name: "innerMyContainer",
          color: widget.innerColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),

          child: MyText(
            'StatefulComponent',
            name: "MyText",
          ),

        ),

      );
  }
}

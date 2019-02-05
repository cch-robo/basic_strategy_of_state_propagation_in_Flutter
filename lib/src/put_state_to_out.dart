import 'package:flutter/material.dart';
import 'package:basic_of_state_propagation/main.dart' as launcher;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp({ Key key })
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Strategy of State Propagation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePageInheritedWidget(child: MyHomePage(title: 'put state to out')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState() : super();

  void _incrementCounter() {
    debugPrint(" \n_incrementCounter, widget=${widget.hashCode}:${widget.runtimeType.toString()}, _counter=${MyHomePageInheritedWidget.of(context).logic.counter}");
    setState(() {
      MyHomePageInheritedWidget.of(context).logic.increment();
    });
  }

  @override
  Widget build(BuildContext context) {

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
            LabelStatelessComponent(),

            // カウンター表示部のコンポーネント
            CounterStatelessComponent(
              parameter: MyHomePageInheritedWidget.of(context).logic.counter,
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
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
    return true;
  }
}

/// MyHomePageのロジッククラス
class PageLogic {
  int _counter;

  PageLogic() {
    clear();
  }

  int get counter => _counter;

  void increment() => _counter++;

  void clear() {
    _counter = 0;
  }
}

/// MyHomePageの Business Logic を提供するコンポーネント
class MyHomePageInheritedWidget extends LogicInheritedWidget {

  final String message = "this is MyPage1InheritedWidget's message.";

  MyHomePageInheritedWidget({
    Key key,
    Widget child
  }) : super(key: key, child: child);

  /// MyHomePageのコンポーネントを取得
  static MyHomePageInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyHomePageInheritedWidget);
  }


  PageLogic get logic =>_myHomePageLogic;

  // MyHomePageのロジック
  final _myHomePageLogic = new PageLogic();
}


/// ラベル表示部のコンポーネント (StatelessWidget)
class LabelStatelessComponent<T> extends StatelessWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;

  LabelStatelessComponent({
    this.parameter,
    this.outerColor = Colors.green,
    this.innerColor = Colors.lightGreen,
    Key key,
  }) :  super(key: key);

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

  CounterStatelessComponent({
    this.parameter,
    this.outerColor = Colors.blue,
    this.innerColor = Colors.lightBlue,
    Key key,
  }) :  super(key: key);

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
    this.outerColor = Colors.green,
    this.innerColor = Colors.lightGreen,
    Key key,
  }) : super(key: key);

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
    this.outerColor = Colors.blue,
    this.innerColor = Colors.lightBlue,
    Key key,
  }) : super(key: key);

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

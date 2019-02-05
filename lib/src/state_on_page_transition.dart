import 'package:flutter/material.dart';
import 'package:basic_of_state_propagation/main.dart' as launcher;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp({ Key key, String })
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Strategy of State Propagation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavigatorPushPage(),
    );
  }
}


/// 第１のページ
class NavigatorPushPage extends StatefulWidget {
  NavigatorPushPage({Key key, this.title = "Navigator Page#1"})
      : super(key: key);

  final String title;

  @override
  _NavigatorPushPageState createState() {
    return _NavigatorPushPageState();
  }
}

class _NavigatorPushPageState extends State<NavigatorPushPage> {
  int _counter = 0;

  _NavigatorPushPageState() : super();

  void _incrementCounter() {
    debugPrint(" \nNavigatorPushPage  _incrementCounter, widget=${widget.hashCode}:${widget.runtimeType.toString()}, _counter=$_counter");
    setState(() {
      _counter++;
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
            LabelStatelessComponent(
                outerColor: Colors.green, innerColor: Colors.lightGreen),

            // カウンター表示部のコンポーネント
            CounterStatelessComponent(
                parameter: _counter,
                outerColor: Colors.blue, innerColor: Colors.lightBlue),

            RaisedButton(
              color: Colors.lightGreenAccent,
              onPressed: () {
                // Navigator．push() 時には、次ページの生成と現ページを含む全ての前ページの再buildが行われます。
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return NavigatorPushPopPage();
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


/// 第２のページ
class NavigatorPushPopPage extends StatefulWidget {
  NavigatorPushPopPage({Key key, this.title: "Navigator Page#2"})
      : super(key: key);

  final String title;

  @override
  _NavigatorPushPopPageState createState() {
    return _NavigatorPushPopPageState();
  }
}

class _NavigatorPushPopPageState extends State<NavigatorPushPopPage> {
  int _counter = 0;

  _NavigatorPushPopPageState() : super();

  void _incrementCounter() {
    debugPrint(" \nNavigatorPushPopPage  _incrementCounter, widget=${widget.hashCode}:${widget.runtimeType.toString()}, _counter=$_counter");
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

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

            // カウンター表示部のコンポーネント
            CounterStatelessComponent(
                parameter: _counter,
                outerColor: Colors.blue, innerColor: Colors.lightBlue),

            RaisedButton(
              color: Colors.lightGreenAccent,
              onPressed: () {
                // Navigator．push() 時には、次ページの生成と現ページを含む全ての前ページの再buildが行われます。
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return NavigatorPopPage();
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


/// 第３のページ
class NavigatorPopPage extends StatefulWidget {
  NavigatorPopPage({Key key, this.title: "Navigator Page#3"})
      : super(key: key);

  final String title;

  @override
  _NavigatorPopPageState createState() {
    return _NavigatorPopPageState();
  }
}

class _NavigatorPopPageState extends State<NavigatorPopPage> {
  int _counter = 0;

  _NavigatorPopPageState() : super();

  void _incrementCounter() {
    debugPrint(" \nNavigatorPopPage  _incrementCounter, widget=${widget.hashCode}:${widget.runtimeType.toString()}, _counter=$_counter");
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

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
                outerColor: Colors.deepPurple, innerColor: Colors.purpleAccent),

            // カウンター表示部のコンポーネント
            CounterStatelessComponent(
                parameter: _counter,
                outerColor: Colors.blue, innerColor: Colors.lightBlue),

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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}



/// ラベル表示部のコンポーネント (StatelessWidget)
class LabelStatelessComponent<T> extends StatelessWidget {
  final T parameter;
  final Color outerColor;
  final Color innerColor;

  LabelStatelessComponent({
    this.parameter,
    @required this.outerColor,
    @required this.innerColor,
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
    @required this.outerColor,
    @required this.innerColor,
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
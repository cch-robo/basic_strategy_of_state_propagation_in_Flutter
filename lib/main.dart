import 'package:flutter/material.dart';
import 'package:basic_of_state_propagation/src/normal_widget_build_flow.dart' as normal_widget_build_flow;
import 'package:basic_of_state_propagation/src/cacheable_widget_build.dart' as cacheable_widget_build;
import 'package:basic_of_state_propagation/src/rebuildable_widget_build.dart' as rebuildable_widget_build;

import 'package:basic_of_state_propagation/src/move_keyless_widget.dart' as move_keyless_widget;
import 'package:basic_of_state_propagation/src/move_keyed_widget.dart' as move_keyed_widget;

import 'package:basic_of_state_propagation/src/use_right_context.dart' as use_right_context;

import 'package:basic_of_state_propagation/src/deep_nested_widget_tree.dart' as deep_nested_widget_tree;
import 'package:basic_of_state_propagation/src/build_splited_by_method.dart' as build_splited_by_method;
import 'package:basic_of_state_propagation/src/build_divided_by_component.dart' as build_divided_by_component;
import 'package:basic_of_state_propagation/src/put_state_to_out.dart' as put_state_to_out;

import 'package:basic_of_state_propagation/src/state_on_page_transition.dart' as state_on_page_transition;
import 'package:basic_of_state_propagation/src/state_hold_on_page_transition.dart' as state_hold_on_page_transition;

import 'package:basic_of_state_propagation/src/final_version.dart' as final_version;
import 'package:basic_of_state_propagation/src/lifecycle_observer.dart' as lifecycle_observer;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Strategy of State Propagation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Basic of State Propagation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.yellowAccent,
        child: SingleChildScrollView(
          controller: new ScrollController(),
          child: Column(
            mainAxisAlignment : MainAxisAlignment.center,
            mainAxisSize : MainAxisSize.max,
            children: <Widget>[

              Container(
                child: SizedBox(height: 20.0, width: double.infinity),
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('normal widget build flow'), width: 200),
                onPressed: () {
                  normal_widget_build_flow.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('cacheable widget build'), width: 200),
                onPressed: () {
                  cacheable_widget_build.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('rebuildable widget build'), width: 200),
                onPressed: () {
                  rebuildable_widget_build.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('move keyless widget'), width: 200),
                onPressed: () {
                  move_keyless_widget.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('move keyed widget'), width: 200),
                onPressed: () {
                  move_keyed_widget.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('use right context'), width: 200),
                onPressed: () {
                  use_right_context.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('deep nested widget tree'), width: 200),
                onPressed: () {
                  deep_nested_widget_tree.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('build splited by method'), width: 200),
                onPressed: () {
                  build_splited_by_method.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('build divided by component'), width: 200),
                onPressed: () {
                  build_divided_by_component.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('put state to out'), width: 200),
                onPressed: () {
                  put_state_to_out.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('state on page transition'), width: 200),
                onPressed: () {
                  state_on_page_transition.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('state hold on page transition'), width: 200),
                onPressed: () {
                  state_hold_on_page_transition.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('final version'), width: 200),
                onPressed: () {
                  final_version.main();
                },
              ),

              RaisedButton(
                color: Colors.white,
                child: Container(child: Text('lifecycle observer'), width: 200),
                onPressed: () {
                  lifecycle_observer.main();
                },
              ),

              Container(
                child: SizedBox(height: 20.0, width: double.infinity),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

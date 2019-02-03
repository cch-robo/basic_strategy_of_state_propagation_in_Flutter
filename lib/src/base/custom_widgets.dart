import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// builder で指定した 子ウイジェットを再描画可能にする Widget
/// 子ウィジェットは、StatelessWidget であっても再描画されます。
/// widget/base.dart の StatefulBuilder の劣化コピーです。
///
/// 【使い方】
/// コンストラクタ引数の builder に「新しい表示のウイジェットを生成するビルド関数」を定義します。
/// コンストラクタ引数の setStateFunc は、利用されません。
///
/// RebuildableWidget = rebuildable;
///   RebuildableWidget(
///     builder: (context, setStateFunc) {
///       return new Text(
///         '$変数',
///         style: Theme.of(context).textTheme.display1,
///       );
///     }
///   );
///
///  rebuildable.rebuild();
class RebuildableWidget extends StatefulWidget {
  RebuildableWidget({
    Key key,
    @required this.builder
  }) : assert(builder != null),
        super(key: key);

  final StatefulWidgetBuilder builder;

  final Holder<RebuildableWidgetState> _state = new Holder<RebuildableWidgetState>();
  void rebuild() {
    if (_state.object == null) return;
    _state.object.rebuild();
  }

  @override
  RebuildableWidgetState createState() {
    RebuildableWidgetState state = RebuildableWidgetState();
    _state.object = state;
    return state;
  }
}

class RebuildableWidgetState extends State<RebuildableWidget> {
  /// 再描画
  void rebuild(){
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState);
  }
}


/// builder で指定した 子ウイジェットをキャッシュして不変(再描画させない)にする Widget
/// Widgetツリー再構築の build(context) が発生して ConstantWidget が新規再生成されても、
/// builder　で指定された 子ウィジェットは、再生成(再描画)されません。
///
/// 【使い方】
/// コンストラクタ引数の builder に「表示不変のウイジェットを生成するビルド関数」を定義します。
/// コンストラクタ引数の setStateFunc は、利用されません。
///
/// ConstantWidget = constant;
///   ConstantWidget(
///     builder: (context, setStateFunc) {
///       return new Text(
///         'Hello',
///         style: Theme.of(context).textTheme.display1,
///       );
///     }
///   );
///
class ConstantWidget extends StatefulWidget {
  ConstantWidget({
    Key key,
    @required this.builder
  }) : assert(builder != null),
        super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  ConstantWidgetState createState() {
    return ConstantWidgetState();
  }
}

class ConstantWidgetState extends State<ConstantWidget> {
  Widget _cachedWidget;
  Widget get cachedWidget => _cachedWidget;

  @override
  Widget build(BuildContext context) {
    if (_cachedWidget == null) {
      _cachedWidget = widget.builder(context, setState);
    }
    return _cachedWidget;
  }
}


class Holder<T extends Object> {
  T object;
  Holder([T obj]) : this.object = obj;
}

class PairHolder<F extends Object, S extends Object> {
  F first;
  S second;

  PairHolder([F first, S second]) :
        this.first = first,
        this.second = second;
}

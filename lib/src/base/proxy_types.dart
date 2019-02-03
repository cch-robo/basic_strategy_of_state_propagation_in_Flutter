import 'dart:core';
import 'package:flutter/material.dart';


/// プロキシクラス
///
/// 任意クラス型のオブジェクトの指定メソッドの実行実態を置換可能にします。
/// また、アスペクト指向プログラミング視点から、
/// メソッド実行時に横断的関心事処理を追加することもできます。
class Proxy<T> {

  /// 適用可否 （プロキシによるメソッド置換可否）
  bool _isApply = true;

  /// （グローバル）メソッド実行横断的関心事対応
  static MethodAspect _globalMethodAspect = new MethodAspect();

  /// （ローカル）メソッド実行横断的関心事対応
  MethodAspect _localMethodAspect;

  /// ソースオブジェクト
  T _source;

  /// プロキシするメソッド
  Map<Symbol, Function> _proxyMethods;

  /// メソッド・プロキシ生成コンストラクタ
  Proxy.create(T source, Map<String, Function> methods) {
    if (source == null) throw AssertionError("set method's argument 'source' is must not a null.");
    Map<Symbol, Function> proxyMethods = new Map<Symbol, Function>();
    if (methods != null) {
      methods.forEach((String name, Function method){
        proxyMethods[new Symbol(name)]= method;
      });
    }
    this._source = source;
    this._proxyMethods = proxyMethods;
  }

  /// プロキシにメソッドの（グローバル）横断的関心事処理を設定
  static void setGlobalAop({
    bool isAop = false,
    void Function(dynamic work) initFunc,
    void Function(Invocation invocation, dynamic work) beforeFunc,
    void Function(Invocation invocation, dynamic result, dynamic work) afterFunc,
    bool Function(dynamic error) errorHandling}) {
    _globalMethodAspect.isApply = isAop;
    _globalMethodAspect.initFunction = initFunc;
    _globalMethodAspect.beforeFunction = beforeFunc;
    _globalMethodAspect.afterFunction = afterFunc;
    _globalMethodAspect.errorHandling= errorHandling;
  }

  /// プロキシにメソッドの（ローカル）横断的関心事処理を設定
  Proxy<T> setLocalAop({
        bool isAop = false,
        void Function(dynamic work) initFunc,
        void Function(Invocation invocation, dynamic work) beforeFunc,
        void Function(Invocation invocation, dynamic result, dynamic work) afterFunc,
        bool Function(dynamic error) errorHandling}) {
    _localMethodAspect = new MethodAspect(
        isApply: isAop,
        initFunc: initFunc,
        beforeFunc: beforeFunc,
        afterFunc: afterFunc,
        errorHandling: errorHandling);
    return this;
  }

  /// ソース・オブジェクト取得
  T get source => _source;

  /// メソッド・プロキシされたオブジェクトを取得
  /// プロキシ指定がない場合は、ソース・オブジェクトを返します。
  dynamic get proxy => _isApply ? this : this._source;

  /// （グローバル）メソッド実行横断的関心事対応
  static MethodAspect get globalAop => Proxy._globalMethodAspect;

  /// （ローカル）メソッド実行横断的関心事対応
  MethodAspect get localAop => _localMethodAspect;

  /// プロキシ適用可否 （プロキシによるメソッド置換可否）
  set isProxy (bool isProxy) {
    _isApply = isProxy;
  }


  @override
  dynamic noSuchMethod(Invocation invocation) {
    // 未実装だが想定されたメソッドのハンドリング実装についてのドキュメント参照先
    // Emulating Functions in Dart > Interactions with mirrors and noSuchMethod()
    // https://www.dartlang.org/articles/language/emulating-functions#interactions-with-mirrors-and-nosuchmethod
    if ((invocation.isMethod || invocation.isGetter || invocation.isSetter) && _proxyMethods.containsKey(invocation.memberName)) {

      // 横断的関心事の処理先取得
      MethodAspect aop = _localMethodAspect != null && _localMethodAspect._isApply ? _localMethodAspect
          : Proxy._globalMethodAspect != null && Proxy._globalMethodAspect._isApply ? Proxy._globalMethodAspect
          : null;

      dynamic result;
      if (aop != null) {
        // 横断的関心事を伴ったメソッド実行
        result = aop.execute(_proxyMethods[invocation.memberName], invocation);

      } else {
        // 横断的関心事を伴わないメソッド実行
        result = Function.apply(
            _proxyMethods[invocation.memberName],
            invocation.positionalArguments,
            invocation.namedArguments);
      }
      return result;
    }
    return super.noSuchMethod(invocation);
  }
}


/// メソッド・アスペクト
/// アスペクト指向プログラミングの視点で、
/// メソッド実行前後に任意の横断的関心事を設定します。
class MethodAspect {
  /// 適用可否
  bool _isApply;

  /// 横断的関心事処理にわたる作業用汎用オブジェクト（実行時間差分計算などに利用ください）
  dynamic _work;

  /// 横断的関心事にわたる作業の初期化処理
  void Function(dynamic work) _initFunction;

  /// メソッド実行前の横断的関心事処理
  void Function(Invocation invocation, dynamic work) _beforeFunction;

  /// メソッド実行後の横断的関心事処理
  void Function(Invocation invocation, dynamic result, dynamic work) _afterFunction;

  /// メソッド実行例外の横断的関心事処理 （trueを返すとエラーをrethrowします）
  bool Function(dynamic error) _errorHandling;


  /// 適用可否
  set isApply (bool isApply) {
    _isApply = isApply;
  }

  /// 横断的関心事にわたる作業の初期化処理
  set initFunction (void Function(dynamic work) initFunction){
    _initFunction = initFunction;
  }

  /// メソッド実行前の横断的関心事処理
  set beforeFunction (void Function(Invocation invocation, dynamic work) beforeFunction){
    _beforeFunction = beforeFunction;
  }

  /// メソッド実行後の横断的関心事処理
  set afterFunction (void Function(Invocation invocation, dynamic result, dynamic work) afterFunction){
    _afterFunction = afterFunction;
  }

  /// メソッド実行例外の横断的関心事処理 （trueを返すとエラーをrethrowします）
  set errorHandling (bool Function(dynamic error) errorHandling) {
    _errorHandling = errorHandling;
  }

  /// 横断的関心事処理をクリア
  void clear() {
    isApply =false;
    initFunction = null;
    beforeFunction = null;
    afterFunction = null;
    errorHandling = null;
  }


  MethodAspect({
    bool isApply = false,
    void Function(dynamic work) initFunc,
    void Function(Invocation invocation, dynamic work) beforeFunc,
    void Function(Invocation invocation, dynamic result, dynamic work) afterFunc,
    bool Function(dynamic error) errorHandling,
  }):   _isApply = isApply,
        _initFunction = initFunc,
        _beforeFunction = beforeFunc,
        _afterFunction = afterFunc,
        _errorHandling = errorHandling {
    if(_isApply && _initFunction != null) _initFunction(_work);
  }

  /// 横断的関心事を伴ったメソッド実行
  ///
  /// 未実装だが想定されたメソッドのハンドリングからの呼び出しを想定しています。
  /// Emulating Functions in Dart > Interactions with mirrors and noSuchMethod()
  /// https://www.dartlang.org/articles/language/emulating-functions#interactions-with-mirrors-and-nosuchmethod
  dynamic execute(Function method, Invocation invocation) {
    try{
      // 横断的関心事の前処理実行
      if (_isApply && _beforeFunction != null) _beforeFunction(invocation, _work);

      // メソッドの実行
      dynamic result = Function.apply(
          method,
          invocation.positionalArguments,
          invocation.namedArguments);

      // 横断的関心事の後処理実行
      if (_isApply && _afterFunction != null) _afterFunction(invocation, result, _work);

      return result;

    } catch(error) {
      // エラー出力
      debugPrint('Something went wrong.');
      debugPrint("  type ⇒ ${error?.runtimeType??''}");
      debugPrint("  error ⇒ {\n${error?.toString()??''}\n}");
      if (error is Error) {
        debugPrint("  stacktrace ⇒ {\n${error?.stackTrace??''}\n}");
      }

      // 横断的関心事の例外ハンドラ実行
      if (_isApply && _errorHandling != null) {
        bool isRethrow = _errorHandling(error);
        if (isRethrow) rethrow;
      }
    }
  }
}

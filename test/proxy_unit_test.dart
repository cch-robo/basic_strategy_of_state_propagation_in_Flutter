import 'package:meta/meta.dart';
import 'package:test/test.dart';
import 'package:basic_of_state_propagation/src/base/proxy_types.dart';

/// ロジックを操作する単体テスト
///
/// 単体テストを行えるようにするには、
/// pubspec.yaml に、以下の依存設定が必要です。
///
/// dev_dependencies:
///  flutter_test:
///    sdk: flutter
///
///   test: ^1.5.1

void main() {
  test_1();
  test_2();
  test_3();
  test_4();
}

void test_1 () {
  /// テストするクラスを設定
  Counter sample;

  /// 初期設定実行
  setUp((){
    sample = Counter(42);
  });

  /// test() は、test.dart パッケージの組み込み関数
  /// test() は、端末実行(画面出力や入力)なしで、
  /// 直接 オブジェクトの状態や入力操作＆出力反応の確認ができるようにします。
  test('my 1th unit test', () {
    expect(sample.value, 42);
    sample.increments;
    expect(sample.value, 43);
  });
}

void test_2 () {
  /// テストするクラスを設定
  Counter sample;
  Proxy<Counter> proxy;

  /// 初期設定実行
  setUp((){
    sample = Counter(42);

    // プロキシで、increments メソッド等実行前後に横断的関心事を追加
    proxy = new Proxy<Counter>.create(sample, {
        "increments": () => sample.increments,
        "decrements": () => sample.decrements,
        "add": (int p) => sample.add(p),
        "sub": (int p) => sample.sub(p),
      }).setLocalAop(
          isAop: true,
          beforeFunc: (Invocation invocation, dynamic work){print("before value=${sample._value}, ${invocation.memberName}");},
          afterFunc: (Invocation invocation, dynamic result, dynamic work){print("after result=${result}");}
        );
  });

  test('my 2th proxy unit test', () {
    // プロキシでAOPできることを確認
    expect(proxy.source.value, 42);
    proxy.proxy.increments;
    expect(proxy.source.value, 43);
    proxy.proxy.decrements;
    expect(proxy.source.value, 42);
    proxy.proxy.add(10);
    expect(proxy.source.value, 52);
    proxy.proxy.sub(10);
    expect(proxy.source.value, 42);
  });
}

void test_3 () {
  /// テストするクラスを設定
  Counter sample;
  Proxy<Counter> proxy;

  /// 初期設定実行
  setUp((){
    sample = Counter(1);

    // プロキシで、increments メソッドを強制置換
    proxy = new Proxy<Counter>.create(sample,
        {
          "increments": () {
            return sample._value += 2; // ＋２にする。
          }
        })
        .setLocalAop(isAop: false);
  });

  test('my 3th proxy unit test', () {
    // プロキシでメソッド実態が置換できることを確認
    expect(proxy.source.value, 1);
    proxy.proxy.increments;
    expect(proxy.source.value, 3);
    expect(proxy.proxy.increments, 5);
  });
}

void test_4 () {
  /// テストするクラスを設定
  Work work;
  dynamic proxy;

  /// 初期設定実行
  setUp((){
    work = new Work(useProxy: false);
    proxy = new Work(useProxy: true);
  });

  test('my 4ht proxy unit test', () {
    // オリジナルとプロキシでソース変更なく利用できることを確認
    expect(work.countUp(from: 1, to: 10), 11);
    expect(proxy.countUp(from: 1, to: 10), 11);
  });
}


/// サンプルクラス
/// テストする関数と値を提供します。
class Counter {
  int _value;
  Counter([this._value = 0]);

  int add(int param) {
    return _value += param;
  }

  int sub(int param) {
    return _value -= param;
  }

  void set value(int param) => _value = param;
  int get value => _value;
  int get increments => ++_value;
  int get decrements => --_value;
}

/// 条件付きで、オリジナルと Proxy を差替られるようにしたクラス
class Work {
  // オリジナルとProxyで共用するため dynamic にする必要がある。
  dynamic _counter;

  Work({ @required bool useProxy}) {
    Counter source = new Counter();
    _counter = useProxy ? factory(source).proxy : source;
  }

  Proxy<Counter> factory(Counter source) {
    Proxy<Counter> proxy = Proxy<Counter>
        .create(source, {
          "increments": () => source.increments,
          "value=": (int p) => source.value = p,
          "value": () => source.value,
        })
        .setLocalAop(
          isAop: true,
          beforeFunc: (Invocation invocation, dynamic work) {
            if (invocation.memberName != Symbol("increments")) return;
            print("before countUp value=${source.value}");
          },
          afterFunc: (Invocation invocation, dynamic result, dynamic work) {
            if (invocation.memberName != Symbol("increments")) return;
            print("after  countUp value=${source.value}");
          }
        );
    return proxy;
  }

  /// カウントアップするだけのメソッド
  /// 内部実装的には、オリジナルも Proxy でもソース変更の必要がありません。
  int countUp({ @required int from, @required int to}) {
    _counter.value = from;
    for(int i = from; i <= to; i++) {
      _counter.increments;
    }
    return _counter.value;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 1.创建自己需要共享的数据
/// 2.在应用程序的顶层ChangeNotifierProvider
/// 3.在其它位置使用共享的数据
///  > Provider.of: 当Provider中的数据发生改变时, Provider.of所在的Widget整个build方法都会重新构建
///  > Consumer(相对推荐): 当Provider中的数据发生改变时, 执行重新执行Consumer的builder
///  > Selector: 1.selector方法(作用,对原有的数据进行转换) 2.shouldRebuild(作用,要不要重新构建)

class MyCounterViewModel extends ChangeNotifier {
  int _counter = 100;

  int get counter => _counter;

  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}

class ProviderPage extends StatefulWidget {
  ProviderPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MyCounterViewModel(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                MyText1(),
                MyText2()
              ],
            ),
          ),
          floatingActionButton:
              Selector<MyCounterViewModel, MyCounterViewModel>(
            selector: (ctx, counterVM) => counterVM,
            shouldRebuild: (prev, next) => false,
            builder: (ctx, counterVM, child) {
              print("floatingActionButton build方法被执行");
              return FloatingActionButton(
                child: child,
                onPressed: () {
                  counterVM.counter += 1;
                },
              );
            },
            child: Icon(Icons.add),
          )
          // floatingActionButton: Consumer<MyCounterViewModel>(
          //   builder: (ctx, counterPro, child) {
          //     return FloatingActionButton(
          //       child: child,
          //       onPressed: () {
          //         counterPro.counter += 1;
          //       },
          //     );
          //   },
          //   child: Icon(Icons.add),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}

class MyText1 extends StatefulWidget {
  @override
  MyText1State createState() {
    return MyText1State();
  }
}

class MyText1State extends State<MyText1> {
  @override
  Widget build(BuildContext context) {
    print("build");
    int counter = Provider.of<MyCounterViewModel>(context).counter;
    return Container(
      color: Colors.blue,
      child: Text(
        "当前计数: $counter",
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("依赖改变了");
  }
}

class MyText2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int counter = Provider.of<MyCounterViewModel>(context).counter;

    return Container(
      color: Colors.blue,
      child: Consumer<MyCounterViewModel>(
        builder: (ctx, counterVM, child) {
          print("MyText2 Consumer build方法被执行");
          return Text(
            "当前计数: ${counterVM.counter}",
            style: TextStyle(fontSize: 30),
          );
        },
      ),
    );
  }
}

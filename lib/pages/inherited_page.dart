import 'package:flutter/material.dart';

class MyCounterWidget extends InheritedWidget {
  // 1.共享的数据
  final int counter;

  // 2.定义构造方法
  MyCounterWidget({this.counter, Widget child}) : super(child: child);

  // 3.获取组件最近的当前InheritedWidget
  static MyCounterWidget of(BuildContext context) {
    // 沿着Element树, 去找到最近的CounterElement, 从Element中取出Widget对象
    return context.dependOnInheritedWidgetOfExactType<MyCounterWidget>();
  }

  // 4.决定要不要回调State中的didChangeDependencies
  // 如果返回true: 执行依赖当期的InheritedWidget的State中的didChangeDependencies
  @override
  bool updateShouldNotify(MyCounterWidget oldWidget) {
    return oldWidget.counter != counter;
  }
}

class InheritedPage extends StatefulWidget {
  InheritedPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InheritedPageState createState() => _InheritedPageState();
}

class _InheritedPageState extends State<InheritedPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCounterWidget(
      counter: _counter,
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
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
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
    int counter = MyCounterWidget.of(context).counter;
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
    int counter = MyCounterWidget.of(context).counter;
    return Container(
      color: Colors.blue,
      child: Text(
        "当前计数: $counter",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}

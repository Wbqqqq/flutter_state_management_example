import 'package:flutter/material.dart';
import 'package:state_management_example/pages/inherited_page.dart';
import 'package:state_management_example/pages/provider_page.dart';

import 'pages/simple_provider_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List stateManagementList = [
    "InheritedWidget",
    "SimpleProvider",
    "Provider",
    "fish_redux",
    "flutter_bloc"
  ];

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
        routes: {
          '/InheritedWidget': (BuildContext context) =>
              InheritedPage(title: "InheritedWidget"),
          '/SimpleProvider': (BuildContext context) => ProviderRoute(),
          '/Provider': (BuildContext context) => ProviderPage(title: "Provider")
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('State Manager'),
            ),
            body: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemCount: stateManagementList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/${stateManagementList[index]}');
                  },
                  child: ListTile(
                    title: Text("${stateManagementList[index]}"),
                  ),
                );
              },
            )));
  }
}

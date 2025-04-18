import 'package:flutter/material.dart';

class  MyAppBar extends StatelessWidget {
    const MyAppBar
        ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("APP_02"),
        backgroundColor: Colors.redAccent,
        elevation: 4,
        actions:[
          IconButton(onPressed: () {
            print("b1");
          },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {
            print("b2");
          },
              icon: Icon(Icons.abc)),
          IconButton(onPressed: () {
            print("b3");
          },
              icon: Icon(Icons.more_vert)),
        ]
      ),

      backgroundColor: Colors.white60,
      body: Center(child: Text("Noi Dung"),),

      floatingActionButton: FloatingActionButton(
          onPressed: (){print("pressed");},
          child: const Icon(Icons.add_ic_call)
      ),

      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang Chu"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tim Kiem"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Ca Nhan"),
      ]),
    );
  }
}
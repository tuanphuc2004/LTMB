import 'package:flutter/material.dart';

class  MyContainer extends StatelessWidget {
    const MyContainer
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

      body: Center(
          child:  Container(
            width:  200,
            height: 200,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                color: Colors.orange.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
                )
              ]
            ),
            child: Align(
              alignment: Alignment.center,
              child: const Text("Hoang Tuan Phuc",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                ),
              ),
            ),
          )
      ),


      backgroundColor: Colors.white60,


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
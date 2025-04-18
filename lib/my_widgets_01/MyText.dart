import 'package:flutter/material.dart';

class  MyText extends StatelessWidget {
    const MyText
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

      body: Center(child: Column(
          children: [
          const SizedBox(height: 50,),
          const Text("Hoang Tuan Phuc"),
          const SizedBox(height: 20,),


          const Text(
            "Xin Chao Moi nguoi",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                letterSpacing: 1.5,
              ),
            ),


          const SizedBox(height: 20,),
            const Text(
              "Flutter la mot SDK phat trien ung dung di dong",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                letterSpacing: 1.5,
              ),
            ),
          ]
        ),
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
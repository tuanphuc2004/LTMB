import 'package:flutter/material.dart';

class  MyButton extends StatelessWidget {
  const MyButton
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
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: (){print("ElevatedButton");},
              child: Text("ElevatedButton", style: TextStyle(fontSize: 24),),
            ),

            SizedBox(height: 20,),
            TextButton(
              onPressed: (){print("TextButton");},
              child: Text("TextButton", style: TextStyle(fontSize: 24),)
            ),

            SizedBox(height: 20,),
            OutlinedButton(
                onPressed: (){print("OutlinedButton");},
                child: Text("OutlinedButton", style: TextStyle(fontSize: 24),)
            ),

            SizedBox(height: 20,),
            IconButton(
                onPressed: (){print("IconButton");},
                icon: Icon(Icons.favorite)
            ),

            SizedBox(height: 20,),
            FloatingActionButton(
                onPressed: (){print("FloatingActionButton");},
                child: Icon(Icons.add)
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
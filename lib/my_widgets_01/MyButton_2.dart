import 'package:flutter/material.dart';

class  MyButton2 extends StatelessWidget {
  const MyButton2
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
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: (){print("ElevatedButton");},
              child: Text("ElevatedButton", style: TextStyle(fontSize: 24),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,

                foregroundColor: Colors.black,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10),

                elevation: 15,
              ),
            ),

            SizedBox(height: 20),
            OutlinedButton(
              onPressed: (){print("OutlinedButton");},
              child: Text("OutlinedButton", style: TextStyle(fontSize: 24),),
              style: ElevatedButton.styleFrom(

                foregroundColor: Colors.blue,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10),


              ),

            ),

            SizedBox(height: 50),
            InkWell(
              onTap: (){print("InkWell được nhấn");},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: Text("Button tuy chinh voi InkWell"),

              )
            )


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
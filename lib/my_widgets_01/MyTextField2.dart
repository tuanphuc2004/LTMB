import 'package:flutter/material.dart';

class MyTextField2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyTextField2State();

}

class _MyTextField2State extends State<MyTextField2>{
  final _textContronller = TextEditingController();
  String _inputText = "";

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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(child: Column(
            children: [
              SizedBox(height: 50),
              TextField(
                controller: _textContronller,
                decoration: InputDecoration(
                  labelText: "Nhập Thông Tin",
                  hintText: "Thông Tin Của Bạn",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton.outlined(
                      onPressed: (){
                        _textContronller.clear();
                      },
                      icon: Icon(Icons.clear)
                  )
                ),
                onChanged: (value){
                  setState(() {
                    _inputText = value;
                  });
                }
              ),

              SizedBox(height: 50),
              Text('Bạn Đã Nhập: $_inputText', style: TextStyle(fontSize: 20),)
            ],
          )
        ),
      )
    );


  }

}
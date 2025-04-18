import 'package:flutter/material.dart';

class  MyTextField extends StatelessWidget {
  const MyTextField
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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  labelText: "Họ Và Tên",
                  hintText: "Nhập Họ Và Tên",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),

                )
              ),

              SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Example@gmail.com",
                  helperText: "Nhập Email Cá Nhân",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.clear),
                  filled: true,
                  fillColor: Colors.grey,
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  labelText: "Số điện thoại",
                  hintText: "Nhập vào số điện thoại",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: Icon(Icons.clear),

                ),
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  labelText: "Ngày Sinh",
                  hintText: "Nhập Ngày Sinh Của bạn",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.date_range),
                  suffixIcon: Icon(Icons.clear),

                ),
                keyboardType: TextInputType.datetime,
              ),

              SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  labelText: "Mật Khẩu",
                  hintText: "Nhập Mật Khẩu",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),

                ),
                obscureText: true,
                obscuringCharacter: "*",
              ),

              SizedBox(height: 50),
              TextField(
                onSubmitted: (value){
                  print("Đã Hoàn Thành Nội Dung: $value");
                },
                decoration: InputDecoration(
                  labelText: "Câu Hỏi Bí Mật",
                  hintText: "Nhập Nội Dung",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),

                ),
              ),
            ]
          )
        )
      ),



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
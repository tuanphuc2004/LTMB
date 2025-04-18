import 'package:flutter/material.dart';

class MyStatelessWidget extends StatelessWidget{
  final String title;
  
  MyStatelessWidget({required this.title});

  @override
  Widget build(BuildContext context) {
   
    return Text(title);
  }
  
}


class MyStatefulWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _MystatefulWidget ();

}

class _MystatefulWidget extends State<MyStatefulWidget> {
  String title = 'hello, Flutter!';

  void _updatetitle(){
    setState(() {
      title = 'Title Update';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title),
        ElevatedButton(onPressed: _updatetitle, child: Text('Update Title'))
      ],
    );
  }

}

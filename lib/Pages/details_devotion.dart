import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final List list;
  final int index;
  DetailPage({@required this.list, @required this.index});
 

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
              child: ListView(
        children: [
          SizedBox(height: 15.0),
          Column(
            children: [
              Center(
                child: Text(
                  widget.list[widget.index]['date'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                 widget.list[widget.index]['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, ))
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            widget.list[widget.index]['text_quote'],
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textDirection: TextDirection.ltr,
          ),
          SizedBox(height: 10.0,),
          Card(
              elevation: 20,
              child: ListTile(
                title: Text(
                 widget.list[widget.index]['text_to_read'],
                  style: TextStyle(fontSize: 20.0, height: 1.5, letterSpacing: 1.0),
                ),
              )),
          SizedBox(height: 20.0),
          Text(
            "Things to note:",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textDirection: TextDirection.ltr,
          ),
           SizedBox(height: 10.0,),
          Card(
              elevation: 20,
              child: ListTile(
                title: Text(
                  widget.list[widget.index]['things_to_note'],
                  style: TextStyle(fontSize: 20.0, height: 1.5, letterSpacing: 1.0),
                ),
              )),

                SizedBox(height: 20.0),
          Text(
            "Things to do:",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textDirection: TextDirection.ltr,
          ),
           SizedBox(height: 10.0,),
          Card(
              elevation: 20,
              child: ListTile(
                title: Text(
                 widget.list[widget.index]['things_to_do'],
                  style: TextStyle(fontSize: 20.0, height: 1.5, letterSpacing: 1.0 ),
                ),
              )),
                SizedBox(height: 20.0),
          Text(
            "Declare:",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textDirection: TextDirection.ltr,
          ),
           SizedBox(height: 10.0,),
          Card(
              elevation: 20,
              child: ListTile(
                title: Text(
                  widget.list[widget.index]['declaration'],
                  style: TextStyle(fontSize: 20.0, height: 1.5, letterSpacing: 1.0),
                ),
              )),
              SizedBox(height:20.0),
               Text(
           widget.list[widget.index]['reading'],
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textDirection: TextDirection.ltr,
          ),

              SizedBox(height:80.0),
              
        ],
      ))),
    );
  }
}

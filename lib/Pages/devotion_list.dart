import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmdd_application/Pages/details_devotion.dart';

class DevotionList extends StatefulWidget {
  DevotionList({Key key}) : super(key: key);

  @override
  _DevotionListState createState() => _DevotionListState();
}

class _DevotionListState extends State<DevotionList> {
  Future<List> getDevotion() async {
    var url = "http://devotion.banjoadedokunandco.com/api/getdevotion.php";
    var response = await http.post(url);

    var resBodyID = json.decode(response.body);
    return resBodyID;
  }

  @override
  void initState() {
    super.initState();
    getDevotion();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("RMDD", style:TextStyle(color:Colors.black))),
            backgroundColor: Colors.white,
            actions: [
               IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () {
                 Navigator.pop(context);
            },
          ), //IconButton
            ],
            
          ),
          body: FutureBuilder(
            future: getDevotion(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List snap = snapshot.data;

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Error Fetching Data"),
                );
              }

              return ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    list: snap,
                                    index: index,
                                    
                                  )));
                        },
                        child: Card(
                          elevation: 20,
                          child: ListTile(
                            title: Text(
                              snap[index]["title"],
                              style: GoogleFonts.alike(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              snap[index]["date"],
                              style: GoogleFonts.acme(),
                            ),
                            leading: new Icon(Icons.bookmark),
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ));
  }
}

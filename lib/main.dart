

import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_samples/fetch_data/photo.dart';
import 'package:http/http.dart' as http;
import './Components/DetailPage.dart';
import './Components/MovieDetail.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),

      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: searchMovie(), // MyHomePage(title: 'Make Notes'),
    );
  }
}

class searchMovie extends StatefulWidget {
  @override
  _searchMovieDataState createState() => _searchMovieDataState();
}

class _searchMovieDataState extends State<searchMovie> {
  List<MovieDetail> list = List();
  AllDetail details;
  var isLoading = false;
  final textFieldController = TextEditingController();

  _fetchData() async {
    // print("fetch fetch fetch");
    String name = textFieldController.text;

    setState(() {
      isLoading = true;
    });

    //  https://jsonplaceholder.typicode.com/photos
    //    http://www.omdbapi.com/?s=$name&apikey=9da2e896
    //  http://www.omdbapi.com/?t=$name&plot=full&apikey=9da2e896
    final response =
        await http.get("http://www.omdbapi.com/?s=$name&apikey=9da2e896");
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json is Map) {
        final jsonSearch = json["Search"];
        if (jsonSearch is List) {
          list =
              jsonSearch.map((data) => new MovieDetail.fromJson(data)).toList();
        }
      }

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  _getOtherDetailsAndNavigate(index) async {
    String name = textFieldController.text;
    final response = await http
        .get("http://www.omdbapi.com/?t=${list[index].title}&apikey=9da2e896");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json is Map) {
        details = AllDetail.fromJson(json);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailPage(data: list[index], details: details)));
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon app",
      home: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text("Search Movies"),
          elevation: 0.3,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                      child: TextFormField(
                          controller: textFieldController,
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (text) {
                            print(text + "submitted");
                            _fetchData();
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(),
//                              border: OutlineInputBorder(),

                              hintText: 'Details'))
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 8),
                    child: Container(
                      height: 40,
                      child: IconButton(
                        color: Color.fromRGBO(58, 66, 86, 1.0),
//                        child: Text("Search", style: TextStyle(color: Colors.white, fontSize: 18),),
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _fetchData();
                        },
                      ),
                    )),
              ],
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(64, 75, 96, .9)),
                                child: ListTile(
                                  onTap: () {
                                    _getOtherDetailsAndNavigate(index);
                                  },
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 20.0),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.white, size: 30.0),
                                  leading: Container(
                                    padding: EdgeInsets.only(right: 30.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(
                                                width: 1.0,
                                                color: Colors.green))),
                                    child: Image.network(
                                      list[index].thumbnailUrl,
                                      fit: BoxFit.cover,
                                      height: 60.0,
                                      width: 50,
                                    ), //Icon(Icons.autorenew, color: Colors.white),
                                  ),
                                  title: Column(
                                    children: [
//                              Image.network(
//                                list[index].thumbnailUrl,
//                                fit: BoxFit.cover,
//                                height: 60.0,
//
//                              ),
                                      Text(
                                        list[index].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

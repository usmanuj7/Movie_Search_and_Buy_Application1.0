
import 'package:flutter/material.dart';
import './MovieDetail.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {


  final MovieDetail data;
   AllDetail details;




  DetailPage({Key key , this.data, this.details }) : super(key: key);
  @override

  Widget build(BuildContext context) {

    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 99.22,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(

        // "\$20",
        "\$200" ,//+ 'lesson.price.toString()',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText =SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        SizedBox(height: 100.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Icon(

            Icons.movie,
            color: Colors.white,
            size: 25.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Container(
            width: 90.0,
            child: new Divider(color: Colors.green),
          ),
        ),
//        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Text(
            data.title,
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
        ),

//        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex:3,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(

                     data.type,
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 2, child: coursePrice)
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 1, child: levelIndicator),
              Expanded(
                  flex:3,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(

                        details.ratting,
                        style: TextStyle(color: Colors.white),
                      ))),

            ],
          ),
        ),



        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex:5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(

                      data.year,
                      style: TextStyle(color: Colors.white),
                    ))),

          ],
        ),


      ],
    ),
    );


    final topContent =  SingleChildScrollView( child:  Stack(
      children: <Widget>[
//        Container(
//            padding: EdgeInsets.only(left: 10.0),
//            height: MediaQuery.of(context).size.height * 0.5,
//            decoration: new BoxDecoration(
//
//              image: new DecorationImage(
//                image: ,
//
//
//
//                fit: BoxFit.cover,
//              ),
//            )),

    Padding(
     padding: EdgeInsets.only(left: 1.0),
      child: Image.network(
      data.thumbnailUrl,
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height * 0.5,
   ),
    ),

        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.fromLTRB(40, 40, 40, 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 50,
          child: InkWell(
            onTap: () {
             details.URL = "";
             details.plot= "";
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    ),);


    final bottomContentText = SingleChildScrollView( child: Text(
       data.title + ". It is a very interisting movie " +details.plot ,
      style: TextStyle(fontSize: 15.0),
    ),
    );

    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () {
            if (details.URL != null){
              print(details.URL);
              launch(details.URL);
            }
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
          Text("Purchase this movie", style: TextStyle(color: Colors.white)),
        ));

    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );


    return Scaffold(
      body: SingleChildScrollView(
        child:
      Column(
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }
}
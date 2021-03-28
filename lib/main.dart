import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies_list/post.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Movies'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<dynamic>(
        future: fetchPosts(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            final posts = snapshot.data;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx,index){
                final post = posts[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child:Row(
                      children:[
                        SizedBox(
                          height: 100,
                          child:Image.network(post.image)
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:2),

                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(child: Text(post.title, textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(child: Text('Release on: ${post.releaseYear}', textAlign: TextAlign.center,style: TextStyle(color: CupertinoColors.inactiveGray),)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(child: Text('Rating: ${post.rating}', textAlign: TextAlign.center,style: TextStyle(color: CupertinoColors.inactiveGray),)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(post.genre.toString(), textAlign: TextAlign.start,),
                          ),
                        ],
                      )],
                    )
                  ),
                );
              },
            );

          } else if (snapshot.hasError){
            return Center(
              child:Text(snapshot.error.toString())
            );
          }else

          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )

    );
  }
}
Future<List<Post>> fetchPosts() async{
  final response = await http.get('https://api.androidhive.info/json/movies.json');
  if(response.statusCode == 200){
    print(response.body);
    return postFromJson(response.body);
  }else{
    throw Exception('FAILED TO LOAD POST');
  }

}
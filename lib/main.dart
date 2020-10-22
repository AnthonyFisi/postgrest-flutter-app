import 'package:flutter/material.dart';
import 'package:flutter_postgrest/todosModel.dart';
import 'package:flutter_postgrest/todosRepository.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PostgREST Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo with PostgREST'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //todosRepository _repository = new todosRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<List<todos>>(
            future: fetchtodosModel(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Text(snapshot.data[index].id.toString() +
                          ' - ' +
                          snapshot.data[index].task);
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Text('Loading...');
            },
          ),
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

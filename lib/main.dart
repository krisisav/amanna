import 'package:amanna/api/api.dart';
import 'package:amanna/database/database.dart';
import 'package:amanna/models/tags.dart';
import 'package:amanna/repositories/db_quote_repository.dart';
import 'package:amanna/repositories/quote_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<API>(API());
  getIt.registerSingleton<DatabaseProvider>(DatabaseProvider());
  getIt.registerSingleton<QuoteRepository>(DbQuoteRepository());
  getIt.registerSingletonAsync<List<Tag>>(() async => Tags().tags);
}

void main() {
  setupGetIt();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amanna',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: FutureBuilder<List<Tag>>(
        future: getIt.getAsync<List<Tag>>(),
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return MyHomePage(snapshot.data!);
        }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Tag> tags;

  MyHomePage(this.tags);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AMANNA'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: widget.tags.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Text(widget.tags[index].name),
          );
        },
      ),
    );
  }
}

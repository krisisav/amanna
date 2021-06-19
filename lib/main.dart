import 'package:amanna/models/tag.dart';
import 'package:amanna/services/get_it_setup.dart';
import 'package:flutter/material.dart';

import 'api/api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
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
        future: getIt.get<API>().getTags(),
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

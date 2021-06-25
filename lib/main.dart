import 'package:amanna/models/tag.dart';
import 'package:amanna/screens/home_page.dart';
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

          return HomePage(snapshot.data!);
        }
      ),
    );
  }
}

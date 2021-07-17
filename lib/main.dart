import 'package:amanna/models/tag.dart';
import 'package:amanna/repositories/tag_repository.dart';
import 'package:amanna/screens/home_page.dart';
import 'package:amanna/services/get_it_setup.dart';
import 'package:amanna/sync/tag_synchronizer.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  getIt.get<TagSynchronizer>().saveTagsToDatabase().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amanna',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Color(0xFF590959),
      ),
      home: FutureBuilder<List<Tag>>(
        future: getIt.get<TagRepository>(instanceName: 'tag').getAll(),
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

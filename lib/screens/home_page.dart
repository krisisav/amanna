import 'package:amanna/api/api.dart';
import 'package:amanna/models/tag.dart';
import 'package:amanna/services/get_it_setup.dart';
import 'package:amanna/widgets/home_page/error_dialog.dart';
import 'package:amanna/widgets/home_page/quote_dialog.dart';
import 'package:amanna/widgets/home_page/tag_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<Tag> tags;

  HomePage(this.tags);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('AMANNA'),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF8a008a),
              const Color(0xFF794abc),
              const Color(0xFF6395ec),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 75.0),
            Flexible(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.tags.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 10.0,
                      ),
                      child: GestureDetector(
                        child: TagCard(widget.tags[index]),
                        onTap: () async {
                          final quote = await getIt.get<API>()
                              .getQuoteByTag(widget.tags[index].name);
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              if(quote == null) {
                                return ErrorDialog();
                              }

                              return QuoteDialog(quote, widget.tags[index]);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

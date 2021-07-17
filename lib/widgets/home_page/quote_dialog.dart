import 'package:amanna/models/quote.dart';
import 'package:amanna/models/tag.dart';
import 'package:amanna/repositories/quote_repository.dart';
import 'package:amanna/services/get_it_setup.dart';
import 'package:amanna/widgets/home_page/dialog_painter.dart';
import 'package:flutter/material.dart';

class QuoteDialog extends StatelessWidget {
  final Quote quote;
  final Tag tag;

  const QuoteDialog(this.quote, this.tag);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: CustomPaint(
              painter: DialogPainter(
                color: Colors.white,
                circleRadius: 32.0,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 64.0, 20.0, 36.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      quote.content,
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: double.maxFinite,
                      child: Text(
                        '- ' + quote.author,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: 28.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'CANCEL',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () async {
                              await getIt.get<QuoteRepository>(instanceName: 'quote')
                                  .save(quote);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'SAVE',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 32.0,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              child: Icon(
                tag.icon,
                color: Colors.white,
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

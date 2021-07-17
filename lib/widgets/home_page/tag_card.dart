import 'package:amanna/models/tag.dart';
import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  final Tag tag;

  const TagCard(this.tag);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 70,
          color: Colors.black.withOpacity(0.05),
          child: Row(
            children: <Widget>[
              Container(
                color: Theme.of(context).accentColor,
                width: 70,
                height: 70,
                child: Icon(
                  tag.icon,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Text(
                  '# ' + tag.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
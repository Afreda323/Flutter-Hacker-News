import 'package:flutter/material.dart';
import 'dart:async';
import '../models/item.modal.dart';
import 'loadingContainer.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext itemContext, AsyncSnapshot<ItemModel> itemSnap) {
        if (!itemSnap.hasData) {
          return LoadingContainer();
        }

        final item = itemSnap.data;

        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: item.by == "" ? Text("Deleted") : Text(item.by),
            contentPadding: EdgeInsets.only(left: depth * 16.0, right: 16.0),
          ),
          Divider(height: 8.0),
        ];

        item.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27', "'")
        .replaceAll("<p>", "\n\n")
        .replaceAll("</p>", "");

    return Text(text);
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item.modal.dart';
import '../blocs/stories.provider.dart';
import 'loadingContainer.dart';

class NewsListItem extends StatelessWidget {
  final int itemId;
  NewsListItem({this.itemId});

  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnap) {
            if (!itemSnap.hasData) {
              return LoadingContainer();
            }

            return buildTile(context, itemSnap.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(item.title),
          subtitle: Text("${item.score} points"),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text(item.descendants.toString()),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}

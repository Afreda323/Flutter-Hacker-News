import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item.modal.dart';
import '../blocs/comments.provider.dart';
import '../widgets/comment.dart';

class NewsDetailScreen extends StatelessWidget {
  final int itemId;

  NewsDetailScreen({this.itemId});

  Widget build(BuildContext context) {
    final commentsBloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("News Detail")),
      body: buildBody(commentsBloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnap) {
            if (!itemSnap.hasData) {
              return Text("Loading");
            }

            return buildList(itemSnap.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    final commentsList = item.kids
        .map((kidId) => Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: 1,
            ))
        .toList();

    children.add(buildTitle(item));
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Text(
        item.title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../blocs/stories.provider.dart';
import '../widgets/newsListItem.dart';
import '../widgets/refresh.dart';

class NewsListScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final storiesBloc = StoriesProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      body: buildList(storiesBloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);
              return NewsListItem(
                itemId: snapshot.data[index],
              );
            },
          ),
        );
      },
    );
  }
}

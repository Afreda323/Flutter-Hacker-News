import 'package:flutter/material.dart';
import 'screens/newsList.screen.dart';
import 'screens/newsDetail.screen.dart';
import 'blocs/stories.provider.dart';
import 'blocs/comments.provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          theme: ThemeData.dark(),
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          return NewsListScreen();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          int itemId = int.parse(settings.name.replaceFirst('/', ''));
          final CommentsBloc commentsBloc = CommentsProvider.of(context);

          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetailScreen(itemId: itemId);
        },
      );
    }
  }
}

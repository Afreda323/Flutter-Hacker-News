import 'package:flutter/material.dart';
import 'stories.bloc.dart';
export 'stories.bloc.dart';

class StoriesProvider extends InheritedWidget {
  StoriesBloc bloc;
  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}

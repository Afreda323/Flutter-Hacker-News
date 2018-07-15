import 'package:flutter/material.dart';
import '../blocs/stories.provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  Refresh({this.child});

  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
      child: child,
    );
  }
}



import 'package:flutter/material.dart';
class AppBarSliver extends StatelessWidget {
  const AppBarSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        //  es una lita de widget
        slivers: [
          SliverAppBar(
            leading: IconButton(
                onPressed: () {
                  // const MyDrawer();
                },
                icon: const Icon(Icons.menu)),
            backgroundColor: Colors.lightBlue,
            floating: true,
            pinned: true, // para dja visible el widget el title
            title: const Text('Prepa Bochil'),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(0),
              background: Container(
                color: Colors.red,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 20,
            ),
          ),
        ]);
  }
}
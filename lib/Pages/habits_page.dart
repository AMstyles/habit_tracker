import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/habit.dart';
import 'package:rive/rive.dart';

import '../Widgets/habit_page_tile.dart';

class Habits extends StatefulWidget {
  Habits({Key? key}) : super(key: key);

  @override
  State<Habits> createState() => _HabitsState();
}

class _HabitsState extends State<Habits> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        slivers: [
          //!Appbar

          SliverAppBar(
            stretch: true,
            actions: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.search,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.add,
                  ),
                ),
              ),
            ],
            centerTitle: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 300,
            flexibleSpace: const FlexibleSpaceBar(
              stretchModes: [StretchMode.fadeTitle, StretchMode.zoomBackground],
              centerTitle: true,
              background: RiveAnimation.asset(
                'lib/Assets/gangNoBack.riv',
                fit: BoxFit.cover,
                alignment: Alignment(0, 0),
              ), //RiveAnimation.asset('lib/Assets/shape.riv'),
              title: Text(
                'Habits',
                style: TextStyle(color: CupertinoColors.activeBlue),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: habits.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return HabitsPageTile(
                    habit: habits[index],
                    ind: index,
                  );
                })),
          )
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchItems = [
    'apple',
    'banana',
    'pear',
    'pine apple',
    'mango',
    'avocade',
    'litch',
    'guava',
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<String> match = [];
    for (String fruit in searchItems) {
      if (fruit.contains(query)) {
        match.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: match.length,
        itemBuilder: ((context, index) {
          String result = match[index];
          return ListTile(
            title: Text(result),
          );
        }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> match = [];
    for (String fruit in searchItems) {
      if (fruit.contains(query)) {
        match.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: match.length,
        itemBuilder: ((context, index) {
          String result = match[index];
          return ListTile(
            title: Text(result),
          );
        }));
  }
}

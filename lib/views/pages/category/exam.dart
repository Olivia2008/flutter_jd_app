// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AppBarBottomSample extends StatefulWidget {
//  AppBarBottomSample({this.params});
//  final Map params;

  @override
  _AppBarBottomSampleState createState() => _AppBarBottomSampleState();
}

class _AppBarBottomSampleState extends State<AppBarBottomSample>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  // Map _params;
  @override
  void initState() {
    // _params = widget.params;
    super.initState();
    _tabController = TabController(vsync: this, length: choices.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // TOP NAV BAR: THE MIDDLE PART
          title: const Text('AppBar Bottom Widget'),
          // TOP NAV BAR: THE LEFT PART
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _nextPage(-1);
            },
          ),
          // TOP NAV BAR: THE RIGHT PART
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              tooltip: 'Next choice',
              onPressed: () {
                _nextPage(1);
              },
            ),
          ],
          // TOP NAV BAR: BOTTOM PART
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: TabPageSelector(controller: _tabController),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChoiceCard(choice: choice),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(AppBarBottomSample());
}

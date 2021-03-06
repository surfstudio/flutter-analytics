// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:analytics/analytics.dart';
import 'package:example/analytics_events.dart';
import 'package:example/firebase/firebase_analytic_event_sender.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late AnalyticService _analyticsService;

  @override
  void initState() {
    super.initState();

    final analytics = FirebaseAnalytics();
    _analyticsService = DefaultAnalyticService()
      ..addActionPerformer(FirebaseAnalyticEventSender(analytics));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () => _sendAnalyticAction(
                const FantasticButtonTappedEvent(),
              ),
              child: const Text('Fantastic button'),
            ),
            TextButton(
              onPressed: () => _sendAnalyticAction(
                const SparklingButtonTappedEvent('some data'),
              ),
              child: const Text('Sparkling button'),
            ),
            TextButton(
              onPressed: () => _sendAnalyticAction(
                const DelightfulButtonTappedEvent(isDelightful: true),
              ),
              child: const Text('Delightful button'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendAnalyticAction(AnalyticAction action) {
    _analyticsService.performAction(action);

    ScaffoldMessenger.of(_scaffoldKey.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
        .showSnackBar(SnackBar(content: Text('action send: $action')));
  }
}

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

import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

const actionPerformed = 'Action performed';

List<String> log = <String>[];

void main() {
  late MockLogger logger;

  setUp(
    () {
      logger = MockLogger();
    },
  );

  tearDown(
    () {
      log = [];
    },
  );

  test(
    'Calling performAction method with correct action should work correctly',
    overridePrint(
      () {
        final strategy = TestStrategy(actionPerformed: actionPerformed);

        final service = AnalyticService.withStrategies({strategy}, logger: logger);

        final action = TestAction();

        service.performAction(action);

        expect(log, [actionPerformed]);
      },
    ),
  );

  test(
    'When calling a method performAction with an incorrect action, '
    'the method d must be called from the logger',
    () async {
      final strategy = TestStrategy(actionPerformed: actionPerformed);

      final service = AnalyticService.withStrategies({strategy}, logger: logger);

      final action = SecondTestAction();

      service.performAction(action);

      verify(() => logger.d(any<String>())).called(1);
    },
  );
}

class TestAction extends AnalyticAction {}

class SecondTestAction extends AnalyticAction {}

class TestStrategy extends AnalyticStrategy<TestAction> {
  final String? actionPerformed;

  TestStrategy({this.actionPerformed});

  @override
  void performAction(TestAction action) {
    // ignore: avoid_print
    print(actionPerformed);
  }
}

class MockLogger extends Mock implements Logger {}

void Function() overridePrint(void Function() testFn) => () {
      final spec = ZoneSpecification(
        print: (_, __, ___, msg) {
          log.add(msg);
        },
      );
      return Zone.current.fork(specification: spec).run<void>(testFn);
    };

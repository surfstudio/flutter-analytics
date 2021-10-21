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

import 'package:analytics/core/analytic_action.dart';
import 'package:analytics/core/analytic_action_performer.dart';
import 'package:analytics/impl/default_analytic_service.dart';
import 'package:test/test.dart';

const actionPerformed = 'Action performed';
const emptyActionPerformed = '';

List<String> log = <String>[];

class TestAction extends AnalyticAction {}

class TestPerformer extends AnalyticActionPerformer<TestAction> {
  final String actionPerformed;

  const TestPerformer({required this.actionPerformed});

  @override
  void perform(TestAction action) {
    // ignore: avoid_print
    print(actionPerformed);
  }
}

void main() {
  tearDown(
    () {
      log = [];
    },
  );

  test(
    'DefaultAnalyticService performs action',
    overridePrint(
      () {
        final service = DefaultAnalyticService();

        const performer = TestPerformer(actionPerformed: actionPerformed);

        service.addActionPerformer(performer);

        final action = TestAction();

        service.performAction(action);

        expect(log, [actionPerformed]);
      },
    ),
  );

  test(
    'DefaultAnalyticService performs action(empty)',
    overridePrint(
      () {
        final service = DefaultAnalyticService();

        const performer = TestPerformer(actionPerformed: emptyActionPerformed);

        service.addActionPerformer(performer);

        final action = TestAction();

        service.performAction(action);

        expect(log, [emptyActionPerformed]);
      },
    ),
  );
}

void Function() overridePrint(void Function() testFn) => () {
      final spec = ZoneSpecification(
        print: (_, __, ___, msg) {
          log.add(msg);
        },
      );
      return Zone.current.fork(specification: spec).run<void>(testFn);
    };

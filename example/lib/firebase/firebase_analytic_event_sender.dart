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

import 'package:analytics/core/analytic_action.dart';
import 'package:analytics/core/analytic_action_performer.dart';
import 'package:example/firebase/const.dart';
import 'package:example/firebase/firebase_analytic_event.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticEventSender
    implements AnalyticActionPerformer<FirebaseAnalyticEvent> {
  final FirebaseAnalytics _firebaseAnalytics;

  const FirebaseAnalyticEventSender(this._firebaseAnalytics);

  @override
  bool canHandle(AnalyticAction action) => action is FirebaseAnalyticEvent;

  @override
  void perform(FirebaseAnalyticEvent action) {
    final params = _cutParamsLength(action.params as Map<String, Object>);
    _firebaseAnalytics.logEvent(
      name: _cutName(action.key),
      parameters: params,
    );
  }

  // Shortening of parameters to meet requirements of Firebase Analytics.
  Map<String, dynamic> _cutParamsLength(Map<String, Object> params) {
    final resultParams = <String, dynamic>{};
    for (final key in params.keys) {
      final value = params[key];
      resultParams[_cutName(key)] = value is String ? _cutValue(value) : value;
    }

    return resultParams;
  }

  String _cutName(String name) => name.length <= maxEventKeyLength
      ? name
      : name.substring(0, maxEventKeyLength);

  String _cutValue(String value) => value.length <= maxEventValueLength
      ? value
      : value.substring(0, maxEventValueLength);
}

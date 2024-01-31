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

import 'package:analytics/core/analytic_stragery.dart';
import 'package:example/firebase/firebase_analytic_event.dart';
import 'package:example/firebase/firebase_string_x.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticEventSenderStrategy extends AnalyticStragery<FirebaseAnalyticEvent> {
  final FirebaseAnalytics _firebaseAnalytics;

  FirebaseAnalyticEventSenderStrategy(this._firebaseAnalytics);

  @override
  void performAction(FirebaseAnalyticEvent action) {
    final params = _cutParamsLength(action.params);
    _firebaseAnalytics.logEvent(
      name: action.key.cutName,
      parameters: params,
    );
  }

  // Shortening of parameters to meet requirements of Firebase Analytics.
  Map<String, dynamic> _cutParamsLength(Map<String, Object> params) {
    final resultParams = <String, dynamic>{};
    for (final key in params.keys) {
      final value = params[key];
      resultParams[key.cutName] = value is String ? value.cutValue : value;
    }

    return resultParams;
  }
}

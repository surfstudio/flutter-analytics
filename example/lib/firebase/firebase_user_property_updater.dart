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
import 'package:example/firebase/firebase_string_x.dart';
import 'package:example/firebase/firebase_user_property.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseUserPropertyUpdaterStrategy
    extends AnalyticStrategy<FirebaseUserProperty> {
  final FirebaseAnalytics _firebaseAnalytics;

  FirebaseUserPropertyUpdaterStrategy(this._firebaseAnalytics);

  @override
  void performAction(FirebaseUserProperty action) {
    _firebaseAnalytics.setUserProperty(
      name: action.key.cutName,
      value: action.value.cutValue,
    );
  }
}

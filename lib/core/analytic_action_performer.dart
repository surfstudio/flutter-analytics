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

/// An interface for analytic action performers.
///
/// This interface define a method for sending analytic actions.
/// Classes that implement this interface provide the actual analytic action performing functionality.
// ignore: one_member_abstracts
abstract class AnalyticActionPerformer<A extends AnalyticAction> {
  /// Method of sending sending analytic actions.
  void performAction(A action);
}

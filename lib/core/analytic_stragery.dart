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

/// Base class for analytic strategies.
///
/// This class is an abstract base class for analytic strategies. A analytic strategy is a class
/// that provides a specific way of sending analytic action. To create
/// a custom analytic strategy, you should extend this class and implement the `performAction`
/// method.
/// The `canHandle` method determines whether the analytical strategy is able to handle the incoming event.
abstract class AnalyticStragery<A extends AnalyticAction>
    extends AnalyticActionPerformer<A> {
  bool canHandle(AnalyticAction action) => action is A;
}

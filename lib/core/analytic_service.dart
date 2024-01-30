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

import 'package:analytics/core/analitic_stragery.dart';
import 'package:analytics/core/analytic_action.dart';
import 'package:analytics/core/analytic_action_performer.dart';
import 'package:analytics/utils/logger.dart';
import 'package:logger/logger.dart';

/// Class for instantiating analytic service.
///
/// WARNING! Do not use this class directly for analitic action sending.
///
/// This class provides a way to send analitic action using a set of
/// analitic strategies. To use this class, you should create an instance of it with a set of
/// analitic strategies, and then call the `performAction` method to send analitic action.
class AnalyticService implements AnalyticActionPerformer {
  /// Initialize analytic service without strategies.
  AnalyticService.empty({Logger? logger})
      : _strategies = <AnalyticStragery>{},
        _logger = logger ?? defaultLogger;

  /// Initialize analytic service with strategies.
  AnalyticService.withStrategies(this._strategies, {Logger? logger}) : _logger = logger ?? defaultLogger;
  final Logger _logger;

  final Set<AnalyticStragery> _strategies;

  @override
  void performAction(AnalyticAction action) {
    _getStrategiesByAction(action).forEach((strategy) => strategy.performAction(action));
  }

  List<AnalyticActionPerformer<AnalyticAction>> _getStrategiesByAction(
    AnalyticAction event,
  ) {
    final properStrategies = _strategies.where((strategies) => strategies.canHandle(event)).toList();
    if (properStrategies.isEmpty) {
      _logger.d(
        'No action performer for action:'
        ' ${event.runtimeType} in performers $_strategies',
      );
    }
    return properStrategies;
  }

  /// Add strategy to analytic service.
  void addStrategy(AnalyticStragery strategy) {
    _strategies.add(strategy);
  }

  /// Remove strategy from analytic service.
  void removeStrategy(AnalyticStragery strategy) {
    _strategies.remove(strategy);
  }

  /// Remove all strategies from analytic service.
  void clearStrategies() {
    _strategies.clear();
  }

  /// Iterate over all strategies.
  void forEach(void Function(AnalyticStragery strategy) action) {
    _strategies.forEach(action);
  }

  /// Check if a strategy is contained in the analytic service.
  bool contains(AnalyticStragery strategy) {
    return _strategies.contains(strategy);
  }
}

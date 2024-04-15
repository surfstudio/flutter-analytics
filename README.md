# Analytics

<img src="https://raw.githubusercontent.com/surfstudio/flutter-open-source/main/assets/logo_white.png#gh-dark-mode-only" width="200">
<img src="https://raw.githubusercontent.com/surfstudio/flutter-open-source/main/assets/logo_black.png#gh-light-mode-only" width="200">

Made by [Surf 🏄‍♂️🏄‍♂️🏄‍♂️](https://surf.dev)

[![Build Status](https://shields.io/github/actions/workflow/status/surfstudio/flutter-analytics/on_pull_request.yml?logo=github&logoColor=white)](https://github.com/surfstudio/flutter-analytics)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/flutter-analytics?logo=codecov&logoColor=white)](https://app.codecov.io/gh/surfstudio/flutter-analytics)
[![Pub Version](https://img.shields.io/pub/v/analytics?logo=dart&logoColor=white)](https://pub.dev/packages/analytics)
[![Pub Likes](https://badgen.net/pub/likes/analytics)](https://pub.dev/packages/analytics)
[![Pub popularity](https://badgen.net/pub/popularity/analytics)](https://pub.dev/packages/analytics/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/analytics)

## Overview

Interface for working with analytic services.
The library is supposed to unify work with various analytic services. The main actors are:

* **AnalyticAction** — any action that is valuable for analytics. Usually it is a "button pressed" or "screen opened" type of event but the main criterion is a possibility to be handled by `AnalyticStrategy`.
* **AnalyticActionPerformer** - an interface for analytic action performers. This class is an abstract base class for analytic strategies.
* **AnalyticStrategy** — a class that provides a special way to send an analytical action. To create a custom analytic strategy, you should extend this class and implement the `performAction` method.
* **AnalyticService** — a class that provides a way to send analytic action using a set of analytic strategies. To use this class, you should create an instance of it with a set of analytic strategies, and then call the `performAction` method to send analytic action.

## Example

The easiest interaction with the library is as follows:

1. Determine the actions that ought to be recorded in the analytics service:

    ```dart
    class MyAnalyticAction implements AnalyticAction {
        final String key;
        final String value;

        MyAnalyticAction(this.key, this.value);
    }

    class ButtonPressedAction extends MyAnalyticAction {
        ButtonPressedAction() : super("button_pressed", null);
    }

    class ScreenOpenedAction extends MyAnalyticAction {
        ScreenOpenedAction({String param}) : super("screen_opened", param);
    }
    ```

2. Implement analytic strategy:

    ```dart
    class MyAnalyticStrategy
        extends AnalyticStrategy<MyAnalyticAction> {
        final SomeAnalyticsApi _analyticsApi;

        SomeAnalyticsApi(this._analyticsApi);

        @override
        void performAction(MyAnalyticAction action) {
            _analyticsApi.send(action.key, action.value);
        }
    }
    ```

3. Create an AnalyticService with your strategy:

    ```dart
    final analyticService = AnalyticService.withStrategies({
        MyAnalyticStrategy(analytics),
    });
    ```

Usage:

```dart
    analyticService.performAction(ButtonPressedAction());
```

## Installation

Add `analytics` to your `pubspec.yaml` file:

```yaml
dependencies:
  analytics: $currentVersion$
```

<p>At this moment, the current version of <code>analytics</code> is <a href="https://pub.dev/packages/analytics"><img style="vertical-align:middle;" src="https://img.shields.io/pub/v/analytics.svg" alt="analytics version"></a>.</p>

## Migrating from 1.x.x to 2.x.x

1.x.x

```dart
    final analyticService = DefaultAnalyticService();
    analyticService.addActionPerformer(
        MyAnalyticActionPerformer(SomeAnalyticService()),
    );
```

Starting from version 2.0.0, sending an event to a specific analytics service is implemented using strategies. The `AnalyticService` class stores these strategies. Implement analytics strategies using the `AnalyticStrategy` egy class.

```dart
    final analyticService = AnalyticService.withStrategies({
        MyAnalyticStrategy(analytics),
    });
```

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

To report your issues, submit directly in the [Issues](https://github.com/surfstudio/flutter-analytics/issues) section.

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, fixing a bug or adding a cool new feature), please read our [contribution guide](./CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)

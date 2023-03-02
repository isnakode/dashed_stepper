<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
## Features

<img src="https://raw.githubusercontent.com/isnausaha/dashed_stepper/master/image/stepper.jpeg" width="300px"><br>

## Getting started

add dashed_stepper in your pubspec.yaml dependency

## Usage

```dart
Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
        DashedStepper(
            labelColor: Colors.black,
            indicatorColor: Colors.green,
            length: 7,
            step: 2,
            labels: const [
                'mon',
                'tue',
                'wed',
                'thu',
                'fri',
                'sat',
                'sun',
            ],
        ),
        DashedStepper(
            labelColor: Colors.black,
            indicatorColor: Colors.red[300],
            length: 5,
            dotSize: 25,
            lineHeight: 6,
            step: 2,
        ),
        DashedStepper(
            height: 30,
            icons: const [
                Icon(Icons.home),
                Icon(Icons.airplane_ticket),
                Icon(Icons.airplanemode_active),
                Icon(Icons.check),
            ],
            labels: const [
                'home',
                'ticket',
                'flight',
                'done',
            ],
            length: 4,
            step: 2,
        ),
        DashedStepper(
            height: 50,
            icons: const [
                Icon(Icons.sunny,size: 40),
                Icon(Icons.dark_mode,size: 40),
            ],
            length: 2,
            step: 3,
        ),
    ],
),
```

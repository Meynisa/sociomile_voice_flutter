import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:sociomile_voice_flutter/sociomile_voice.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Permission.camera.request();
    await Permission.microphone.request();
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: JavascriptApp());
  }
}

class FlutterJsHomeScreen extends StatefulWidget {
  @override
  _FlutterJsHomeScreenState createState() => _FlutterJsHomeScreenState();
}

class _FlutterJsHomeScreenState extends State<FlutterJsHomeScreen> {
  final JavascriptRuntime jsRuntime = getJavascriptRuntime();
  final number = ValueNotifier(0);
  final first = ValueNotifier("first");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ValueListenableBuilder(
                valueListenable: number,
                builder: (_, value, item) {
                  return Text(value.toString(),
                      style: Theme.of(context).textTheme.headlineMedium);
                })),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
                onPressed: () async {
                  try {
                    final result = await addFromJs(jsRuntime, number.value, 1);
                    number.value = result;
                  } on PlatformException catch (e) {
                    print("Error: ${e.details}");
                  }
                },
                child: const Icon(Icons.add)),
            FloatingActionButton(
                onPressed: () async {
                  try {
                    final result = await fromJs(jsRuntime, "first", "second");
                    first.value = result;
                    print("result: $result");
                  } on PlatformException catch (e) {
                    print("Error: ${e.details}");
                  }
                },
                child: const Icon(Icons.home)),
            FloatingActionButton(
                onPressed: () async {
                  try {
                    final result = await fromJs(jsRuntime, "first", "second");
                    first.value = result;
                    print("result: $result");
                  } on PlatformException catch (e) {
                    print("Error: ${e.details}");
                  }
                },
                child: const Icon(Icons.arrow_circle_right_rounded))
          ],
        ));
  }
}

Future<String> fromJs(
    JavascriptRuntime jsRuntime, String endPoint, String secretKey) async {
  String voiceJs = await rootBundle.loadString("assets/voice.js");
  // String sociomileVoiceJs =
  //     await rootBundle.loadString("assets/sociomileVoice-1.0.0.min.js");
  final jsResult =
      jsRuntime.evaluate(voiceJs + """connect($endPoint, $secretKey)""");
  final jsStringResult = jsResult.stringResult;
  return jsStringResult;
}

Future<int> addFromJs(
    JavascriptRuntime jsRuntime, int firstNumber, int secondNumber) async {
  String voiceJs = await rootBundle.loadString("assets/voice.js");
  final jsResult =
      jsRuntime.evaluate(voiceJs + """add($firstNumber, $secondNumber)""");
  final jsStringResult = jsResult.stringResult;
  return int.parse(jsStringResult);
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:sociomile_voice_flutter/inappwebview.dart';
import 'package:sociomile_voice_flutter/webview_controller.dart';

class JavascriptApp extends StatefulWidget {
  const JavascriptApp({super.key});

  @override
  State<JavascriptApp> createState() => _JavascriptAppState();
}

class _JavascriptAppState extends State<JavascriptApp> {
  JavascriptRuntime jsRuntime = getJavascriptRuntime();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initJs();
  }

  Future<void> _initJs() async {
    String jsCode =
        await rootBundle.loadString("assets/sociomileVoice-1.0.0.min.js");
    await jsRuntime.evaluate(jsCode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Javascript App")),
        body: Center(
            child: Column(children: [
          ElevatedButton(
              onPressed: () => _runJsCode("https://app-voice.ivosights.com",
                  "3nPGaKhdiq4skMGoM3ddDiWcwLVPfvfrNQQ5yXm0"),
              child: Text("Run JS Code")),
          ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HelpScreen())),
              child: Text("Open HTML Code")),
          ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => inAppWebviewPage())),
              child: Text("Open InAppWebview"))
        ])));
  }

  Future<void> _runJsCode(String baseUrl, String secretKey) async {
    final jsResult = await jsRuntime.evaluate(
        """var sociomile = SocioVoice.Init({base_url:$baseUrl, secret_key:$secretKey})""");
    print("Javascript result: ${jsResult.toString()}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    jsRuntime.dispose();
  }
}

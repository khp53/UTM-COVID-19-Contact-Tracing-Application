import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpDesk extends StatefulWidget {
  final String url;
  HelpDesk(this.url);

  @override
  _HelpDeskState createState() => _HelpDeskState();
}

class _HelpDeskState extends State<HelpDesk> {
  num _stackToView = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UTMCCTA Help Desk'),
        ),
        body: Builder(builder: (BuildContext context) {
          return IndexedStack(index: _stackToView, children: [
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (String url) {
                // should be called when page finishes loading
                setState(() {
                  _stackToView = 0;
                });
              },
            ),
            Container(child: Center(child: CircularProgressIndicator())),
          ]);
        }),
      ),
    );
  }
}

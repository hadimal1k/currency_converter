import 'package:currency_converter/routes/page2.dart';
import 'package:flutter/material.dart';

class WelcomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CenterText("Hello"),
          SizedBox(height: 10),
          Center(child: Text("Top 2")),
          SizedBox(height: 10),
          Center(child: Text("Top 3 alksdjflaksjdflksj")),
          Center(child: Text("lkadjsf")),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) {
                    return Page2();
                  },
                ),
              );
            },
            child: const Text("Button"),
          ),
        ],
      ),
    );
  }
}

class _CenterText extends StatelessWidget {
  final String text;
  const _CenterText(this.text);
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}

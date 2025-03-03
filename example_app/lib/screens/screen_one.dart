import 'package:dynamix_flutter_sdk/dynamix_flutter_sdk.dart';
import 'package:flutter/material.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TemplateSdk.instance.showScreenTemplates(context, 'ScreenOne');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen One')),
      body: Column(
        children: [
          TemplateSdk.instance.inAppWidgetContainer(
            screenName: 'ScreenOne',
            height: 250,
            padding: const EdgeInsets.all(16),
          ),
          const Expanded(
            child: Center(
              child: Text('Screen One Content'),
            ),
          ),
        ],
      ),
    );
  }
} 
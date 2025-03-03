import 'package:dynamix_flutter_sdk/dynamix_flutter_sdk.dart';
import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TemplateSdk.instance.showScreenTemplates(context, 'ScreenTwo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Two')),
      body: Column(
        children: [
          TemplateSdk.instance.inAppWidgetContainer(
            screenName: 'ScreenTwo',
            height: 250,
            padding: const EdgeInsets.all(16),
          ),
          const Expanded(
            child: Center(
              child: Text('Screen Two Content'),
            ),
          ),
        ],
      ),
    );
  }
} 
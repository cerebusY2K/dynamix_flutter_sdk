import 'package:dynamix_flutter_sdk/dynamix_flutter_sdk.dart';
import 'package:flutter/material.dart';


class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TemplateSdk.instance.showScreenTemplates(context, 'ScreenThree');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Three')),
      body: Column(
        children: [
          TemplateSdk.instance.inAppWidgetContainer(
            screenName: 'ScreenThree',
            height: 250,
            padding: const EdgeInsets.all(16),
          ),
          const Expanded(
            child: Center(
              child: Text('Screen Three Content'),
            ),
          ),
        ],
      ),
    );
  }
} 
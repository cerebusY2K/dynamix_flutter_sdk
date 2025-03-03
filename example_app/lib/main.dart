import 'package:dynamix_flutter_sdk/dynamix_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'screens/screen_one.dart';
import 'screens/screen_two.dart';
import 'screens/screen_three.dart';

void main() {
  TemplateSdk.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Template SDK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show app_open templates only on dashboard
      TemplateSdk.instance.showAppOpenTemplates(context);
      // Also show dashboard screen templates
      TemplateSdk.instance.showScreenTemplates(context, 'Dashboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // In-app widget from SDK
            TemplateSdk.instance.inAppWidgetContainer(
              screenName: 'Dashboard',
              height: 250,
              padding: const EdgeInsets.all(16),
            ),
            // Navigation buttons
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenOne(),
                        ),
                      ),
                      child: const Text('Screen One'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenTwo(),
                        ),
                      ),
                      child: const Text('Screen Two'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenThree(),
                        ),
                      ),
                      child: const Text('Screen Three'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
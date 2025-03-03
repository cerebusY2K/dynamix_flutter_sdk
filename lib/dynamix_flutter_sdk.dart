import 'package:flutter/material.dart';
export 'template_sdk_exports.dart';
import 'services/template_service.dart';
import 'template_sdk_exports.dart';
import 'widgets/in_app_widget_container.dart';
import 'widgets/template_manager.dart';

class TemplateSdk {
  static final TemplateSdk instance = TemplateSdk._internal();
  final TemplateService _service = TemplateService();
  String? _baseUrl;
  
  TemplateSdk._internal();

  /// Initialize the SDK with base URL
  void initialize() {
    var url = "https://3f63-45-112-40-193.ngrok-free.app/api/notifications/templates";
    _baseUrl = url;
    _service.initialize(url);
  }

  /// Show templates for app open
  Future<void> showAppOpenTemplates(BuildContext context) async {
    if (_baseUrl == null) {
      throw Exception('SDK not initialized. Call initialize() first.');
    }

    try {
      final templates = await _service.fetchTemplates();
      final appOpenTemplates = templates
          .where((template) => 
              template.trigger.type == 'app_open' && 
              template.isActive)
          .toList();
      
      if (appOpenTemplates.isNotEmpty) {
        TemplateManager.showTemplates(context, appOpenTemplates);
      }
    } catch (e) {
      debugPrint('Error showing app open templates: $e');
    }
  }

  /// Show templates for specific screen
  Future<void> showScreenTemplates(BuildContext context, String screenName) async {
    if (_baseUrl == null) {
      throw Exception('SDK not initialized. Call initialize() first.');
    }

    try {
      final templates = await _service.fetchTemplates();
      debugPrint('Showing templates for screen: $screenName'); // Debug print
      
      final screenTemplates = templates.where((template) => 
        template.trigger.type == 'screen' && 
        template.trigger.screenName.toLowerCase() == screenName.toLowerCase() &&
        template.isActive &&
        template.type != 'in-app-widget' // Exclude in-app-widget type
      ).toList();
      
      debugPrint('Found ${screenTemplates.length} screen templates'); // Debug print
      
      if (screenTemplates.isNotEmpty) {
        TemplateManager.showTemplates(context, screenTemplates);
      }
    } catch (e) {
      debugPrint('Error showing screen templates: $e');
    }
  }

  /// Widget to display in-app content
  Widget inAppWidgetContainer({
    required String screenName,
    double? height,
    EdgeInsets? padding,
  }) {
    return InAppWidgetContainer(
      screenName: screenName,
      service: _service,
      height: height,
      padding: padding,
    );
  }
} 
import 'package:flutter/material.dart';
import '../models/template_model.dart';
import '../services/template_service.dart';
import 'in_app_widget.dart';

class InAppWidgetContainer extends StatefulWidget {
  final String screenName;
  final TemplateService service;
  final double? height;
  final EdgeInsets? padding;

  const InAppWidgetContainer({
    super.key,
    required this.screenName,
    required this.service,
    this.height,
    this.padding,
  });

  @override
  State<InAppWidgetContainer> createState() => _InAppWidgetContainerState();
}

class _InAppWidgetContainerState extends State<InAppWidgetContainer> {
  Template? _template;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTemplate();
  }

  Future<void> _loadTemplate() async {
    try {
      final templates = await widget.service.fetchTemplates();
      debugPrint('Loading templates for ${widget.screenName}'); // Debug print
      final inAppWidgets = templates.where((template) => 
        template.type == 'in-app-widget' && 
        template.trigger.screenName.toLowerCase() == widget.screenName.toLowerCase() &&
        template.isActive &&
        template.trigger.type == 'screen' // Add this condition
      ).toList();

      debugPrint('Found ${inAppWidgets.length} in-app widgets'); // Debug print

      setState(() {
        _template = inAppWidgets.isNotEmpty ? inAppWidgets.first : null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return const SizedBox.shrink();
    }

    if (_template == null) {
      return const SizedBox.shrink();
    }

    return InAppWidget(
      template: _template!,
      height: widget.height,
      padding: widget.padding,
    );
  }
} 
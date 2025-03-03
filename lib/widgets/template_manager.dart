import 'package:flutter/material.dart';
import '../models/template_model.dart';
import 'template_webview.dart';
import 'template_nudge.dart';
import 'template_pip.dart';
import 'package:flutter/foundation.dart';

class TemplateManager {
  static void showTemplates(BuildContext context, List<Template> templates) {
    if (templates.isEmpty) return;

    void showNextTemplate(int index) {
      if (index >= templates.length) return;

      Template template = templates[index];
      Widget templateWidget;

      debugPrint('Showing template type: ${template.type}'); // Debug print

      switch (template.type) {
        case 'nudge':
          templateWidget = TemplateNudge(
            template: template,
            onClose: () => showNextTemplate(index + 1),
          );
          break;
        case 'picture-in-picture':
          templateWidget = TemplatePIP(
            template: template,
            onClose: () => showNextTemplate(index + 1),
          );
          break;
        case 'roadblock':
          templateWidget = TemplateWebView(
            template: template,
            onClose: () => showNextTemplate(index + 1),
          );
          break;
        default:
          debugPrint('Unhandled template type: ${template.type}');
          showNextTemplate(index + 1);
          return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => templateWidget,
      );
    }

    showNextTemplate(0);
  }
} 
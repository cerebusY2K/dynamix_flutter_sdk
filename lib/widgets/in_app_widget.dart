import 'package:flutter/material.dart';
import '../models/template_model.dart';
import 'carousel_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWidget extends StatelessWidget {
  final Template template;
  final double? height;
  final EdgeInsets? padding;

  const InAppWidget({
    super.key,
    required this.template,
    this.height,
    this.padding,
  });

  Widget _buildContent(BuildContext context) {
    final widgetHeight = height ?? 250.0;

    if (template.content.isCarousel && template.content.carouselItems != null) {
      return CarouselWidget(
        items: template.content.carouselItems!,
        height: widgetHeight,
        width: MediaQuery.of(context).size.width,
        borderRadius: BorderRadius.circular(12),
      );
    }
    
    if (template.content.isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          template.content.data,
          height: widgetHeight,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: widgetHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Icon(Icons.error)),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: widgetHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      );
    }

    if (template.content.isHtml) {
      return Container(
        height: widgetHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadHtmlString(template.content.data)
              ..setBackgroundColor(Colors.transparent),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: _buildContent(context),
    );
  }
} 
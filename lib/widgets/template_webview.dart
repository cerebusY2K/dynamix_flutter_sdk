import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/template_model.dart';
import 'carousel_widget.dart';

class TemplateWebView extends StatelessWidget {
  final Template template;
  final VoidCallback onClose;

  const TemplateWebView({
    super.key,
    required this.template,
    required this.onClose,
  });

  Widget _buildContent(BuildContext context) {
    if (template.content.isCarousel && template.content.carouselItems != null) {
      return CarouselWidget(
        items: template.content.carouselItems!,
        height: MediaQuery.of(context).size.height * 0.8,
        borderRadius: BorderRadius.circular(12),
      );
    }
    if (template.content.isImage) {
      return Image.network(
        template.content.data,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.error));
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(template.content.data)
      ..setBackgroundColor(Colors.transparent);

    return WebViewWidget(controller: controller);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildContent(context),
            ),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 12,
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                  maxWidth: 16,
                  maxHeight: 16,
                ),
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onClose();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
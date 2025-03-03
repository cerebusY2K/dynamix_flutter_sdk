import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/template_model.dart';
import 'carousel_widget.dart';

class TemplatePIP extends StatelessWidget {
  final Template template;
  final VoidCallback onClose;

  const TemplatePIP({
    super.key,
    required this.template,
    required this.onClose,
  });

  Widget _buildContent() {
    if (template.content.isCarousel && template.content.carouselItems != null) {
      return CarouselWidget(
        items: template.content.carouselItems!,
        height: 280,
        width: 160,
        borderRadius: BorderRadius.circular(12),
      );
    }
    
    if (template.content.isImage) {
      return Image.network(
        template.content.data,
        fit: BoxFit.cover,
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
          Positioned(
            bottom: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 160,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildContent(),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
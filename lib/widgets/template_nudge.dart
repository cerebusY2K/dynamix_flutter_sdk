import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/template_model.dart';
import 'carousel_widget.dart';

class TemplateNudge extends StatelessWidget {
  final Template template;
  final VoidCallback onClose;

  const TemplateNudge({
    super.key,
    required this.template,
    required this.onClose,
  });

  Widget _buildContent(BuildContext context) {
    if (template.content.isCarousel && template.content.carouselItems != null) {
      return CarouselWidget(
        items: template.content.carouselItems!,
        height: 60,
        width: MediaQuery.of(context).size.width,
      );
    }
    
    if (template.content.isImage) {
      return Image.network(
        template.content.data,
        fit: BoxFit.cover,
        height: 60,
        width: double.infinity,
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
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (template.position == 'top') ...[
              // Close button for top position
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0, top: 4.0),
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
              ),
              const SizedBox(height: 4),
              // Banner for top position
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: _buildContent(context),
              ),
              const Spacer(), // Pushes everything above to the top
            ] else ...[
              const Spacer(), // Pushes everything below to the bottom
              // Banner for bottom position
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: _buildContent(context),
              ),
              // Close button for bottom position
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0, top: 4.0),
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
              ),
            ],
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';

/// Common bottom-sheet chrome used by Info, Episodes, and Chapters panels.
class PlayerPanelSheet extends StatelessWidget {
  const PlayerPanelSheet({
    super.key,
    required this.child,
    required this.onClose,
    this.title,
  });

  final Widget child;
  final VoidCallback onClose;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xF0111111),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // Handle bar
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 2),
              child: Container(
                width: 28,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header row
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 12, 8),
                child: Row(
                  children: [
                    Text(
                      title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onClose,
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white54,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white12, height: 1),
            ] else
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12, top: 4),
                  child: GestureDetector(
                    onTap: onClose,
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ),
                ),
              ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

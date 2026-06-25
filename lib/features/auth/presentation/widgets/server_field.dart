import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/platform_widget.dart';

/// Text field for entering a Jellyfin server URL.
///
/// Shows a prefix icon and validates the URL format.
class ServerUrlField extends StatelessWidget {
  const ServerUrlField({
    super.key,
    required this.controller,
    this.errorText,
    this.onSubmitted,
    this.focusNode,
  });

  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTextField(
      controller: controller,
      placeholder: 'http://192.168.1.100:8096',
      label: 'Server URL',
      errorText: errorText,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.next,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      autocorrect: false,
      autofillHints: const [AutofillHints.url],
      prefix: PlatformWidget(
        ios: (_) => const Icon(
          CupertinoIcons.globe,
          size: 18,
          color: AppColors.textSecondaryDark,
        ),
        android: (_) => const Icon(
          Icons.dns_outlined,
          size: 20,
          color: AppColors.textSecondaryDark,
        ),
      ),
    );
  }
}

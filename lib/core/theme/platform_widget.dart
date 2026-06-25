import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

// ─── Platform Detection ───────────────────────────────────────────────────────

bool get isIOS => Platform.isIOS;
bool get isAndroid => Platform.isAndroid;

// ─── Base Platform Widget ─────────────────────────────────────────────────────

/// Renders [ios] on iOS, [android] on everything else.
class PlatformWidget extends StatelessWidget {
  const PlatformWidget({super.key, required this.ios, required this.android});

  final WidgetBuilder ios;
  final WidgetBuilder android;

  @override
  Widget build(BuildContext context) {
    return isIOS ? ios(context) : android(context);
  }
}

// ─── Adaptive Scaffold ────────────────────────────────────────────────────────

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    super.key,
    this.title,
    required this.body,
    this.leading,
    this.actions,
    this.largeTitle = false,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final String? title;
  final Widget body;
  final Widget? leading;
  final List<Widget>? actions;
  final bool largeTitle;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool resizeToAvoidBottomInset;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) => CupertinoPageScaffold(
        backgroundColor: backgroundColor ?? AppColors.backgroundDark,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        navigationBar: title != null
            ? CupertinoNavigationBar(
                middle: largeTitle ? null : Text(title!),
                // largeTitle: largeTitle ? Text(title!) : null,
                leading: leading,
                trailing: actions != null
                    ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
                    : null,
                backgroundColor: backgroundColor ?? AppColors.backgroundDark,
                border: null,
              )
            : null,
        child: SafeArea(
          child: Padding(padding: padding, child: body),
        ),
      ),
      android: (_) => Scaffold(
        backgroundColor: backgroundColor ?? AppColors.backgroundDark,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: title != null
            ? AppBar(
                title: Text(title!),
                leading: leading,
                actions: actions,
                backgroundColor: backgroundColor ?? AppColors.backgroundDark,
              )
            : null,
        body: Padding(padding: padding, child: body),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}

// ─── Adaptive App Bar ─────────────────────────────────────────────────────────

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.bottom,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) => CupertinoNavigationBar(
        middle: title != null ? Text(title!) : null,
        leading: leading,
        trailing: actions != null
            ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
            : null,
        backgroundColor: backgroundColor ?? AppColors.backgroundDark,
        border: null,
      ),
      android: (_) => AppBar(
        title: title != null ? Text(title!) : null,
        leading: leading,
        actions: actions,
        backgroundColor: backgroundColor ?? AppColors.backgroundDark,
        bottom: bottom,
      ),
    );
  }
}

// ─── Adaptive Text Field ──────────────────────────────────────────────────────

class AdaptiveTextField extends StatelessWidget {
  const AdaptiveTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.prefix,
    this.suffix,
    this.autofocus = false,
    this.enabled = true,
    this.autocorrect = true,
    this.autofillHints,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefix;
  final Widget? suffix;
  final bool autofocus;
  final bool enabled;
  final bool autocorrect;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: const TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.1,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 6),
          ],
          CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            prefix: prefix != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: prefix,
                  )
                : null,
            suffix: suffix != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: suffix,
                  )
                : null,
            autofocus: autofocus,
            enabled: enabled,
            autocorrect: autocorrect,
            autofillHints: autofillHints,
            focusNode: focusNode,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            style: const TextStyle(
              color: AppColors.textPrimaryDark,
              fontSize: 16,
              decoration: TextDecoration.none,
            ),
            placeholderStyle: const TextStyle(
              color: AppColors.textSecondaryDark,
              fontSize: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(10),
              border: errorText != null
                  ? Border.all(color: AppColors.error, width: 1.5)
                  : null,
            ),
          ),
          if (errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              errorText!,
              style: const TextStyle(color: AppColors.error, fontSize: 12),
            ),
          ],
        ],
      ),
      android: (_) => TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        autofocus: autofocus,
        enabled: enabled,
        autocorrect: autocorrect,
        autofillHints: autofillHints,
        focusNode: focusNode,
        style: const TextStyle(color: AppColors.textPrimaryDark, fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          errorText: errorText,
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
      ),
    );
  }
}

// ─── Adaptive Button ──────────────────────────────────────────────────────────

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDestructive = false,
    this.icon,
    this.filled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDestructive;
  final IconData? icon;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.primary;
    final child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        : icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 8),
              Text(label),
            ],
          )
        : Text(label);

    return PlatformWidget(
      ios: (_) => filled
          ? CupertinoButton.filled(
              onPressed: isLoading ? null : onPressed,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              child: child,
            )
          : CupertinoButton(
              onPressed: isLoading ? null : onPressed,
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                child: child,
              ),
            ),
      android: (_) => filled
          ? ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: child,
            )
          : OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: color,
                side: BorderSide(color: color),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: child,
            ),
    );
  }
}

// ─── Adaptive Icon Button ─────────────────────────────────────────────────────

class AdaptiveIconButton extends StatelessWidget {
  const AdaptiveIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) => CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Icon(icon, color: color ?? AppColors.primary),
      ),
      android: (_) => IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        tooltip: tooltip,
        color: color ?? AppColors.primary,
      ),
    );
  }
}

// ─── Adaptive Activity Indicator ──────────────────────────────────────────────

class AdaptiveActivityIndicator extends StatelessWidget {
  const AdaptiveActivityIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) => CupertinoActivityIndicator(
        color: color ?? AppColors.primary,
        radius: 12,
      ),
      android: (_) => CircularProgressIndicator(
        color: color ?? AppColors.primary,
        strokeWidth: 2.5,
      ),
    );
  }
}

// ─── Adaptive Alert Dialog ────────────────────────────────────────────────────

Future<T?> showAdaptiveDialog<T>({
  required BuildContext context,
  required String title,
  required String message,
  String? confirmLabel,
  String? cancelLabel,
  bool isDestructive = false,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  if (isIOS) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelLabel != null)
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
              child: Text(cancelLabel),
            ),
          if (confirmLabel != null)
            CupertinoDialogAction(
              isDestructiveAction: isDestructive,
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text(confirmLabel),
            ),
        ],
      ),
    );
  }

  return showDialog<T>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        if (cancelLabel != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
            child: Text(cancelLabel),
          ),
        if (confirmLabel != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm?.call();
            },
            style: isDestructive
                ? TextButton.styleFrom(foregroundColor: AppColors.error)
                : null,
            child: Text(confirmLabel),
          ),
      ],
    ),
  );
}

// ─── Adaptive Action Sheet ────────────────────────────────────────────────────

class AdaptiveAction {
  const AdaptiveAction({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isDestructive;
}

Future<void> showAdaptiveActionSheet({
  required BuildContext context,
  required String title,
  required List<AdaptiveAction> actions,
  String? cancelLabel,
}) async {
  if (isIOS) {
    await showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: Text(title),
        actions: actions
            .map(
              (a) => CupertinoActionSheetAction(
                isDestructiveAction: a.isDestructive,
                onPressed: () {
                  Navigator.of(context).pop();
                  a.onPressed();
                },
                child: Text(a.label),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelLabel ?? 'Cancel'),
        ),
      ),
    );
    return;
  }

  await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: AppColors.surfaceDark,
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...actions.map(
            (a) => ListTile(
              leading: a.icon != null
                  ? Icon(
                      a.icon,
                      color: a.isDestructive
                          ? AppColors.error
                          : AppColors.textPrimaryDark,
                    )
                  : null,
              title: Text(
                a.label,
                style: TextStyle(
                  color: a.isDestructive
                      ? AppColors.error
                      : AppColors.textPrimaryDark,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                a.onPressed();
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

// ─── Adaptive List Tile ───────────────────────────────────────────────────────

class AdaptiveListTile extends StatelessWidget {
  const AdaptiveListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.showDivider = true,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  if (leading != null) ...[leading!, const SizedBox(width: 14)],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.textPrimaryDark,
                            fontSize: 16,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: const TextStyle(
                              color: AppColors.textSecondaryDark,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  trailing ??
                      (onTap != null
                          ? const Icon(
                              CupertinoIcons.chevron_right,
                              size: 16,
                              color: AppColors.textSecondaryDark,
                            )
                          : const SizedBox.shrink()),
                ],
              ),
            ),
            if (showDivider)
              const Divider(height: 1, color: AppColors.cardDark),
          ],
        ),
      ),
      android: (_) => Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: subtitle != null ? Text(subtitle!) : null,
            leading: leading,
            trailing: trailing,
            onTap: onTap,
          ),
          if (showDivider) const Divider(height: 1, color: AppColors.cardDark),
        ],
      ),
    );
  }
}

// ─── Adaptive Bottom Tab Bar ──────────────────────────────────────────────────

class AdaptiveTabItem {
  const AdaptiveTabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.child,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Widget child;
}

class AdaptiveTabScaffold extends StatefulWidget {
  const AdaptiveTabScaffold({super.key, required this.tabs});

  final List<AdaptiveTabItem> tabs;

  @override
  State<AdaptiveTabScaffold> createState() => _AdaptiveTabScaffoldState();
}

class _AdaptiveTabScaffoldState extends State<AdaptiveTabScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: AppColors.surfaceDark,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.textSecondaryDark,
          items: widget.tabs
              .map(
                (t) => BottomNavigationBarItem(
                  icon: Icon(t.icon),
                  activeIcon: Icon(t.activeIcon),
                  label: t.label,
                ),
              )
              .toList(),
        ),
        tabBuilder: (_, i) => widget.tabs[i].child,
      ),
      android: (_) => Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: widget.tabs[_currentIndex].child,
        bottomNavigationBar: NavigationBar(
          backgroundColor: AppColors.surfaceDark,
          indicatorColor: AppColors.primary.withValues(alpha: 0.2),
          selectedIndex: _currentIndex,
          onDestinationSelected: (i) => setState(() => _currentIndex = i),
          destinations: widget.tabs
              .map(
                (t) => NavigationDestination(
                  icon: Icon(t.icon),
                  selectedIcon: Icon(t.activeIcon, color: AppColors.primary),
                  label: t.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

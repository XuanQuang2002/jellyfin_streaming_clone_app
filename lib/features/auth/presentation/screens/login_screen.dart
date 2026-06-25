import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/platform_widget.dart';
import '../../data/models/auth_models.dart';
import '../../domain/providers/auth_provider.dart';
import '../widgets/server_field.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ─── Controllers & Focus ─────────────────────────────────────────────
    final serverController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    final serverFocus = useFocusNode();
    final usernameFocus = useFocusNode();
    final passwordFocus = useFocusNode();

    // ─── Local State ─────────────────────────────────────────────────────
    final obscurePassword = useState(true);
    final serverError = useState<String?>(null);
    final usernameError = useState<String?>(null);
    final passwordError = useState<String?>(null);
    final generalError = useState<String?>(null);

    // ─── Auth State ──────────────────────────────────────────────────────
    final authState = ref.watch(authProvider);
    final isLoading = authState is AsyncLoading;

    // Listen for success → navigate to home
    ref.listen(authProvider, (_, next) {
      next.whenData((state) {
        if (state is AuthStateAuthenticated) {
          context.go(AppRoutes.home);
        }
      });

      // Show error from provider
      if (next is AsyncError) {
        final err = next.error;
        generalError.value = err is AppException
            ? err.message
            : 'Login failed.';
      }
    });

    // ─── Validation ──────────────────────────────────────────────────────
    bool validate() {
      var valid = true;

      final url = serverController.text.trim();
      if (url.isEmpty) {
        serverError.value = 'Server URL is required';
        valid = false;
      } else if (!url.startsWith('http://') && !url.startsWith('https://')) {
        serverError.value = 'URL must start with http:// or https://';
        valid = false;
      } else {
        serverError.value = null;
      }

      if (usernameController.text.trim().isEmpty) {
        usernameError.value = 'Username is required';
        valid = false;
      } else {
        usernameError.value = null;
      }

      if (passwordController.text.isEmpty) {
        passwordError.value = 'Password is required';
        valid = false;
      } else {
        passwordError.value = null;
      }

      return valid;
    }

    // ─── Submit ──────────────────────────────────────────────────────────
    Future<void> submit() async {
      generalError.value = null;
      if (!validate()) return;

      await ref
          .read(authProvider.notifier)
          .login(
            serverUrl: serverController.text.trim(),
            username: usernameController.text.trim(),
            password: passwordController.text,
          );
    }

    // ─── UI ──────────────────────────────────────────────────────────────
    return PlatformWidget(
      ios: (_) => _IosLoginScreen(
        serverController: serverController,
        usernameController: usernameController,
        passwordController: passwordController,
        serverFocus: serverFocus,
        usernameFocus: usernameFocus,
        passwordFocus: passwordFocus,
        obscurePassword: obscurePassword,
        serverError: serverError,
        usernameError: usernameError,
        passwordError: passwordError,
        generalError: generalError,
        isLoading: isLoading,
        onSubmit: submit,
      ),
      android: (_) => _AndroidLoginScreen(
        serverController: serverController,
        usernameController: usernameController,
        passwordController: passwordController,
        serverFocus: serverFocus,
        usernameFocus: usernameFocus,
        passwordFocus: passwordFocus,
        obscurePassword: obscurePassword,
        serverError: serverError,
        usernameError: usernameError,
        passwordError: passwordError,
        generalError: generalError,
        isLoading: isLoading,
        onSubmit: submit,
      ),
    );
  }
}

// ─── Shared Form Fields Widget ────────────────────────────────────────────────

class _LoginFormFields extends StatelessWidget {
  const _LoginFormFields({
    required this.serverController,
    required this.usernameController,
    required this.passwordController,
    required this.serverFocus,
    required this.usernameFocus,
    required this.passwordFocus,
    required this.obscurePassword,
    required this.serverError,
    required this.usernameError,
    required this.passwordError,
    required this.generalError,
    required this.isLoading,
    required this.onSubmit,
    this.isIosStyle = false,
  });

  final TextEditingController serverController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final FocusNode serverFocus;
  final FocusNode usernameFocus;
  final FocusNode passwordFocus;
  final ValueNotifier<bool> obscurePassword;
  final ValueNotifier<String?> serverError;
  final ValueNotifier<String?> usernameError;
  final ValueNotifier<String?> passwordError;
  final ValueNotifier<String?> generalError;
  final bool isLoading;
  final Future<void> Function() onSubmit;
  final bool isIosStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Server URL ───────────────────────────────────────────────────
        ServerUrlField(
          controller: serverController,
          errorText: serverError.value,
          focusNode: serverFocus,
          onSubmitted: (_) => usernameFocus.requestFocus(),
        ),
        const SizedBox(height: 16),

        // ── Username ─────────────────────────────────────────────────────
        AdaptiveTextField(
          controller: usernameController,
          placeholder: 'Username',
          label: 'Username',
          errorText: usernameError.value,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          focusNode: usernameFocus,
          autofillHints: const [AutofillHints.username],
          onSubmitted: (_) => passwordFocus.requestFocus(),
          prefix: PlatformWidget(
            ios: (_) => const Icon(
              CupertinoIcons.person,
              size: 18,
              color: AppColors.textSecondaryDark,
            ),
            android: (_) => const Icon(
              Icons.person_outline,
              size: 20,
              color: AppColors.textSecondaryDark,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Password ─────────────────────────────────────────────────────
        AdaptiveTextField(
          controller: passwordController,
          placeholder: 'Password',
          label: 'Password',
          errorText: passwordError.value,
          obscureText: obscurePassword.value,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          focusNode: passwordFocus,
          autofillHints: const [AutofillHints.password],
          onSubmitted: (_) => onSubmit(),
          prefix: PlatformWidget(
            ios: (_) => const Icon(
              CupertinoIcons.lock,
              size: 18,
              color: AppColors.textSecondaryDark,
            ),
            android: (_) => const Icon(
              Icons.lock_outline,
              size: 20,
              color: AppColors.textSecondaryDark,
            ),
          ),
          suffix: GestureDetector(
            onTap: () => obscurePassword.value = !obscurePassword.value,
            child: PlatformWidget(
              ios: (_) => Icon(
                obscurePassword.value
                    ? CupertinoIcons.eye
                    : CupertinoIcons.eye_slash,
                size: 18,
                color: AppColors.textSecondaryDark,
              ),
              android: (_) => Icon(
                obscurePassword.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
                color: AppColors.textSecondaryDark,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // ── General Error ─────────────────────────────────────────────────
        if (generalError.value != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    generalError.value!,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 24),

        // ── Sign In Button ────────────────────────────────────────────────
        AdaptiveButton(
          label: 'Sign In',
          isLoading: isLoading,
          onPressed: isLoading ? null : onSubmit,
        ),
      ],
    );
  }
}

// ─── iOS Layout ───────────────────────────────────────────────────────────────

class _IosLoginScreen extends StatelessWidget {
  const _IosLoginScreen({
    required this.serverController,
    required this.usernameController,
    required this.passwordController,
    required this.serverFocus,
    required this.usernameFocus,
    required this.passwordFocus,
    required this.obscurePassword,
    required this.serverError,
    required this.usernameError,
    required this.passwordError,
    required this.generalError,
    required this.isLoading,
    required this.onSubmit,
  });

  final TextEditingController serverController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final FocusNode serverFocus;
  final FocusNode usernameFocus;
  final FocusNode passwordFocus;
  final ValueNotifier<bool> obscurePassword;
  final ValueNotifier<String?> serverError;
  final ValueNotifier<String?> usernameError;
  final ValueNotifier<String?> passwordError;
  final ValueNotifier<String?> generalError;
  final bool isLoading;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.backgroundDark,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              // ── Logo & Title ─────────────────────────────────────────
              _LoginHeader(),
              const SizedBox(height: 48),
              // ── Form ─────────────────────────────────────────────────
              _LoginFormFields(
                serverController: serverController,
                usernameController: usernameController,
                passwordController: passwordController,
                serverFocus: serverFocus,
                usernameFocus: usernameFocus,
                passwordFocus: passwordFocus,
                obscurePassword: obscurePassword,
                serverError: serverError,
                usernameError: usernameError,
                passwordError: passwordError,
                generalError: generalError,
                isLoading: isLoading,
                onSubmit: onSubmit,
                isIosStyle: true,
              ),
              const SizedBox(height: 32),
              _LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Android Layout ───────────────────────────────────────────────────────────

class _AndroidLoginScreen extends StatelessWidget {
  const _AndroidLoginScreen({
    required this.serverController,
    required this.usernameController,
    required this.passwordController,
    required this.serverFocus,
    required this.usernameFocus,
    required this.passwordFocus,
    required this.obscurePassword,
    required this.serverError,
    required this.usernameError,
    required this.passwordError,
    required this.generalError,
    required this.isLoading,
    required this.onSubmit,
  });

  final TextEditingController serverController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final FocusNode serverFocus;
  final FocusNode usernameFocus;
  final FocusNode passwordFocus;
  final ValueNotifier<bool> obscurePassword;
  final ValueNotifier<String?> serverError;
  final ValueNotifier<String?> usernameError;
  final ValueNotifier<String?> passwordError;
  final ValueNotifier<String?> generalError;
  final bool isLoading;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              // ── Logo & Title ─────────────────────────────────────────
              _LoginHeader(),
              const SizedBox(height: 48),
              // ── Form ─────────────────────────────────────────────────
              _LoginFormFields(
                serverController: serverController,
                usernameController: usernameController,
                passwordController: passwordController,
                serverFocus: serverFocus,
                usernameFocus: usernameFocus,
                passwordFocus: passwordFocus,
                obscurePassword: obscurePassword,
                serverError: serverError,
                usernameError: usernameError,
                passwordError: passwordError,
                generalError: generalError,
                isLoading: isLoading,
                onSubmit: onSubmit,
              ),
              const SizedBox(height: 32),
              _LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Shared Sub-widgets ───────────────────────────────────────────────────────

class _LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Jellyfin-style logo mark
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.play_circle_filled_rounded,
            color: Colors.white,
            size: 44,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Jellyfin',
          style: TextStyle(
            color: AppColors.textPrimaryDark,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Connect to your media server',
          style: TextStyle(color: AppColors.textSecondaryDark, fontSize: 15),
        ),
      ],
    );
  }
}

class _LoginFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppColors.cardDark),
        const SizedBox(height: 16),
        const Text(
          'Your credentials are stored securely on this device\nand never shared with third parties.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondaryDark,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

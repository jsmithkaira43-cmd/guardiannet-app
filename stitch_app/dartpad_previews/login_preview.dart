// This is a Flutter app for DartPad preview.
// Paste this entire file into https://dartpad.dev to preview the Login screen.
// It uses google_fonts, which DartPad supports via package imports.

import 'package:flutter/material.dart';

// ─── Paste this into DartPad: https://dartpad.dev ───────────────────────────
// Make sure to select "Flutter" mode (top-right dropdown in DartPad)
// ─────────────────────────────────────────────────────────────────────────────

void main() => runApp(const PreviewApp());

class PreviewApp extends StatelessWidget {
  const PreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF031632),
          primary: const Color(0xFF031632),
          secondary: const Color(0xFFB7131A),
          surface: const Color(0xFFF8F9FF),
          background: const Color(0xFFF8F9FF),
        ),
        fontFamily: 'Roboto', // DartPad doesn't support google_fonts package
      ),
      home: const LoginPreviewScreen(),
    );
  }
}

class LoginPreviewScreen extends StatefulWidget {
  const LoginPreviewScreen({super.key});
  @override
  State<LoginPreviewScreen> createState() => _LoginPreviewScreenState();
}

class _LoginPreviewScreenState extends State<LoginPreviewScreen> {
  bool _obscure = true;
  bool _remember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(children: [
                  const Icon(Icons.security, color: Color(0xFF031632), size: 36),
                  const SizedBox(width: 10),
                  Text('GuardianNet',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF031632),
                          letterSpacing: -0.5)),
                ]),
                const SizedBox(height: 40),
                const Text('Welcome Back',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF0B1C30))),
                const SizedBox(height: 6),
                const Text('Access your secure security dashboard.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF44474D))),
                const SizedBox(height: 36),

                // Email
                const Text('CORPORATE EMAIL',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.8, color: Color(0xFF44474D))),
                const SizedBox(height: 8),
                _styledField(hint: 'name@company.com', icon: Icons.mail_outline, obscure: false),
                const SizedBox(height: 20),

                // Password
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('PASSWORD',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.8, color: Color(0xFF44474D))),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?', style: TextStyle(color: Color(0xFFB7131A), fontSize: 12))),
                ]),
                const SizedBox(height: 6),
                _styledField(hint: '••••••••', icon: Icons.lock_outline, obscure: _obscure,
                    suffix: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF75777E)),
                        onPressed: () => setState(() => _obscure = !_obscure))),
                const SizedBox(height: 16),

                // Remember me
                Row(children: [
                  Checkbox(
                    value: _remember,
                    onChanged: (v) => setState(() => _remember = v ?? false),
                    activeColor: const Color(0xFF031632),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  ),
                  const Text('Remember this device', style: TextStyle(color: Color(0xFF44474D), fontSize: 14)),
                ]),
                const SizedBox(height: 28),

                // Sign in button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF031632),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SIGN IN TO DASHBOARD', style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // SSO divider
                Row(children: [
                  Expanded(child: Divider(color: const Color(0xFFC5C6CE))),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('ENTERPRISE SSO', style: TextStyle(fontSize: 11, color: Color(0xFF75777E), letterSpacing: 0.5)),
                  ),
                  Expanded(child: Divider(color: const Color(0xFFC5C6CE))),
                ]),
                const SizedBox(height: 16),

                // SSO Buttons
                Row(children: [
                  Expanded(child: _ssoButton(Icons.g_mobiledata, 'GOOGLE')),
                  const SizedBox(width: 12),
                  Expanded(child: _ssoButton(Icons.business, 'ADFS')),
                ]),
                const SizedBox(height: 32),

                Text.rich(TextSpan(
                  text: 'By logging in, you agree to our ',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF44474D)),
                  children: [
                    TextSpan(text: 'Privacy Policy', style: const TextStyle(color: Color(0xFF031632), decoration: TextDecoration.underline)),
                    const TextSpan(text: ' and '),
                    TextSpan(text: 'System Protocols', style: const TextStyle(color: Color(0xFF031632), decoration: TextDecoration.underline)),
                    const TextSpan(text: '.'),
                  ],
                ), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _styledField({required String hint, required IconData icon, required bool obscure, Widget? suffix}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFB0B3BA)),
        prefixIcon: Icon(icon, color: const Color(0xFF75777E), size: 20),
        suffixIcon: suffix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFC5C6CE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF031632), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

  Widget _ssoButton(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20, color: const Color(0xFF44474D)),
      label: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF44474D), fontWeight: FontWeight.w600)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: const BorderSide(color: Color(0xFFC5C6CE)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

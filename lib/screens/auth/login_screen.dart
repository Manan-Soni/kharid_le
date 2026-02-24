import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/enums/user_role.dart';
import '../../navigation/buyer_navbar.dart';
import '../../providers/auth_provider.dart';
import '../seller/seller_home.dart';

const Color _primaryColor = Color(0xFF6600CC);
const Color _backgroundColor = Color(0xFFF4F5F9);
const Color _titleColor = Color(0xFF151827);
const Color _subtitleColor = Color(0xFF6E717C);
const Color _cardBorderColor = Color(0xFFE2E3EA);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    'assets/app_logo.png',
                    height: 72,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome!',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _titleColor,
                      ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sign in to continue',
                  style: TextStyle(
                    fontSize: 13,
                    color: _subtitleColor,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _cardBorderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _subtitleColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'you@example.com',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: _subtitleColor,
                          ),
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: _subtitleColor,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: _cardBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: _primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _subtitleColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: _subtitleColor,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: _subtitleColor,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: _subtitleColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: _cardBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: _primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password flow.
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: _primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (auth.errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            auth.errorMessage!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFE53935),
                            ),
                          ),
                        ),
                      ],
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            foregroundColor: _backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: auth.isLoading
                              ? null
                              : () async {
                                  FocusScope.of(context).unfocus();

                                  final email = _emailController.text;
                                  final password = _passwordController.text;

                                  await auth.login(email, password);

                                  if (!mounted) return;

                                  if (auth.errorMessage != null) {
                                    return;
                                  }

                                  final role = auth.role;
                                  if (role == null) return;

                                  Widget destination;
                                  if (role == UserRole.seller) {
                                    destination = const SellerHome();
                                  } else {
                                    destination = const BuyerNavbar();
                                  }

                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (_) => destination,
                                    ),
                                    (route) => false,
                                  );
                                },
                          child: auth.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text('Log in'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 0.8,
                              color: _cardBorderColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                fontSize: 12,
                                color: _subtitleColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.8,
                              color: _cardBorderColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            side: const BorderSide(color: _cardBorderColor),
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {
                            // TODO: Implement Google sign-in.
                          },
                          icon: Image.asset(
                            'assets/google_logo.png',
                            width: 20,
                            height: 20,
                            errorBuilder: (context, _, __) {
                              return const Icon(
                                Icons.android,
                                size: 20,
                                color: _subtitleColor,
                              );
                            },
                          ),
                          label: const Text(
                            'SIGN In WITH GOOGLE',
                            style: TextStyle(color: _subtitleColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


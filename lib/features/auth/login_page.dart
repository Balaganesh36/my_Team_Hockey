import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/widgets/app_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  File? _profileImageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Premium Background with Gradient
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/summer-olympic-spotlight-field-hockey-players-engage-fierce-face-off-penalty-corner-seen-up-close-359950061.webp",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black.withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.9),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF1565C0),
                                    Color(0xFF00E676),
                                  ],
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.grey[900],
                                backgroundImage: _profileImageFile != null
                                    ? FileImage(_profileImageFile!)
                                    : const AssetImage(
                                            "assets/images/download.jpeg",
                                          )
                                          as ImageProvider,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF1565C0),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "WELCOME BACK",
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(letterSpacing: 2, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Sign in to continue your journey",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 48),
                      GlassCard(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildTextField(
                                _emailController,
                                "Email Address",
                                Icons.email_outlined,
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                _passwordController,
                                "Password",
                                Icons.lock_outline,
                                obscure: true,
                              ),
                              const SizedBox(height: 32),
                              GradientButton(
                                text: "LOGIN",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFF00E676),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF42A5F5)),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF1565C0)),
        ),
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
      ),
      validator: (v) => v == null || v.isEmpty ? "Required field" : null,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

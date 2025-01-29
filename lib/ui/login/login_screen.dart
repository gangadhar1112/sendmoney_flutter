import 'package:flutter/material.dart';
import 'package:sendmoney_interview/ui/dashboard/dashboard_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _usernameValidated = false;
  bool _passwordValidated = false;
  bool _isLoading = false;

  String? _usernameError;
  String? _passwordError;

  void _validateUsername() {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      _usernameError = 'Please enter a username';
      _usernameValidated = false;
    } else {
      _usernameError = null;
      _usernameValidated = true;
    }
    setState(() {});
  }

  void _validatePassword() {
    if (!_usernameValidated) {
      return;
    }
    final password = _passwordController.text;
    if (password.isEmpty) {
      _passwordError = 'Please enter a password';
      _passwordValidated = false;
    } else if (password.length < 6) {
      _passwordError = 'Password must be at least 6 characters';
      _passwordValidated = false;
    } else {
      _passwordError = null;
      _passwordValidated = true;
    }
    setState(() {});
  }

  Future<void> _handleLogin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isLoading = true;
    });
    _validateUsername();
    _validatePassword();

    if (_usernameValidated && _passwordValidated) {
      // Simulate a login process
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                height: 200,
                'assets/digital_wallet.png',
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.account_circle),
                  errorText: _usernameError,
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  if (_usernameError != null && value.isNotEmpty) {
                    setState(() {
                      _usernameError = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  errorText: _passwordError,
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  if (_passwordError != null && value.isNotEmpty) {
                    setState(() {
                      _passwordError = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: _isLoading ? null : _handleLogin,
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

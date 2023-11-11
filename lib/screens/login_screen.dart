import 'package:flutter/material.dart';
import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 64),
              Image.asset(
                'assets/images/xgram.png',
                color: primaryColor,
                height: 64,
                width: 64,
              ),
              SizedBox(height: 64),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Enter your email...',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_clock_outlined),
                  hintText: 'Enter your password...',
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              SizedBox(height: 24),
              InkWell(
                //onTap: _login,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: primaryButtonColor,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      // Add your navigation logic or action for sign-up here
                    },
                    child: Text(
                      "Sign up.",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

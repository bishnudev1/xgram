import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xgram/providers/user_provider.dart';
import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              const SizedBox(height: 64),
              // Image.asset(
              //   'assets/images/xgram.png',
              //   color: primaryColor,
              //   height: 64,
              //   width: 64,
              // ),
              const Text("Xgram", style: TextStyle(fontSize: 32, color: primaryColor),),
              const SizedBox(height: 64),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Enter your email...',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_clock_outlined),
                  hintText: 'Enter your password...',
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              InkWell(
                //onTap: _login,
                onTap: () {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  if (email.isNotEmpty && password.isNotEmpty) {
                    context
                        .read<UserProvider>()
                        .login(email, password, context);
                  } else {
                    log('Email and password cannot be empty');
                  }
                },
                child:
                    Consumer<UserProvider>(builder: ((context, value, child) {
                  return Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: primaryButtonColor,
                    ),
                    child: value.isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : const Text(
                            'Log in',
                            style: TextStyle(color: Colors.white),
                          ),
                  );
                })),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .navigateToRegisterPage(context);
                    },
                    child: const Text(
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

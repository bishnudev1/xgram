import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xgram/providers/user_provider.dart';
import '../utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                onTap: () {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  if (email.isNotEmpty && password.isNotEmpty) {
                    context.read<UserProvider>().register(email, password, context);
                  }
                  else{
                    log('Email and password cannot be empty');
                  }
                },
                child:
                    Consumer<UserProvider>(builder: ((context, value, child) {
                  return Container(
                    child: value.isLoading
                        ? Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white),
                          ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: primaryButtonColor,
                    ),
                  );
                })),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                           Provider.of<UserProvider>(context, listen: false)
                          .navigateToLoginPage(context);
                    },
                    child: Text(
                      "Sign In.",
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

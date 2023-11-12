import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../services/auth_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    final authServices = AuthServices();
    authServices.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        actions: [
          IconButton(
            onPressed: () {
              final authServices = AuthServices();
              authServices.logout();
              Provider.of<UserProvider>(context, listen: false)
                  .navigateToLoginPage(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(userProvider.user?.name ?? ''),
                Text(userProvider.user?.email ?? ''),
                Text(userProvider.user?.phone ?? ''),
                Text(userProvider.user?.address ?? ''),
                Text(userProvider.user?.city ?? ''),
                Text(userProvider.user?.state ?? ''),
                Text(userProvider.user?.country ?? ''),
                Text(userProvider.user?.pincode ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xgram/models/post.dart';
import 'package:xgram/models/user.dart';

import '../providers/user_provider.dart';
import '../utils/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker picker = ImagePicker();

  final _firestore = FirebaseFirestore.instance.collection("posts").snapshots();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserData();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Xgram',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.heart_broken_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.message_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              StoryBar(),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: _firestore,
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Something went wrong!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    final List<Post> data = List.from(snapshot.data!.docs
                        .map((e) => Post.fromJson(e.data()))
                        .toList());
                    log(data.length.toString());
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ProfileCard(
                                name: "bishnudev_ig",
                                caption: data[index].caption.toString(),
                                image: data[index].imageUrl.toString(),
                                context: context),
                          );
                        },
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      "No Data!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  Widget ProfileCard(
      {required name,
      required image,
      required caption,
      required,
      required BuildContext context}) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(image),
                      ),
                      const SizedBox(width: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(value.fireUser!.email.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(height: 1.0),
                          const Text("Debolina Nandy - Vebe Dekh Mon",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz_outlined,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(image,
                width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border_outlined,
                            color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.message_outlined,
                            color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.send_outlined,
                            color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border_outlined,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Liked by ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal)),
                  Text("bishnudev_ig ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold)),
                  Text("and ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal)),
                  Text("988 others",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5.0),
                  Text(caption.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("View all 100 comments",
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget StoryBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(12, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 1.0,
                          spreadRadius: 2.0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                            spreadRadius: 2.0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/91979889?s=400&u=187ad39fe0973c24808f65c92b7800e9fb10271f&v=4"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Your Story",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

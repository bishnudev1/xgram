import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xgram/providers/post_provider.dart';

import '../services/auth_services.dart';
import '../services/post_services.dart';
import '../utils/img_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String _selectedValue = "None";
  final postServices =
      PostServices(imagePick: ImagePick(), authServices: AuthServices());

  TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "New Post",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Provider.of<PostProvider>(context, listen: false).addPost(
                    desc: captionController.text.trim(), context: context);
              },
              child: const Text(
                "Share",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ))
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<PostProvider>(
            builder: (context, value, child) {
              return value.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: captionController,
                                  decoration: InputDecoration(
                                    hintText: "Write a caption...",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 18,
                                    ),
                                    border: InputBorder.none,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                  ),
                                  style: const TextStyle(
                                      color: Colors
                                          .white), // Set the initial text color to white
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Add Music",
                                style: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 18),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Add Location",
                                style: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 18),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Share to Facebook",
                                style: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 18),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Radio(
                                fillColor:
                                    MaterialStateProperty.all(Colors.blue),
                                activeColor: Colors.blue,
                                value: "Share to Facebook",
                                groupValue: _selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

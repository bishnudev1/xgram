import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:xgram/utils/toast.dart';


class ImagePick {
  XFile? image;

  void hello() {
    log("Hello from Image Pick Class");
  }

  Future<File?> uploadedFile({required desc}) async {
    try {
      if (desc.isEmpty || desc == null || desc.length < 2) {
        showToast("Please add a caption");
        return null;
      }
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      File imageFile = File(image!.path);

      return imageFile;
    } catch (e) {
      // Handle errors, if any
      print('Error picking image: $e');
      return null;
    }
  }
}

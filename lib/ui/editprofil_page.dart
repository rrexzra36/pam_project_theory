import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/ui/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../common/contants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

File? imageFile;

class _EditProfileState extends State<EditProfile> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget buildTextField(
      String labelText,
      String placeholder,
      bool isPasswordTextField,
    ) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: isPasswordTextField ? showPassword : false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: isPasswordTextField
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                      )
                    : null,
                hintText: placeholder,
                hintStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    color: AppColors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        elevation: 0,
        backgroundColor: AppColors.sage300,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
        ),
      ),
      backgroundColor: AppColors.deen,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  children: [
                    _buildImage(imageFile),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: AppColors.sage300,
                        ),
                        child: InkWell(
                          onTap: () {
                            showCameraOptions(context);
                          },
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", "Reyhan Ezra", false),
              buildTextField("Username", "rrexzra", false),
              buildTextField("E-mail", "124210036@student.upnyk.ac.id", false),
              buildTextField("Password", "********", true),
              buildTextField("Confirm Password", "********", true),
              Padding(
                padding: EdgeInsets.only(top: height / 30, bottom: height / 30),
                child: Container(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sage300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(File? imageFile) {
    if (imageFile != null) {
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            width: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(imageFile),
          ),
        ),
      );
    } else {
      return Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Icon(
            Icons.account_circle, // You can choose any avatar icon here
            size: 150,
            color: Colors.grey[400],
          ),
        ),
      );
    }
  }

  void showCameraOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height: 130,
          decoration: const BoxDecoration(
            color: AppColors.deen,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('Pengaturan Foto Profil',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(color: AppColors.black),
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          XFile? imagePicked = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (imagePicked != null) {
                            setState(() {
                              imageFile = File(imagePicked.path);
                            });
                          }
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: AppColors.sage300,
                          size: 35,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(color: AppColors.black),
                            fontSize: 12),
                      )
                    ],
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(
                      onPressed: () async {
                        XFile? imagePicked = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (imagePicked != null) {
                          setState(() {
                            imageFile = File(imagePicked.path);
                          });
                        }
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      icon: const Icon(
                        Icons.photo_library,
                        color: AppColors.sage300,
                        size: 35,
                      ),
                    ),
                    Text(
                      'Gallery',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: AppColors.black), fontSize: 12),
                    )
                  ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          removePhoto(context);
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.sage300,
                          size: 35,
                        ),
                      ),
                      Text(
                        'Remove',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(color: AppColors.black),
                            fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void removePhoto(BuildContext context) {
    setState(() {
      imageFile = null;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

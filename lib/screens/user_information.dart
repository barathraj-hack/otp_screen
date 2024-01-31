import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_app/model/user_model.dart';
import 'package:otp_app/provider/auth_provider.dart';
import 'package:otp_app/screens/home_page.dart';
import 'package:otp_app/utils/utils.dart';
import 'package:otp_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class UserScreenInfo extends StatefulWidget {
  const UserScreenInfo({super.key});

  @override
  State<UserScreenInfo> createState() => _UserScreenInfoState();
}

class _UserScreenInfoState extends State<UserScreenInfo> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25,
                    top: 150,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        // profile
                        InkWell(
                          onTap: () => selectImage(),
                          child: image == null
                              ? const CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  radius: 70,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 90,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: 90,
                                ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              // name field
                              textFeld(
                                hintText: "Enter your name",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: nameController,
                              ),

                              const SizedBox(height: 8),

                              // email
                              textFeld(
                                hintText: "Enter your email address",
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                maxLines: 1,
                                controller: emailController,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // button
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: 50,
                          child: CustomButton(
                            text: "Continue",
                            onPressed: () => storeData(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.purple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black38),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phoneNumber: "",
      profilePic: "",
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
  }
}

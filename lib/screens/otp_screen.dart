import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_app/provider/auth_provider.dart';
import 'package:otp_app/screens/home_page.dart';
import 'package:otp_app/screens/user_information.dart';
import 'package:otp_app/utils/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({
    super.key,
    required this.verificationId,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
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
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        // IMAGE
                        Image.asset(
                          "lib/assets/owl.jpg",
                          height: 250,
                        ),

                        const SizedBox(height: 20),

                        // text
                        Text(
                          "Verification",
                          style: GoogleFonts.outfit(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Enter the OTP send to your phone number",
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            textStyle: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),

                        const SizedBox(height: 25),

                        // button
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: CustomButton(
                            text: "Verify",
                            onPressed: () {
                              if (otpCode != null) {
                                verifyOtp(context, otpCode!);
                              } else {
                                showSnackBar(context, "Enter 6-digit code");
                              }
                            },
                          ),
                        ),

                        const SizedBox(height: 25),

                        Text(
                          "Did't receive any code?",
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Resend New Code",
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.purple,
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

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then((value) async {
          if (value == true) {
            // user exists in our app
            ap.getDataFromFirestore().then(
                  (value) => ap.saveUserDataToSP().then(
                        (value) => ap.setSignIn().then(
                              (value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false),
                            ),
                      ),
                );
          } else {
            // new user
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const UserScreenInfo(),
              ),
              (route) => false,
            );
          }
        });
      },
    );
  }
}

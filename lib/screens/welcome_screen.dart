import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_app/provider/auth_provider.dart';
import 'package:otp_app/screens/home_page.dart';
import 'package:otp_app/screens/register_screen.dart';
import 'package:otp_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              Image.asset(
                "lib/assets/owl.jpg",
                height: 400,
              ),

              const SizedBox(height: 15),

              // text
              Text(
                "Let's Get Started",
                style: GoogleFonts.outfit(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Never a better time than now to start",
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  text: "Get Started",
                  onPressed: () async {
                    if (ap.isSignedIn == true) {
                      await ap.getDataFromSP().whenComplete(
                            () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            ),
                          );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

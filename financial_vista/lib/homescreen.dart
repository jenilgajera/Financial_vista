// import 'package:financial_vista/enterscreem.dart';
import 'package:financial_vista/sign_create.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          // Foreground content
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Container for the image (second image)
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Image.asset(
                    "assets/image/a.png", // Replace with your image path
                    width: MediaQuery.of(context).size.width * 0.9, // Responsive width
                    height: MediaQuery.of(context).size.height * 0.8, // Responsive height
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Swipe to start button container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                child: SwipeableButtonView(
                  buttonText: "SWIPE TO START",
                  buttonWidget: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color.fromARGB(255, 6, 5, 5),
                    ),
                  ),
                  activeColor: const Color.fromARGB(255, 0, 0, 0),
                  isFinished: isFinished,
                  onWaitingProcess: () {
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        isFinished = true;
                      });
                    });
                  },
                  onFinish: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const  SignInScreen(),
                      ),
                    );

                    setState(() {
                      isFinished = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

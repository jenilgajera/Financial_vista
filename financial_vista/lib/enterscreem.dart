import 'package:flutter/material.dart';
void main() =>runApp(const Enterscreen());
class Enterscreen extends StatefulWidget {
  const Enterscreen({super.key});

  @override
  State<Enterscreen> createState() => _EnterscreenState();
}

class _EnterscreenState extends State<Enterscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("welcome agin"),),
    );
  }
}
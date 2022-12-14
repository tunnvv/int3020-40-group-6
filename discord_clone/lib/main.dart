import 'package:discord_clone/screens/home/home_screen.dart';
import 'package:discord_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:discord_clone/screens/welcome/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const DiscordClone());
}

class DiscordClone extends StatelessWidget {
  const DiscordClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Discord',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

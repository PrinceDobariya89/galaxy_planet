import 'dart:async';

import 'package:flutter/material.dart';
import 'package:galaxy_planet/providers/planet_provider.dart';
import 'package:galaxy_planet/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    Provider.of<PlanetProvider>(context, listen: false).fetchData();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0.1))
            .animate(_controller);

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _controller.reverse();
      }else if(status == AnimationStatus.dismissed){
        _controller.forward();
      }
    });
    _controller.forward();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/img/bg.jpg'),
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Galaxy Planet',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              SlideTransition(
                  position: _animation,
                  child: const Image(
                      image: AssetImage('assets/img/astronaut.png'))),
              const Text('Explore The Universe')
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}

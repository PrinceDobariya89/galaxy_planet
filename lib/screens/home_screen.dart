import 'dart:async';

import 'package:flutter/material.dart';
import 'package:galaxy_planet/models/planet.dart';
import 'package:galaxy_planet/providers/planet_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late ScrollController _controller;
  Timer? timer;
  late List<Planet> planet;
  late Animation rotateAnimation;
  int currentIndex = 0;
  int autoScrollDuration = 2;
  @override
  void initState() {
    planet = Provider.of<PlanetProvider>(context,listen: false).planets;
    animate();
    _controller = ScrollController();
    _startAutoScroll();
    super.initState();
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: autoScrollDuration), (timer) {
      if (currentIndex < planet.length - 3) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      _scrollToIndex(currentIndex);
    });
  }

  void _scrollToIndex(int index) {
    if (_controller.hasClients) {
      _controller.animateTo(
        index * 55.0,
        duration: const Duration(seconds: 2),
        curve: Curves.linear,
      );
    }
  }

  void animate() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanetProvider>(context,listen: true);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/bg.jpg'),
                    fit: BoxFit.fill,
                    opacity: 0.9)),
          ),
          Positioned(
            bottom: 50,
            left: 140,
            top: 0,
            child: Opacity(
              opacity: 0.85,
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
                child: Image(
                    image:
                        AssetImage('${planet[provider.selectedIndex].image}')),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.53,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${planet[provider.selectedIndex].name}',
                    style: const TextStyle(
                      letterSpacing: 2,
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RichText(
                      text: TextSpan(text: '\nPosition  ',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500), children: [
                    TextSpan(
                        text: '${planet[provider.selectedIndex].position}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20))
                  ])),
                   RichText(
                      text: TextSpan(text: '\nVelocity  ',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500), children: [
                    TextSpan(
                        text: '${planet[provider.selectedIndex].velocity}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20))
                  ])),
                  RichText(
                      text: TextSpan(text: '\nDistance   ',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500), children: [
                    TextSpan(
                        text: '${planet[provider.selectedIndex].distance}\n',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20))
                  ])),
                  Text('${planet[provider.selectedIndex].description}',
                      textAlign: TextAlign.start),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: planet.length,
                itemBuilder: (context, index) {
                  return RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0)
                        .animate(animationController),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          provider.chageIndex(index);
                        },
                        child: Image(
                          image: AssetImage('${planet[index].image}'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }
}

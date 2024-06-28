import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;
  Color colorBrown = const Color.fromARGB(255, 166, 115, 50);

  @override
  initState() {
    super.initState();

    catController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    catAnimation = Tween(begin: -20.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else {
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none, 
            alignment: Alignment.topCenter,
            children: [
              buildCatAnimation(),
              buildBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation, 
      builder: (context, child) {
        return Positioned(
          top: catAnimation.value,
          left: 0.0,
          right: 0.0,
          child: child!,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      color: colorBrown,
      width: 200.0,
      height: 200.0,
    );
  }
}
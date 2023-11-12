import 'package:flutter/material.dart';
import 'package:pokedex/utils/images.dart';

class CustomLoader extends StatefulWidget {
  final double? loadingWidth;
  final double? loadingHeight;
  const CustomLoader({super.key, this.loadingHeight, this.loadingWidth});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  double rotationAngle = 0.0;

  @override
  void initState() {
    _startLoading();
    super.initState();
  }

  void _startLoading() async {
    int i = 0;
    while (i < 10) {
      await Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          rotationAngle += 1/4;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedRotation(
        turns: rotationAngle,
        duration: const Duration(seconds: 5),
        child: Image.asset(Images.pokeballIcon, width: widget.loadingHeight ?? 100, height: widget.loadingWidth ?? 100,),
      ),
    );
  }
}

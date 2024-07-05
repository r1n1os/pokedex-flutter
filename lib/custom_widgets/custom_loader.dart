import 'package:flutter/material.dart';
import 'package:pokedex/utils/images.dart';

class CustomLoader extends StatefulWidget {
  final double? loadingWidth;
  final double? loadingHeight;

  const CustomLoader({super.key, this.loadingHeight, this.loadingWidth});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double rotationAngle = 0.0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: rotationAngle += 1 / 4,
            child: child,
          );
        },
        child: Image.asset(
          Images.pokeballIcon,
          width: widget.loadingHeight ?? 100,
          height: widget.loadingWidth ?? 100,
        ),
      ),
    );
  }
}

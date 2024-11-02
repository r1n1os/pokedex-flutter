import 'package:flutter/cupertino.dart';

extension NavigationExtention on BuildContext {
  get navigator => Navigator.of(this);

  popNavigation() {
    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  pushNavigation({required Widget screenToNavigate}) {
    navigator.push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screenToNavigate,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return SlideTransition(
            position: tween.animate(curvedAnimation), child: child);
      },
    ));
  }

  pushAndReplaceNavigation({required Widget screenToNavigate}) {
    navigator.pushAndReplace(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        screenToNavigate,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );
          return SlideTransition(
              position: tween.animate(curvedAnimation), child: child);
        },
      ),
    );
  }

  pushAndRemoveUntilNavigation({required Widget screenToNavigate}) {
    navigator.pushAndRemoveUntil({
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        screenToNavigate,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );
          return SlideTransition(
              position: tween.animate(curvedAnimation), child: child);
        },
      ),
    });
  }
}

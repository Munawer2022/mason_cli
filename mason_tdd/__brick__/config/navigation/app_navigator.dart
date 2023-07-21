class AppNavigator {
  // push(BuildContext context, Widget page) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => page,
  //     ),
  //   );
  // //
  // push(BuildContext context, Widget page) {
  // Navigator.of(context).push(
  //           SlideFromRightPageRoute(
  //             widget: page
  //           ),
  //         );
}
// }
// class SlideFromRightPageRoute<T> extends PageRouteBuilder<T> {
//   final Widget widget;

//   SlideFromRightPageRoute({required this.widget})
//       : super(
//           pageBuilder: (BuildContext context, Animation<double> animation,
//               Animation<double> secondaryAnimation) {
//             return widget;
//           },
//           transitionsBuilder: (BuildContext context,
//               Animation<double> animation,
//               Animation<double> secondaryAnimation,
//               Widget child) {
//             const begin = Offset(1.0, 0.0);
//             const end = Offset.zero;
//             const curve = Curves.ease;

//             var tween =
//                 Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);

//             return SlideTransition(
//               position: offsetAnimation,
//               child: child,
//             );
//           },
//         );
// }

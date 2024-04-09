// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart%20';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:jmate/constants/images.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.put(FadeInAnimationController());
//     // controller.startAnimation();

//     var mediaQuery = MediaQuery.of(context);
//     var height = mediaQuery.size.height;
//     var brightness = mediaQuery.platformBrightness;
//     final isDarkMode = brightness == Brightness.dark;
//     return Scaffold(
    
//       body: Stack(
//         children: [
//           Container(
            
//             padding: const EdgeInsets.all(30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Image(
//                   image: const AssetImage(welcomeImage),
//                   height: 0.5 * height,
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       "Journey-Mate".toUpperCase(),
                     
//                       textAlign: TextAlign.center,
//                     ),

//                     // style: GoogleFonts.roboto(),),
//                     Text(
//                       "".toUpperCase(),
//                       style: Theme.of(context).textTheme.headlineSmall,
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                           child: const Text("Login"),
//                           onPressed: () => Get.to(LoginScreen())),
//                     ),
//                     const SizedBox(
//                       width: 10.0,
//                     ),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => Get.to(SignUpScreen()),
//                         child: const Text(signUp),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:test2/auth/ChangePasswordPage.dart';
// import 'package:test2/auth/auth_page.dart';
// import 'package:test2/reservation/user_reservations_page.dart';
// import 'package:test2/services/PdfViewerPage.dart';
// import 'package:test2/video/VideoCategoryPageUser2.dart';
// import 'package:test2/web/gigeoWebViewPage.dart';
// import '../reservation/user_take_reservation_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String pseudo = '';
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchPseudo();
//   }

//   Future<void> fetchPseudo() async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid != null) {
//       final doc =
//           await FirebaseFirestore.instance.collection('users').doc(uid).get();
//       final data = doc.data();
//       if (data != null && data.containsKey('pseudo')) {
//         setState(() {
//           pseudo = data['pseudo'];
//           isLoading = false;
//         });
//       }
//     }
//   }

//   void signOut(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const AuthPage()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       appBar: AppBar(
//         backgroundColor: Colors.red[200],
//         title: const Text('Bienvenue', style: TextStyle(color: Colors.black)),
//         iconTheme: const IconThemeData(color: Colors.black),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: 'Se déconnecter',
//             onPressed: () => signOut(context),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Bonjour, $pseudo 👋',
//                       style: const TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'Que souhaitez-vous faire ?',
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 32),
//                     _UserOptionCard(
//                       icon: Icons.calendar_today,
//                       label: 'Prendre un rendez-vous',
//                       color: Colors.teal,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const ReservationPage()),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     _UserOptionCard(
//                       icon: Icons.history,
//                       label: 'Voir mes rendez-vous',
//                       color: Colors.indigo,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const UserReservationsPage()),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 16),

// // Dans le build de HomePage, ajoutez cette nouvelle Card après les autres
//                     _UserOptionCard(
//                       icon: Icons.shopping_bag,
//                       label: 'Visiter coachgigeo.com',
//                       color: Colors.black, // Couleur Nike
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const GigeoWebViewPage()),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 16),

//                     _UserOptionCard(
//                       icon: Icons.picture_as_pdf,
//                       label: 'Plan Alimentaire',
//                       color: Colors.orange,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => const PdfViewerPage(
//                               pdfPath: 'lib/assets/fichealim.pdf',
//                               pdfName: 'Plan Alimentaire',
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     _UserOptionCard(
//                       icon: Icons.lock,
//                       label: 'Changer mon mot de passe',
//                       color: Colors.red,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const ChangePasswordPage()),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     _UserOptionCard(
//                       icon: Icons.play_circle_fill,
//                       label: 'Vidéo du coach',
//                       color: Colors.green.shade200,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const VideoCategoryPageUser2()),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 16),

//                     // Ajoutez d'autres éléments ici si nécessaire
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

// class _UserOptionCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final VoidCallback onTap;

//   const _UserOptionCard({
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 6,
//       shadowColor: color.withOpacity(0.3),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: color.withOpacity(0.1),
//                 radius: 26,
//                 child: Icon(icon, color: color, size: 26),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const Icon(Icons.arrow_forward_ios_rounded, size: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

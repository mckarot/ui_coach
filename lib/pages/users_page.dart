import 'package:flutter/material.dart';
import 'admin_option_card.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminOptionCard(
          icon: Icons.person_add_alt,
          label: "Créer un nouveau compte",
          color: Colors.teal,
          onTap: null,
        ),
        const SizedBox(height: 16),
        AdminOptionCard(
          icon: Icons.people_alt,
          label: "Voir tous les utilisateurs",
          color: Colors.indigo,
          onTap: null,
        ),
      ],
    );
  }
}

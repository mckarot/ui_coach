import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'admin_option_card.dart';

class RdvPage extends StatelessWidget {
  const RdvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AdminOptionCard(
          icon: Icons.calendar_month,
          label: "Voir les rendez-vous",
          color: Colors.orange,
          onTap: null,
        ),
        SizedBox(height: 16),
        AdminOptionCard(
          icon: Icons.delete,
          label: "Supprimer un rendez-vous",
          color: Colors.red,
          onTap: null,
        ),
        SizedBox(height: 16),
        AdminOptionCard(
          icon: FontAwesomeIcons.whatsapp,
          label: "Supprimer + WhatsApp",
          color: Colors.green,
          onTap: null,
        ),
      ],
    );
  }
}

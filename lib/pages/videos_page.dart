import 'package:flutter/material.dart';
import 'admin_option_card.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminOptionCard(
          icon: Icons.video_collection,
          label: "Gérer les catégories et vidéos",
          color: Colors.blue,
          onTap: null,
        ),
        const SizedBox(height: 16),
        AdminOptionCard(
          icon: Icons.upload_file,
          label: "Uploader une vidéo",
          color: Colors.green,
          onTap: null,
        ),
        const SizedBox(height: 16),
        AdminOptionCard(
          icon: Icons.video_settings,
          label: "Supprimer les vidéos par catégorie",
          color: Colors.purple,
          onTap: null,
        ),
      ],
    );
  }
}

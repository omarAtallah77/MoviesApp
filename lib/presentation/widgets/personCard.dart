import 'package:flutter/material.dart';

import '../../data/models/person_model.dart';

class PersonTile extends StatelessWidget {
  final PersonModel person;
  final VoidCallback? onTap;

  const PersonTile({super.key, required this.person, this.onTap});

  @override
  Widget build(BuildContext context) {
    String? imageUrl = 'https://image.tmdb.org/t/p/w200${person.profilePath}';
    if (person.profilePath == null) {
      imageUrl = null;
    }

    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.broken_image, size: 80),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              person.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

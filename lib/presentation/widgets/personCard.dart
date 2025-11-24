import 'package:flutter/material.dart';

import '../../data/models/person_model.dart';

class PersonTile extends StatelessWidget {
  final PersonModel person;
  final VoidCallback? onTap;

  const PersonTile({super.key, required this.person, this.onTap});

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = person.profilePath != null
        ? 'https://image.tmdb.org/t/p/w200${person.profilePath}'
        : null;

    return InkWell(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : const Icon(Icons.broken_image, size: 80),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              person.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

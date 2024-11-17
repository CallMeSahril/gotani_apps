import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final int stock;
  final bool warning;

  const CategoryCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.stock,
    required this.warning,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => Center(
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            Row(
              children: [
                if (warning) Icon(Icons.warning, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(
                  stock.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: warning ? Colors.amber : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

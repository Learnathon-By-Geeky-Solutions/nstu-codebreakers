import 'package:flutter/material.dart';

Widget priorityTaskCard({
  required Color color,
  required IconData icon,
  required String title,
  required int days,
  required double progress,
}) {
  return Container(
    width: 150,
    margin: const EdgeInsets.only(right: 15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 20,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$days days',
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        const Text(
          'Progress',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: Colors.white24,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        const SizedBox(height: 5),
        Text(
          progress < 100
              ? '${(progress).toStringAsFixed(0)}% completed'
              : 'Completed',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
      ],
    ),
  );
}

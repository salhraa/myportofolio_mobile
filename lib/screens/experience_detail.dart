import 'package:material_ui/material_ui.dart';

import '../models/experience.dart';

class ExperienceDetailPage extends StatelessWidget {
  final Experience experience;

  const ExperienceDetailPage({super.key, required this.experience});

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experience Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.work_outline, size: 48),
            const SizedBox(height: 16),

            Text(
              experience.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),

            Chip(label: Text(experience.category)),
            const SizedBox(height: 20),

            const Text(
              'Deskripsi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(experience.description),
            const SizedBox(height: 24),

            const Text(
              'Periode',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            Text('Mulai: ${_formatDate(experience.startedAt)}'),
            const SizedBox(height: 8),

            Text(
              'Selesai: ${experience.isOngoing ? 'Masih berlangsung' : _formatDate(experience.endedAt)}',
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                const Icon(Icons.star),
                const SizedBox(width: 8),
                Text('${experience.starCount} stars'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

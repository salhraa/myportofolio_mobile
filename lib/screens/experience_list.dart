import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/experience.dart';
import '../providers/auth_state.dart';
import 'experience_detail.dart';

class ExperienceListPage extends StatefulWidget {
  const ExperienceListPage({super.key});

  @override
  State<ExperienceListPage> createState() => _ExperienceListPageState();
}

class _ExperienceListPageState extends State<ExperienceListPage> {
  late Future<List<Experience>> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<AuthState>().getExperiences();
  }

  Future<void> _refresh() async {
    final future = context.read<AuthState>().getExperiences();

    setState(() {
      _future = future;
    });

    await future;
  }

  void _retry() {
    setState(() {
      _future = context.read<AuthState>().getExperiences();
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Experiences')),
      body: FutureBuilder<List<Experience>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Gagal memuat Experiences.'),
                    const SizedBox(height: 8),
                    Text('${snapshot.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _retry,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final experiences = snapshot.data ?? [];

          if (experiences.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('Belum ada Experience.')),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final experience = experiences[index];

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: Text(experience.title),
                    subtitle: Text(
                      '${experience.category} • '
                      '${_formatDate(experience.startedAt)}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExperienceDetailPage(experience: experience),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:myportofolio_mobile/providers/auth_state.dart';
import 'package:myportofolio_mobile/models/skill.dart';

class SkillsList extends StatefulWidget {
  const SkillsList({super.key});

  @override
  State<SkillsList> createState() => _SkillsListState();
}

class _SkillsListState extends State<SkillsList> {
  late Future<List<Skill>> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<AuthState>().getSkills();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = context.read<AuthState>().getSkills();
    });
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Skill>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Gagal memuat Skills: ${snapshot.error}'));
        }

        final skills = snapshot.data ?? [];

        if (skills.isEmpty) {
          return const Center(child: Text('Belum ada Skills.'));
        }

        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skill = skills[index];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(skill.name),
                  subtitle: Text('${skill.level} • ${skill.description}'),
                  trailing: Text('★ ${skill.starCount}'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

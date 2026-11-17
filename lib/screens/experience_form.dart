
import 'package:material_ui/material_ui.dart';
import '../widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _category;
  DateTime? _startedAt;
  DateTime? _endedAt;
  bool _isOngoing = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startedAt ?? DateTime.now())
          : (_endedAt ?? _startedAt ?? DateTime.now()),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startedAt = picked;
          if (_endedAt != null && _endedAt!.isBefore(picked)) {
            _endedAt = null;
          }
        } else {
          _endedAt = picked;
        }
      });
    }
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_startedAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal mulai wajib diisi.')),
      );
      return;
    }

    if (!_isOngoing && _endedAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal selesai wajib diisi.')),
      );
      return;
    }

    if (!_isOngoing && _endedAt!.isBefore(_startedAt!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal selesai tidak boleh sebelum tanggal mulai.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ringkasan Pengalaman'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama/Jabatan: ${_titleController.text}'),
              const SizedBox(height: 8),
              Text('Deskripsi: ${_descriptionController.text}'),
              const SizedBox(height: 8),
              Text('Kategori: $_category'),
              const SizedBox(height: 8),
              Text('Tanggal Mulai: ${_formatDate(_startedAt)}'),
              const SizedBox(height: 8),
              Text(
                'Tanggal Selesai: ${_isOngoing ? 'Masih berlangsung' : _formatDate(_endedAt)}',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengalaman'),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pengalaman / Jabatan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama pengalaman wajib diisi.';
                  }
                  if (value.trim().length > 100) {
                    return 'Maksimal 100 karakter.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi wajib diisi.';
                  }
                  if (value.trim().length > 1000) {
                    return 'Maksimal 1000 karakter.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'internship',
                    child: Text('Internship'),
                  ),
                  DropdownMenuItem(
                    value: 'research',
                    child: Text('Research'),
                  ),
                  DropdownMenuItem(
                    value: 'volunteer',
                    child: Text('Volunteer'),
                  ),
                  DropdownMenuItem(
                    value: 'part-time',
                    child: Text('Part-time'),
                  ),
                  DropdownMenuItem(
                    value: 'full-time',
                    child: Text('Full-time'),
                  ),
                  DropdownMenuItem(
                    value: 'freelance',
                    child: Text('Freelance'),
                  ),
                ],
                onChanged: (value) {
                  setState(() => _category = value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori wajib dipilih.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tanggal Mulai'),
                subtitle: Text(_formatDate(_startedAt)),
                trailing: const Icon(Icons.calendar_month),
                onTap: () => _pickDate(true),
              ),

              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Masih berlangsung'),
                value: _isOngoing,
                onChanged: (value) {
                  setState(() {
                    _isOngoing = value ?? false;
                    if (_isOngoing) _endedAt = null;
                  });
                },
              ),

              if (!_isOngoing)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Tanggal Selesai'),
                  subtitle: Text(_formatDate(_endedAt)),
                  trailing: const Icon(Icons.calendar_month),
                  onTap: _startedAt == null ? null : () => _pickDate(false),
                ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

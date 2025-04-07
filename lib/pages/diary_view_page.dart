import 'package:flutter/material.dart';
import 'package:vizeeeee/models/diary_entry.dart';
import 'package:vizeeeee/services/diary_service.dart';
import 'package:vizeeeee/widgets/custom_drawer.dart';

class DiaryViewPage extends StatefulWidget {
  final DiaryEntry? diaryEntry;
  final String? userId;

  const DiaryViewPage({super.key, this.diaryEntry, this.userId});

  @override
  State<DiaryViewPage> createState() => _DiaryViewPageState();
}

class _DiaryViewPageState extends State<DiaryViewPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final DiaryService _diaryService = DiaryService();
  String _selectedMood = 'Happy';
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = widget.diaryEntry?.userId ?? widget.userId ?? '';
    
    if (widget.diaryEntry != null) {
      _titleController.text = widget.diaryEntry!.title;
      _contentController.text = widget.diaryEntry!.content;
      _selectedMood = widget.diaryEntry!.mood;
    }
  }

  Future<void> _saveDiary() async {
    if (_formKey.currentState!.validate()) {
      final entry = DiaryEntry(
        id: widget.diaryEntry?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        userId: _userId,
        title: _titleController.text,
        content: _contentController.text,
        date: widget.diaryEntry?.date ?? DateTime.now(),
        mood: _selectedMood,
      );

      if (widget.diaryEntry != null) {
        await _diaryService.updateDiary(entry);
      } else {
        await _diaryService.addDiary(entry);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diary+',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save,
              color: Colors.amber,
              size: 30,
            ),
            onPressed: _saveDiary,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal.shade900,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.teal.shade700,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal.shade700,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal.shade400,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: _selectedMood,
                  items: ['Happy', 'Sad', 'Angry', 'Excited', 'Tired']
                      .map((mood) => DropdownMenuItem(
                    value: mood,
                    child: Text(
                      mood,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.teal.shade800,
                      ),
                    ),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedMood = value!),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal.shade900,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Mood',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.teal.shade700,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal.shade400,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal.shade700,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  dropdownColor: const Color(0xFFE0F7FA),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.teal.shade700,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Content',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.teal.shade400,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withValues(alpha: 40),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _contentController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.teal.shade900,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write your diary content here...',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
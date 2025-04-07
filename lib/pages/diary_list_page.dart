import 'package:flutter/material.dart';
import 'package:vizeeeee/models/diary_entry.dart';
import 'package:vizeeeee/services/diary_service.dart';
import 'package:vizeeeee/widgets/custom_drawer.dart';
import 'package:vizeeeee/pages/diary_view_page.dart';

class DiaryListPage extends StatefulWidget {
  const DiaryListPage({super.key});

  @override
  State<DiaryListPage> createState() => _DiaryListPageState();
}

class _DiaryListPageState extends State<DiaryListPage> {
  final DiaryService _diaryService = DiaryService();
  List<DiaryEntry> _diaries = [];
  bool _isLoading = true;
  late String _userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = ModalRoute.of(context)?.settings.arguments as String?;
      if (userId != null) {
        setState(() {
          _userId = userId;
        });
        _loadDiaries();
      }
    });
  }

  Future<void> _loadDiaries() async {
    final allDiaries = await _diaryService.getDiaries();
    setState(() {
      // Filter diaries to only show entries from the current user
      _diaries = allDiaries.where((diary) => diary.userId == _userId).toList();
      _isLoading = false;
    });
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
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.teal,
            strokeWidth: 3,
          ),
        )
            : _diaries.isEmpty
            ? Center(
          child: Text(
            'No diaries yet. Tap + to add one!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.teal.shade800,
            ),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _diaries.length,
          itemBuilder: (context, index) {
            final diary = _diaries[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.teal.withOpacity(0.1),
                  radius: 24,
                  child: Icon(
                    _getMoodIcon(diary.mood),
                    color: _getMoodColor(diary.mood),
                    size: 28,
                  ),
                ),
                title: Text(
                  diary.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_formatDate(diary.date)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            _getMoodIcon(diary.mood),
                            color: _getMoodColor(diary.mood),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            diary.mood,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal.shade800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.teal.shade700,
                  size: 32,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiaryViewPage(diaryEntry: diary),
                  ),
                ).then((_) => _loadDiaries()),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiaryViewPage(userId: _userId),
          ),
        ).then((_) => _loadDiaries()),
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.white,
        elevation: 6,
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }

  IconData _getMoodIcon(String mood) {
    switch (mood) {
      case 'Happy':
        return Icons.sentiment_very_satisfied;
      case 'Sad':
        return Icons.sentiment_very_dissatisfied;
      case 'Angry':
        return Icons.mood_bad;
      case 'Excited':
        return Icons.celebration;
      case 'Tired':
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Happy':
        return Colors.green;
      case 'Sad':
        return Colors.blue;
      case 'Angry':
        return Colors.red;
      case 'Excited':
        return Colors.orange;
      case 'Tired':
        return Colors.grey;
      default:
        return Colors.teal;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
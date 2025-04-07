import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:vizeeeee/models/diary_entry.dart';

class DiaryService {
  Future<File> get _file async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/diaries.json');
  }

  Future<List<DiaryEntry>> getDiaries() async {
    try {
      final file = await _file;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> json = jsonDecode(contents);
        return json.map((e) => DiaryEntry.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> addDiary(DiaryEntry diary) async {
    final diaries = await getDiaries();
    diaries.add(diary);
    await _saveDiaries(diaries);
  }

  Future<void> updateDiary(DiaryEntry diary) async {
    final diaries = await getDiaries();
    final index = diaries.indexWhere((d) => d.id == diary.id);
    if (index != -1) {
      diaries[index] = diary;
      await _saveDiaries(diaries);
    }
  }

  Future<void> _saveDiaries(List<DiaryEntry> diaries) async {
    final file = await _file;
    await file.writeAsString(jsonEncode(diaries.map((e) => e.toJson()).toList()));
  }
}
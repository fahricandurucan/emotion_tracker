import 'package:emotion_tracker/const/const.dart';
import 'package:emotion_tracker/services/database_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryPageController extends GetxController {
  late RxList<Map<String, dynamic>> emotions;
  late RxInt positiveEmotionCount;
  late RxInt negativeEmotionCount;
  late RxString firstEmotionDate;
  late RxString lastEmotionDate;

  @override
  void onInit() {
    super.onInit();
    emotions = <Map<String, dynamic>>[].obs;
    positiveEmotionCount = 0.obs;
    negativeEmotionCount = 0.obs;
    firstEmotionDate = ''.obs;
    lastEmotionDate = ''.obs;
    _loadEmotions();
  }

  Future<void> _loadEmotions() async {
    try {
      final DatabaseHelper databaseHelper = DatabaseHelper();
      final List<Map<String, dynamic>> loadedEmotions = await databaseHelper.getEmotions();

      emotions.assignAll(loadedEmotions);
      updateEmotionCounts();
      updateFirstAndLastEmotionDates();
    } catch (e) {
      print('Error loading emotions: $e');
    }
  }

  void updateEmotionCounts() {
    positiveEmotionCount.value =
        emotions.where((e) => Const.positiveEmotion.contains(e["emotion"])).length;
    negativeEmotionCount.value =
        emotions.where((e) => Const.negativeEmotion.contains(e["emotion"])).length;
  }

  void updateFirstAndLastEmotionDates() {
    if (emotions.isNotEmpty) {
      emotions.sort((a, b) {
        DateTime dateTimeA = DateTime.parse(a["timestamp"]);
        DateTime dateTimeB = DateTime.parse(b["timestamp"]);
        return dateTimeA.compareTo(dateTimeB);
      });

      firstEmotionDate.value = _formatTimeStamp(emotions.first["timestamp"]);
      lastEmotionDate.value = _formatTimeStamp(emotions.last["timestamp"]);
    }
  }

  String _formatTimeStamp(String timeStamp) {
    DateTime dateTime = DateTime.parse(timeStamp);
    return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
  }

  Future<void> deleteAllAndRefresh() async {
    try {
      final DatabaseHelper databaseHelper = DatabaseHelper();
      await databaseHelper.deleteAllEmotions();
      await _loadEmotions();
    } catch (e) {
      print('Error deleting emotions: $e');
    }
  }
}

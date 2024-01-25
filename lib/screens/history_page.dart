import 'package:emotion_tracker/const/const.dart';
import 'package:emotion_tracker/controllers/history_page_controller.dart';
import 'package:emotion_tracker/services/database_helper.dart';
import 'package:emotion_tracker/widgets/emotion_statistics_card.dart';
import 'package:emotion_tracker/widgets/history_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/alert_dialog_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Map<String, dynamic>> emotions;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  HistoryPageController historyPageController = Get.put(HistoryPageController());

  @override
  void initState() {
    super.initState();
    emotions = [];
    _loadEmotions();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -5.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
  }

  Future<void> _loadEmotions() async {
    final loadedEmotions = await databaseHelper.getEmotions();
    setState(() {
      emotions = loadedEmotions;
    });
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.forward();
  }

  Future<bool> _confirmDeleteDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialogWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emotions.isEmpty
          ? null
          : AppBar(
              centerTitle: true,
              title: const Text('Emotion History', style: TextStyle(color: Color(0xff292D32))),
              actions: [
                IconButton(
                  onPressed: () async {
                    bool confirmed = await _confirmDeleteDialog();
                    if (confirmed) {
                      await historyPageController.deleteAllAndRefresh();
                      setState(() {
                        _loadEmotions();
                      });
                    }
                  },
                  icon: Image.asset(
                    "assets/delete.png",
                    width: 24,
                    color: const Color(0xff292D32),
                  ),
                ),
              ],
            ),
      body: emotions.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/placeholder.gif",
                  width: Const.screenWidth(context) * 0.2,
                  height: Const.screenWidth(context) * 0.2,
                ),
                SizedBox(
                  height: Const.screenHight(context) * 0.015,
                ),
                const Text('There is no past feeling yet.'),
              ],
            ))
          : Column(
              children: [
                Expanded(
                  child: AnimatedList(
                    initialItemCount: emotions.length,
                    itemBuilder: (context, index, animation) {
                      return SlideTransition(
                        position: _offsetAnimation,
                        child: HistoryListItem(emotion: emotions[index]),
                      );
                    },
                  ),
                ),
                EmotionStatisticsCard(),
              ],
            ),
    );
  }
}

import 'package:emotion_tracker/const/const.dart';
import 'package:emotion_tracker/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Emotion History'),
      ),
      body: emotions.isEmpty
          ? const Center(child: Text('Henüz geçmiş hissiyat bulunmuyor.'))
          : AnimatedList(
              initialItemCount: emotions.length,
              itemBuilder: (context, index, animation) {
                return SlideTransition(
                  position: _offsetAnimation,
                  child: _buildItem(emotions[index]),
                );
              },
            ),
    );
  }

  Widget _buildItem(Map<String, dynamic> emotion) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Const.positiveEmotion.contains(emotion["emotion"])
          ? const Color.fromARGB(255, 175, 230, 255)
          : const Color.fromARGB(255, 255, 151, 144),
      child: ListTile(
        title: Text(
          emotion["emotion"],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          _formatTimeStamp(emotion["timestamp"]),
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        onTap: () {
          // Tıklanabilir olduğunda ek bir işlev ekleyebilirsiniz
        },
      ),
    );
  }

  String _formatTimeStamp(String timeStamp) {
    DateTime dateTime = DateTime.parse(timeStamp);
    return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
  }
}

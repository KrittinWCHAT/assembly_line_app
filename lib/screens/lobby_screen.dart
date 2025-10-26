import 'package:flutter/material.dart';
import 'assembly_list_screen.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Assembly Line', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo)),
                SizedBox(height: 12),
                Text('จัดการข้อมูลสายการผลิต', textAlign: TextAlign.center),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: Icon(Icons.play_arrow),
                  label: Text('Start'),
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14), shape: StadiumBorder()),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => AssemblyListScreen()));
                  },
                ),
                SizedBox(height: 18),
                Text('', textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
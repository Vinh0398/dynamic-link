import 'package:flutter/material.dart';

class NotiDetailPage extends StatefulWidget {
  final String? notificationsId;

  NotiDetailPage({
    Key? key,
    this.notificationsId,
  }) : super(key: key);

  @override
  State<NotiDetailPage> createState() => _NotiDetailPageState();
}

class _NotiDetailPageState extends State<NotiDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NOTI DETAIL PAGE",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "This is Notifications Detail Page ${widget.notificationsId}",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
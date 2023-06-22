import 'package:dynamic_link/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  final List notificationsList = List.generate(20, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "NOTI PAGE",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: notificationsList.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () => _onTap(index),
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "This is notification ${notificationsList[index]}"),
                  ),
                ),
              ),
            );
          },
        ));
  }

  void _onTap(int notificationsId) {
    final path =
        "${GoRouter.of(context).location}/${RoutePath.notificationsDetailPath}/$notificationsId";
    context.go(path);
  }
}
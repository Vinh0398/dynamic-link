import 'package:dynamic_link/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final listNews = List.generate(50, (index) => index).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HOME PAGE",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listNews.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () => _onTapItem(index),
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("This is a news ${listNews[index]}"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTapItem(int newsId) {
    final path =
        "${GoRouter.of(context).location}/${RoutePath.newsDetailPath}/$newsId";
    context.go(path);
  }
}
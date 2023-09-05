import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:story_app/providers/api_provider.dart';

class DetailStory extends StatefulWidget {
  static String routeName = "/detail";
  final String storyId;
  const DetailStory({super.key, required this.storyId});

  @override
  State<DetailStory> createState() => _DetailStoryState();
}

class _DetailStoryState extends State<DetailStory> {
  @override
  void initState() {
    super.initState();

    final dataProvider = Provider.of<ApiProvider>(context, listen: false);
    dataProvider.detailStory(widget.storyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Story'),
      ),
      body: Consumer<ApiProvider>(
        builder: (context, data, child) {
          if (data.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var story = data.detailStoryResult.story;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(story.photoUrl,
                      fit: BoxFit.cover, height: 250, width: double.infinity),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          story.name,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                        Text(DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
                            .format(story.createdAt)),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(story.description),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:story_app/screens/add_story.dart';

class ListStory extends StatelessWidget {
  const ListStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StoryApp'),
        automaticallyImplyLeading: false,
      ),
      body: const Text('data'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStory()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

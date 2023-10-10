import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/providers/api_provider.dart';
import 'package:story_app/screens/add_story.dart';

class ListStory extends StatefulWidget {
  static String routeName = "/list";
  const ListStory({
    super.key,
  });

  @override
  State<ListStory> createState() => _ListStoryState();
}

class _ListStoryState extends State<ListStory> {
  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Tidak"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ya"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        if (context.mounted) GoRouter.of(context).pushNamed("login");
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Konfirmasi"),
      content:
          const Text("Apakah anda yakin ingin keluar dari aplikasi StoryApp?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    final dataProvider = Provider.of<ApiProvider>(context, listen: false);
    dataProvider.allStory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('StoryApp'),
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              showAlertDialog(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: Consumer<ApiProvider>(
        builder: (context, data, child) {
          if (data.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return data.listStoryResult.listStory.isEmpty
                ? const Center(child: Text('No data found'))
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(10),
                    itemCount: data.listStoryResult.listStory.length,
                    itemBuilder: (BuildContext context, int index) {
                      var story = data.listStoryResult.listStory[index];
                      return ListTile(
                        onTap: () {
                          context.go('/detail/${story.id}');
                        },
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        leading: Image.network(
                          story.photoUrl,
                          fit: BoxFit.cover,
                          width: 100,
                          errorBuilder: (ctx, error, _) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                        title: Text(
                          story.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              story.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(story.createdAt.toString())
                          ],
                        ),
                      );
                    });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add');
          Navigator.pushNamed(context, AddStory.routeName)
              .then((value) => setState(() {
                    final dataProvider =
                        Provider.of<ApiProvider>(context, listen: false);
                    dataProvider.allStory();
                  }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/providers/api_provider.dart';
import 'package:story_app/screens/add_story.dart';
import 'package:story_app/screens/login.dart';

import '../utils/constant.dart';

class ListStory extends StatefulWidget {
  const ListStory({super.key});

  @override
  State<ListStory> createState() => _ListStoryState();
}

class _ListStoryState extends State<ListStory> {
  String accessToken = "";

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
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

  void getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString(keyToken)!;
    });
  }

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ApiProvider>(context, listen: false);
    dataProvider.allStory(accessToken);
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
          } else if (data.errorMessage.isEmpty) {
            return const Center(
              child: Text('No Internet Connection'),
            );
          } else {
            return data.listStoryResult!.listStory.isEmpty
                ? const Center(child: Text('No data found'))
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(10),
                    itemCount: data.listStoryResult!.listStory.length,
                    itemBuilder: (BuildContext context, int index) {
                      var story = data.listStoryResult!.listStory[index];
                      return ListTile(
                        onTap: () {},
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        leading: Image.network(
                          story.photoUrl,
                          width: 120,
                          errorBuilder: (ctx, error, _) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                        title: Text(story.name),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.pin_drop),
                                Text(story.description),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(story.name),
                              ],
                            )
                          ],
                        ),
                      );
                    });
          }
        },
      ),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/core/api_client.dart';
import 'package:story_app/models/list_story.dart';
import 'package:story_app/providers/api_provider.dart';
import 'package:story_app/utils/constant.dart';

class ListStoryPage extends StatefulWidget {
  const ListStoryPage({
    super.key,
  });

  @override
  State<ListStoryPage> createState() => _ListStoryPageState();
}

class _ListStoryPageState extends State<ListStoryPage>
    with WidgetsBindingObserver {
  final ApiClient _apiClient = ApiClient();
  List<ListStory> _listStory = [];
  int _page = 1;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  final ScrollController _scrollController = ScrollController();

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Tidak"),
      onPressed: () {
        context.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ya"),
      onPressed: () async {
        if (context.mounted) context.pushReplacementNamed('login');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(keyIsLogin, false);
        prefs.clear();
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

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      ListStoryResult res = await _apiClient.allStory(_page);
      setState(() {
        _listStory = res.listStory;
      });
    } catch (e) {
      throw Exception(e);
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      setState(() {
        _page += 1;
      });
      try {
        ListStoryResult res = await _apiClient.allStory(_page);
        if (res.listStory.isNotEmpty) {
          setState(() {
            _listStory.addAll(res.listStory);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (e) {
        throw Exception(e);
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _firstLoad();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(10),
                itemCount: _listStory.length,
                itemBuilder: (BuildContext context, int index) {
                  var story = _listStory[index];
                  return ListTile(
                    onTap: () {
                      context.pushNamed('detail',
                          pathParameters: {'storyId': story.id});
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(story.createdAt.toString())
                      ],
                    ),
                  );
                }),
            if (_isFirstLoadRunning == true)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (_isLoadMoreRunning == true)
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 40),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),

            // When nothing else to load
            if (_hasNextPage == false)
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'You have fetched all of the content',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('add').then((value) => setState(() {
                _firstLoad();
              }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

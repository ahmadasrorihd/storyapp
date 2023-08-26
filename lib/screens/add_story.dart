import 'package:flutter/material.dart';

class AddStory extends StatefulWidget {
  static String routeName = "/add";
  const AddStory({super.key});

  @override
  State<AddStory> createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Story'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              color: Colors.black,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  height: 46.0,
                  minWidth: 100,
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {},
                  child: const Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  height: 46.0,
                  minWidth: 100,
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {},
                  child: const Text(
                    "Gallery",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 120,
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Description",
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              height: 46.0,
              minWidth: double.infinity,
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {},
              child: const Text(
                "Upload",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

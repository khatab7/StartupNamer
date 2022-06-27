import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'package:startup_namer/savedFav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const RandomWords(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  void updateUi() {
    setState(() {});
  }

  var suggestions = <WordPair>[];
  List<WordPair>? suggestion;
  var saved = <WordPair>{};
  final biggerFont = const TextStyle(fontSize: 18);
  void _pushSaved() {
    var route = MaterialPageRoute(
      builder: (context) => Favorit(
        saved: saved,
        updateui: updateUi,
      ),
    );
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          var index = i ~/ 2;
          if (index >= suggestions.length) {
            suggestions.addAll(generateWordPairs().take(10));
          }
          final alreadySaved = saved.contains(suggestions[index]);
          return ListTile(
              title: Text(
                suggestions[index].asPascalCase,
                style: biggerFont,
              ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
                semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
              ),
              onTap: () {
                setState(() {
                  if (alreadySaved) {
                    saved.remove(suggestions[index]);
                  } else {
                    saved.add(suggestions[index]);
                  }
                });
              });
        },
      ),
    );
  }
}

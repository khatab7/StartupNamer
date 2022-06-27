import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class Favorit extends StatefulWidget {
  Set<WordPair> saved;

  VoidCallback? updateui;

  Favorit({
    Key? key,
    required this.saved,
    required this.updateui,
  }) : super(key: key);

  @override
  State<Favorit> createState() => _FavoritState();
}

class _FavoritState extends State<Favorit> {
  late dynamic children;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tiles = widget.saved.map(
      (pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                widget.saved.remove(pair);
                widget.updateui!();
                setState(() {});

                Navigator.pop(context);
              });
            },
          ),
        );
      },
    );

    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
        : <Widget>[];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved fav'),
      ),
      body: ListView(children: divided),
    );
  }
}

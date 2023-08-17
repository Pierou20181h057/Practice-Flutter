import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // final wordPair = WordPair.random();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandomWord(),
    );
  }
}
class RandomWord extends StatefulWidget {
  const RandomWord({Key? key}) : super(key: key);

  @override
  State<RandomWord> createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {
  final List<WordPair> suggestions = <WordPair>[];
  final TextStyle biggerFont = TextStyle(fontSize:  18);
  final Set<WordPair> saved = Set<WordPair>();


  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return Scaffold(
        appBar: AppBar(
          title: Text("generador de palabras"),
          actions: <Widget>[
            IconButton(
                onPressed: pushSaved, icon: Icon(Icons.list_alt_sharp))

          ],
        ),
    body: buildSuggestions(),);
  }
  Widget buildSuggestions(){

    return ListView.builder(
        padding : EdgeInsets.all(16),
        itemBuilder: (BuildContext, int i) {
          if (i.isOdd){
            return Divider(color: Colors.blue, thickness: 4,);
          }
          final int  index = i ~/2;
          if (index >= suggestions.length){
            suggestions.addAll(generateWordPairs().take(10));
          }
          return buildRow(suggestions[index]);
        }
        );
  }
  Widget buildRow(WordPair pair){
    final bool alreadysaved = saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase,
          style: biggerFont),
      trailing: Icon(
        alreadysaved ? Icons.favorite : Icons.favorite_border,
        color: alreadysaved ? Colors.red : null,

      ),
      onTap: (){
        setState(() {
          alreadysaved ? saved.remove(pair) : saved.add(pair);
        });
      },
    );
  }

  void pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context){
            final Iterable<ListTile> tiles =saved.map(
                (WordPair pair){
                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style:biggerFont,
                    ),
                  );
                },
            );
        final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles).toList();
            return Scaffold(
              appBar: AppBar(
                title: Text("Mis palabras favoritas!"),
              ),
              body: ListView(
                children: (divided),
              ),
            );
    },),
    );
  }
}


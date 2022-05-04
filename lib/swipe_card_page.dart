import 'package:flutter/material.dart';
import 'package:swipe_card_flutter/content.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeCardPage extends StatefulWidget {
  const SwipeCardPage({Key? key}) : super(key: key);

  @override
  State<SwipeCardPage> createState() => _SwipeCardPageState();
}

class _SwipeCardPageState extends State<SwipeCardPage> {
  late MatchEngine _matchEngine;
  late List<SwipeItem> _SwipeItems;
  late bool _isNoItem = false;

  void reset() {
    _SwipeItems = [];
    for (var content in contents) {
      var swipeItem = SwipeItem(
        content: content,
      );
      _SwipeItems.add(swipeItem);
    }

    _matchEngine = MatchEngine(swipeItems: _SwipeItems);
    _isNoItem = false;
  }

  @override
  void initState() {
    reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                reset();
              });
            },
            icon: const Icon(Icons.restore),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: _isNoItem
            ? const Center(
                child: Text('No Item'),
              )
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 20),
                    child: SwipeCards(
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Center(child: Text(contents[index].title)),
                          color: contents[index].color,
                        );
                      },
                      matchEngine: _matchEngine,
                      onStackFinished: () {
                        print('onStackFinished');
                        setState(() {
                          _isNoItem = true;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          _matchEngine.currentItem!.nope();
                        },
                        child: const Icon(Icons.close),
                        backgroundColor: Colors.red,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          _matchEngine.currentItem!.like();
                        },
                        child: const Icon(Icons.check),
                        backgroundColor: Colors.green,
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }
}

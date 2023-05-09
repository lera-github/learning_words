import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({Key? key}) : super(key: key);

  @override
  _FlashcardsScreenState createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  List<Flashcard> flashcards = [];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  void initializeFirebase() async {
    await Firebase.initializeApp();
    final snapshot = await FirebaseFirestore.instance.collection('modules').get();
    setState(() {
      flashcards = snapshot.docs.map((doc) => Flashcard(doc['word'], doc['translation'])).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = (currentIndex + 1) % flashcards.length;
                  });
                },
                child: FlashcardWidget(
                  flashcard: flashcards[currentIndex],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentIndex = (currentIndex + 1) % flashcards.length;
                  });
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;

  const FlashcardWidget({
    required this.flashcard,
  });

  @override
  _FlashcardWidgetState createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipAnimationController;
  late final Animation<double> _flipAnimation;

  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _flipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _flipAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_flipAnimationController);
  }

  @override
  void dispose() {
    _flipAnimationController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    if (_isFlipped) {
      _flipAnimationController.reverse();
    } else {
      _flipAnimationController.forward();
    }

    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (BuildContext context, Widget? child) {
        final frontOpacity = _isFlipped ? 0.0 : 1.0;
        final backOpacity = _isFlipped ? 1.0 : 0.0;

        return Stack(
          fit: StackFit.expand,
          children: [
            // Front of// the flashcard
Positioned.fill(
    child: Opacity(
    opacity: frontOpacity,
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Colors.blue,
),
child: Center(
    child: Text(
     widget.flashcard.front,
     style: const TextStyle(
        fontSize: 32,
        color: Colors.white,
      ),
    ),
),
),
),
),
        // Back of the flashcard
        Positioned.fill(
          child: Opacity(
            opacity: backOpacity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  widget.flashcard.back,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Flip button
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _toggleFlip,
            child: Icon(Icons.flip),
          ),
        ),
      ],
    );
  },
);
}
}

class Flashcard {
final String front;
final String back;

Flashcard(this.front, this.back);
}

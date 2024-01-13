import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FAQScreen extends StatefulWidget {
  final String username;

  const FAQScreen({super.key, required this.username});
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'What is the purpose of the Travel Planner app?',
      answer:
          'The Travel Planner app is designed to assist users in organizing and planning their travel itineraries efficiently. It helps users manage their trips, including destinations, activities, accommodations, and more.',
    ),
    FAQItem(
      question: 'How do I create a new itinerary?',
      answer:
          'To create a new itinerary, navigate to the "Create Itinerary" section and fill in the required details such as destination, dates, and activities.',
    ),
    FAQItem(
      question: 'Can I customize my travel itinerary?',
      answer:
          'Yes, the app allows full customization of your travel itinerary. You can add, edit, or remove destinations, activities, and accommodation details according to your preferences.',
    ),
    FAQItem(
      question: 'Is there a feature to track my expenses during the trip?',
      answer:
          'Certainly! The Travel Planner app includes a budgeting feature that enables you to track and manage your expenses. Input your estimated and actual expenses to stay within your travel budget.',
    ),
    // Add more FAQ items as needed
  ];

  TextEditingController userQuestionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B5998),
        title: const Text('FAQ'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                return FAQExpansionTile(faqItems[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: userQuestionController,
              decoration: const InputDecoration(
                hintText: 'Ask a question...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _question();
              String userQuestion = userQuestionController.text;
              if (userQuestion.isNotEmpty) {
                // Optionally, you can clear the text field after submission
                userQuestionController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3B5998),
              fixedSize: const Size(300, 60),
            ),
            child: const Text(
              'Submit Question',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Future<void> _question() async {
    if (userQuestionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Write down the Question!!'),
        ),
      );
    } else {
      final url = Uri.https(
          'travel-planner-32bb6-default-rtdb.asia-southeast1.firebasedatabase.app',
          'UserData/${widget.username}/UserQuestion.json');
      final response = await http.post(
        url,
        body: json.encode(
          {
            'Question': userQuestionController.text,
          },
        ),
      );

      if (response.statusCode != 200) {
        print('Failed to save data');
        // Handle error as needed
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Question Submitted'),
          ),
        );
      }
    }
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQExpansionTile extends StatefulWidget {
  final FAQItem faqItem;

  FAQExpansionTile(this.faqItem);

  @override
  State<FAQExpansionTile> createState() => _FAQExpansionTileState();
}

class _FAQExpansionTileState extends State<FAQExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(widget.faqItem.question),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.faqItem.answer),
          ),
        ],
      ),
    );
  }
}

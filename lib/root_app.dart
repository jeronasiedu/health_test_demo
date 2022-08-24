import 'package:flutter/material.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int totalScore = 1;
  List questions = [
    {
      "title": "What's the pulse?",
      "score": 4,
      "answer": AnswerOptions.no,
    },
    {
      "title": "Had P.E before?",
      "score": 6,
      "answer": AnswerOptions.no,
    },
    {
      "title": "Any Hemoptysis?",
      "score": 2,
      "answer": AnswerOptions.no,
    },
    {
      "title": "Any Unilateral lower limb pain?",
      "score": 1,
      "answer": AnswerOptions.no,
    },
    {
      "title": "Active Malignancy?",
      "score": 1,
      "answer": AnswerOptions.no,
    },
    {
      "title": "Any surgery involving the limbs?",
      "score": 1,
      "answer": AnswerOptions.no,
    },
    {
      "title": "Age more than 65 years?",
      "score": 1,
      "answer": AnswerOptions.no,
    },
    {
      "title":
          "Pain on lower limb deep venous palpation & unilateral swelling?",
      "score": 1,
      "answer": AnswerOptions.no,
    },
  ];
  var buttonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    elevation: 0,
  );
  final pageController = PageController(
    initialPage: 1,
  );
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health App'),
        centerTitle: true,
      ),
      body: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        itemCount: questions.length,
        controller: pageController,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  '${index + 1}. ${questions[index]["title"]}',
                  style: Theme.of(context).textTheme.headline6!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                RadioListTile(
                  title: const Text('No'),
                  value: AnswerOptions.no,
                  groupValue: questions[index]['answer'] as AnswerOptions,
                  onChanged: (AnswerOptions? value) {
                    setState(() {
                      questions[index]['answer'] = value;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Yes'),
                  value: AnswerOptions.yes,
                  groupValue: questions[index]['answer'] as AnswerOptions,
                  onChanged: (AnswerOptions? value) {
                    setState(() {
                      questions[index]['answer'] = value;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        height: 70,
        width: double.infinity,
        color: Theme.of(context).secondaryHeaderColor,
        child: currentPageIndex == questions.length - 1
            ? ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  for (var element in questions) {
                    if (element['answer'] == AnswerOptions.yes) {
                      totalScore += element['score'] as int;
                    }
                  }
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Result'),
                        content: Text(
                          'Total Score: $totalScore',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Submit'),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
      ),
    );
  }
}

enum AnswerOptions { yes, no }

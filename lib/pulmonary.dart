import 'package:flutter/material.dart';
import 'package:health/data/pulmonary_questions.dart';

class Pulmonary extends StatefulWidget {
  const Pulmonary({Key? key}) : super(key: key);

  @override
  State<Pulmonary> createState() => _PulmonaryState();
}

class _PulmonaryState extends State<Pulmonary> {
  num totalScore = 0;
  void handleSelection(int builderIndex, int index) {
    setState(() {
      for (var i = 0;
          i < questions[builderIndex]['selectedOptions']!.length;
          i++) {
        questions[builderIndex]['selectedOptions'][i] = index == i;
        if (questions[builderIndex]['selectedOptions'][i]) {
          totalScore += questions[builderIndex]['score'][i];
        }
      }
    });
  }

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
        title: const Text('Pulmonary'),
      ),
      body: PageView.builder(
        itemCount: questions.length,
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        itemBuilder: (context, builderIndex) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  "${builderIndex + 1}. ${questions[builderIndex]['title']}",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const Spacer(),
                ToggleButtons(
                  direction: Axis.vertical,
                  selectedBorderColor: Colors.orange[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.orange[400],
                  borderRadius: BorderRadius.circular(10),
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: questions[builderIndex]['selectedOptions'],
                  onPressed: (index) {
                    handleSelection(builderIndex, index);
                  },
                  children: List.generate(
                    questions[builderIndex]['options'].length,
                    (listIndex) {
                      return Text(
                        questions[builderIndex]['options'][listIndex],
                      );
                    },
                  ),
                ),
                const Spacer(),
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
                onPressed: () {},
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
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
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

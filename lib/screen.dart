import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variables for performing operations
  double a = 0.0;
  double b = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClic(value) {
    //If AC is Tapped
    if (value == "AC") {
      input = '';
      output = '';
    }

    //If < backButton is Tapped
    else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");

        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();

        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 48;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Input Output Fields
        Expanded(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //INPUT

              Text(
                hideInput ? '' : input,
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
              const SizedBox(height: 4),

              //OUTPUT
              Text(
                output,
                style: TextStyle(
                    fontSize: outputSize, color: Colors.white.withOpacity(0.7)),
              ),
              const SizedBox(height: 30),
            ],
          ),
        )),

        //Button Area

        //Row1
        Row(
          children: [
            buttonDigit('AC', bgclr: buttonclr, tcolor: orangeclr),
            buttonDigit('<', bgclr: buttonclr, tcolor: orangeclr),
            buttonDigit(''),
            buttonDigit('/', bgclr: operatorclr, tcolor: orangeclr),
          ],
        ),
        //Row2
        Row(
          children: [
            buttonDigit('7'),
            buttonDigit('8'),
            buttonDigit('9'),
            buttonDigit('x', bgclr: operatorclr, tcolor: orangeclr),
          ],
        ),

        //Row3
        Row(
          children: [
            buttonDigit('4'),
            buttonDigit('5'),
            buttonDigit('6'),
            buttonDigit('-', bgclr: operatorclr, tcolor: orangeclr),
          ],
        ),

        //Row4
        Row(
          children: [
            buttonDigit('1'),
            buttonDigit('2'),
            buttonDigit('3'),
            buttonDigit('+', bgclr: operatorclr, tcolor: orangeclr),
          ],
        ),

        //Row5
        Row(
          children: [
            buttonDigit('%', bgclr: operatorclr, tcolor: orangeclr),
            buttonDigit('.', bgclr: operatorclr, tcolor: orangeclr),
            buttonDigit('0'),
            buttonDigit('=', tcolor: operatorclr, bgclr: orangeclr),
          ],
        ),
      ],
    );
  }

  Widget buttonDigit(String text, {tcolor = Colors.white, bgclr = buttonclr}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22),
            backgroundColor: bgclr,
          ),
          onPressed: () => onButtonClic(text),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: tcolor,
            ),
          ),
        ),
      ),
    );
  }
}

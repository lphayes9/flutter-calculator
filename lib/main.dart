import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else if (buttonText == '=') {
        try {
          // Evaluate the expression
          Expression expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          var evalResult = evaluator.eval(expression, {});
          _result = evalResult.toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += buttonText;
      }
    });
  }

  Widget _buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.blue,
            padding: EdgeInsets.all(20),
          ),
          onPressed: () => _onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator - Lily Hayes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'),
                    _buildButton('C', color: Colors.red),
                    _buildButton('=', color: Colors.green),
                    _buildButton('+', color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

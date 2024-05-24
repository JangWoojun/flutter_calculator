import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),),
      home: const CalculatorHomePage(title: 'Calculator'),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _currentInput = "";
  double _currentResult = 0;
  String _operator = "";
  String _calculation = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _currentResult = 0;
        _operator = "";
        _calculation = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        if (_currentInput.isNotEmpty) {
          if (_operator.isNotEmpty) {
            _calculate();
          } else {
            _currentResult = double.parse(_currentInput);
          }
          _operator = buttonText;
          _calculation = '$_calculation $_currentInput $buttonText';
          _currentInput = "";
          _output = _calculation;
        }
      } else if (buttonText == "=") {
        if (_currentInput.isNotEmpty && _operator.isNotEmpty) {
          _calculate();
          _calculation = '$_calculation $_currentInput = $_currentResult';
          _output = _currentResult.toString();
          _currentInput = _currentResult.toString();
          _operator = "";
        }
      } else {
        _currentInput += buttonText;
        _output = _calculation.isEmpty ? _currentInput : '$_calculation $_currentInput';
      }
    });
  }

  void _calculate() {
    double num = double.parse(_currentInput);
    if (_operator == "+") {
      _currentResult += num;
    } else if (_operator == "-") {
      _currentResult -= num;
    } else if (_operator == "×") {
      _currentResult *= num;
    } else if (_operator == "÷") {
      _currentResult /= num;
    }
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          child: Text(buttonText, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(_calculation, style: const TextStyle(fontSize: 24, color: Colors.grey), textAlign: TextAlign.right,),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(_output, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: ["7", "8", "9", "÷"].map((btnText) => _buildButton(btnText)).toList(),
              ),
              Row(
                children: ["4", "5", "6", "×"].map((btnText) => _buildButton(btnText)).toList(),
              ),
              Row(
                children: ["1", "2", "3", "-"].map((btnText) => _buildButton(btnText)).toList(),
              ),
              Row(
                children: [".", "0", "C", "+"].map((btnText) => _buildButton(btnText)).toList(),
              ),
              Row(
                children: [_buildButton("=")],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

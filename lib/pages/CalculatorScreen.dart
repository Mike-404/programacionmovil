import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '';
  double _firstNumber = 0.0;
  double _secondNumber = 0.0;
  String _operator = '';

  void _appendNumber(String number) {
    setState(() {
      _displayText += number;
    });
  }

  void _setOperator(String operator) {
    setState(() {
      _operator = operator;
      _firstNumber = double.parse(_displayText);
      _displayText = '';
    });
  }

  void _calculateResult() {
    setState(() {
      _secondNumber = double.parse(_displayText);
      double result = 0.0;

      switch (_operator) {
        case '+':
          result = _firstNumber + _secondNumber;
          break;
        case '-':
          result = _firstNumber - _secondNumber;
          break;
        case '÷':
          result = _firstNumber / _secondNumber;
          break;
        case '×':
          result = _firstNumber * _secondNumber;
          break;
      }

      _displayText = result.toString();
    });
  }

  void _clearDisplay() {
    setState(() {
      _displayText = '';
      _firstNumber = 0.0;
      _secondNumber = 0.0;
      _operator = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 40,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('7'),
              _buildNumberButton('8'),
              _buildNumberButton('9'),
              _buildOperatorButton('÷'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('4'),
              _buildNumberButton('5'),
              _buildNumberButton('6'),
              _buildOperatorButton('×'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('1'),
              _buildNumberButton('2'),
              _buildNumberButton('3'),
              _buildOperatorButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('0'),
              _buildOperatorButton('+'),
              _buildOperatorButton('='),
              _buildClearButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => _appendNumber(number),
      child: Text(number),
    );
  }

  Widget _buildOperatorButton(String operator) {
    return ElevatedButton(
      onPressed: () {
        if (operator == '=') {
          _calculateResult();
        } else {
          _setOperator(operator);
        }
      },
      child: Text(operator),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton(
      onPressed: _clearDisplay,
      child: Text('C'),
    );
  }
}





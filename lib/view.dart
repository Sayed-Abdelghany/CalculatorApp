import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List <String> buttons = [
    'C', 'Del', '%', '/',
    '9', '8', '7', '*',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'Ans', '=',
  ];
  String input = 'input';
  String output = 'output';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 140,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(input,style: TextStyle(fontSize: 18),),
                      ),
                      SizedBox(height: 40,),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(output,style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            if (index ==0){
                              setState(() {
                                input = '';
                                output ='';
                              });
                            }
                            else if (index ==1){
                              setState(() {
                                input = input.substring(0,input.length-1);
                              });
                            }
                            else if (buttons[index]=='Ans'){
                              setState(() {
                                input = output;
                              });
                            }
                            else if (isOperator(buttons[index])){
                              if (input.endsWith('*')||
                                  input.endsWith('+')||
                                  input.endsWith('-')||
                                  input.endsWith('/')||
                                  input.endsWith('%')||
                                  input.endsWith('='))
                              {
                                print('No operator Available');
                              } else if (buttons[index]=='='){
                                try{
                                  Expression exp = Parser().parse(input);
                                  double result =exp.evaluate(EvaluationType.REAL, ContextModel());
                                  setState(() {
                                    output = result.toString();
                                  });
                                }catch(error){
                                  print(error);
                                  print(input);
                                }

                              }
                              else{
                                setState(() {
                                  input = input+buttons[index];
                                });
                              }
                            }
                            else {
                              setState(() {
                                input = input+buttons[index];
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: contentColor(buttons[index]),
                            ),
                            child: Center(
                              child: Text(buttons[index], style: TextStyle(
                                fontSize: 25,fontWeight: FontWeight.bold,
                                color: textColor(buttons[index]),),
                              ),
                            ),
                          ),
                        )
                    );
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }

  bool isOperator(String button) {
    if (button == '%' || button == '/' ||
        button == '-' || button == '+' ||
        button == '*' || button == '=') {
      return true;
    } else {
      return false;
    }
  }

  Color contentColor(String button) {
    if (button == 'C') {
      return Colors.green;
    }
    else if (button == 'Del') {
      return Colors.red;
    } else if (isOperator(button) == true) {
      return Colors.blue;
    } else {
      return Colors.grey[400];
    }
  }

  Color textColor(String button) {
    if (isOperator(button) == true || button == 'C' || button == 'Del') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}

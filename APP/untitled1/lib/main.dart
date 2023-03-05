import 'dart:convert';

import 'package:flutter/material.dart';

import 'fetch_data.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  String url = "";
  var data;
  var input = "";
  var output = "";
  
  onButtonClick(value){
    if(value == "AC"){
      input = "";
      output = "";
    }
    else if(value == "X"){
      if(input.isNotEmpty){
        input = input.substring(0, input.length - 1);
      }
    }
    else{
      input = input + value ;
      url = 'http://10.0.2.2:5000/API?query='+input.toString();
    }
    setState(() {});
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flask Calculator"),backgroundColor: Colors.grey,),
      backgroundColor: Colors.black,
      body: Column(
        children: [


          SizedBox(
            height: 601,

            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 601*0.3),
                  height: 500,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(104,104,104,979),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24),)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            button(text: "AC", BackG: Colors.grey, textColor: Colors.white),
                      Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: ()=> onButtonClick("X"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                              child: Icon(Icons.backspace, color: Colors.white,)
                            ),
                          )
                      ),
                            button(text: "/",BackG: Color.fromRGBO(31, 81,255,10), textColor: Colors.blue),
                            button(text: "*", BackG: Color.fromRGBO(31, 81,255,10), textColor: Colors.blue)
                          ],
                        ),
                        Row(
                          children: [
                            button(text: "7"),
                            button(text: "8"),
                            button(text: "9"),
                            button(text: "-", BackG: Color.fromRGBO(31, 81,255,10), textColor: Colors.blue)
                          ],
                        ),
                        Row(
                          children: [
                            button(text: "4"),
                            button(text: "5"),
                            button(text: "6"),
                            button(text: "+", BackG: Color.fromRGBO(31, 81,255,10), textColor: Colors.blue)
                          ],
                        ),
                        Row(
                          children: [
                            button(text: "1"),
                            button(text: "2"),
                            button(text: "3"),
                            button(text: "%", BackG: Color.fromRGBO(31, 81,255,10), textColor: Colors.blue)
                          ],
                        ),
                        Row(
                          children: [
                            button(text: ""),
                            button(text: "0"),
                            button(text: "."),
                            //button(text: "=", BackG: Colors.blue, textColor: Colors.white),
                  Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            data = await fetchdata(url);
                            var decoded = jsonDecode(data);
                            setState(() {
                              output = decoded['output'];
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          child: Text("=" , style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      )
                  )
                          ],
                        ),
                      ],
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    children: [
                      //SizedBox(height: 60,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //SizedBox(width: 280,),
                          Text(input, style: TextStyle(color: Colors.white,fontSize: 50),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //SizedBox(width: 300,),
                          Text(output, style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 30),)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget button({
  text, textColor = Colors.blue, BackG = Colors.black12
}){
    return Expanded(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () => onButtonClick(text),
            style: ElevatedButton.styleFrom(
                backgroundColor: BackG,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            child: Text(text , style: TextStyle(
              fontSize: 25,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),),
          ),
        )
    );
  }
}



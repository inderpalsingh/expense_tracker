import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePgae extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String dropValue = 'This month';

    var dropValueItems = [
      'This month',
      'Pre month',
      'Next month',
    ];

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Monety', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                Icon(Icons.search_outlined, size: 30)
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircleAvatar(
                child: Icon(Icons.person_outline),
              ),
              const SizedBox(width: 10),
              const Padding(
                padding: EdgeInsets.only(right: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Morning'),
                    Text('Inderpal Singh'),
                  ],
                ),
              ),
              DropdownButton(
                value: dropValue,
                items: dropValueItems.map((String dropValueItems) {
                  return DropdownMenuItem(
                      value: dropValueItems, child: Text(dropValueItems));
                }).toList(),
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            width: 800,
            decoration: BoxDecoration(
                color: const Color(0xFF5a68cc),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total expense',style: TextStyle(color: Colors.white, fontSize: 16)),
                      CircleAvatar(
                        radius: 15,backgroundColor: Color(0xFF7984d6),foregroundColor: Colors.white,
                        child: Icon(Icons.more_horiz_rounded),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text('\$3,734 ',style: TextStyle(color: Colors.white, fontSize: 20)),
                      Text('/ \$4000 per month',style: TextStyle(color: Color(0xFF0afb7e7), fontSize: 15)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      Container(
                        height: 10,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF04e5bb3),
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ],
                  ),
                  
                ],
                
              ),
            ),
          ),
          
        ],
      ),
    ));
  }
}

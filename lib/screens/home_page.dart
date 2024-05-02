import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePgae extends StatefulWidget {
  @override
  State<HomePgae> createState() => _HomePgaeState();
}

class _HomePgaeState extends State<HomePgae> {
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
                Text('Monety', style:TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
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
                      value: dropValueItems, child: Text(dropValueItems,style: const TextStyle(fontSize: 15)));
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
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total expense', style: TextStyle(color: Colors.white, fontSize: 16)),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xFF7984d6),
                        foregroundColor: Colors.white,
                        child: Icon(Icons.more_horiz_rounded),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text('\$3,734 ', style: TextStyle(color: Colors.white, fontSize: 20)),
                      Text('/ \$4000 per month', style: TextStyle(color: Color(0xff0afb7e7), fontSize: 15)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Container(
                        height: 10,
                        width: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xFF04e5bb3),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Expense Breakdown', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
              DropdownButton(
                value: dropValue,
                items: dropValueItems.map((String dropValueItems) {
                  return DropdownMenuItem(
                    
                      value: dropValueItems, child: Text(dropValueItems,style: const TextStyle(fontSize: 15),));
                }).toList(),
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(
            width: double.infinity,
              child: Text('Limit \$900 / week', style: TextStyle( fontSize: 18))
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: Image.asset('images/bar.png'),
          ),
          Container(
            margin: const EdgeInsets.only(right: 210),
            child: const Text('Spending Details', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: const EdgeInsets.only(right: 60),
            child: const Text('Your expenses are divided into 6 categories', style: TextStyle( fontSize: 15)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.30,
                    color: const Color(0xff0545fb7),
                    
                  ),
                  const Text('40%', style: TextStyle( color: Colors.black)),
                ],
                
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.20,
                    color: const Color(0xFF0e27fb4),
                  ),
                  const Text('25%', style: TextStyle( color: Colors.black)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.15,
                    color: const Color(0xFF0e8be83),
                  ),
                  const Text('15%', style: TextStyle( color: Colors.black)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.10,
                    color: const Color(0xFF05ab9d5),
                  ),
                  const Text('10%', style: TextStyle( color: Colors.black)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.05,
                    color: const Color(0xff0d55959),
                  ),
                  const Text('5%', style: TextStyle( color: Colors.black)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.05,
                    color: const Color(0xff059d589),
                  ),
                  const Text('5%', style: TextStyle( color: Colors.black)),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: 'Notify'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        
      ),
    );
  }
}

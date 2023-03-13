import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map<String, Object?> data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty? data : ModalRoute.of(context)?.settings.arguments as Map<String, Object?>;
    print(data);    

    String bgImage = data['isDayTime'] as bool ? 'day.png' : 'night.png';
    Color topBarBackColor = data['isDayTime'] as bool ? Color.fromARGB(255, 18, 136, 200) : Color.fromARGB(255, 40, 39, 97);

    return Scaffold(
      backgroundColor: topBarBackColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = result != null ? {
                        'location': result['location'],
                        'time': result['time'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime']
                      } : data;
                    });
                  }, 
                  icon: Icon(Icons.edit_location, color: Colors.grey[300],), 
                  label: Text('Edit Location', style: TextStyle(color: Colors.grey[300]),)),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'] as String,
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    data['time'] as String,
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
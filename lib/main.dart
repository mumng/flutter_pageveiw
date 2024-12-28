import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final PageController _controller = PageController(viewportFraction: 0.8);

  @override
  void initState(){
    super.initState();
    _controller.addListener((){
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inspirational Moments', style:TextStyle(color:Colors.white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              _buildPage(
                imageUrl: 'assets/images/image1.webp',
                userName: 'mumng',
                avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg'
              ),
              _buildPage(
                  imageUrl: 'assets/images/image2.webp',
                  userName: 'lee',
                  avatarUrl: 'https://randomuser.me/api/portraits/men/2.jpg'
              ),
              _buildPage(
                  imageUrl: 'assets/images/image3.webp',
                  userName: 'kim',
                  avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg'
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                List.generate(3, (index) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal:2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.blue : Colors.white60
                    ),
                  );
                })
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPage({
  required String imageUrl,
  required String userName,
  required String avatarUrl
}){
  return Stack(
    children: [
      Positioned.fill(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        )
      ),
      Positioned(
        bottom: 50,
        left: 20,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
            ),
            SizedBox(width: 15),
            Text(
                userName,
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
            )
          ],
        ),
      ),
    ],
  );
}
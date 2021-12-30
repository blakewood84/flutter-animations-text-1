import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int index = 0;

  @override
  Widget build(BuildContext context) {

    final Size size  = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [

            TextAnimations(number: this.index),

            // Text Icons
            Positioned(
              bottom: 60,
              left: 20,
              child: Container(
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      splashRadius: 1.0,
                      onPressed: () {
                        setState(() {
                          index++;
                        });
                      }, 
                      icon: const Icon(Icons.arrow_circle_up_outlined, size: 50)
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      splashRadius: 1.0,
                      onPressed: () {
                        setState(() {
                          index--;
                        });
                      }, 
                      icon: const Icon(Icons.arrow_circle_down_outlined, size: 50)
                    )
                  ],
                ),
              )
            )
          ],
        )
      )
    );
  }
}

class TextAnimations extends StatefulWidget {

  const TextAnimations({ required this.number, Key? key }) : super(key: key);

  final int number;

  @override
  _TextAnimationsState createState() => _TextAnimationsState();
}

class _TextAnimationsState extends State<TextAnimations> with SingleTickerProviderStateMixin {

  late AnimationController _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700), lowerBound: 0, upperBound: 1);

  late Animation _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

  @override
  void initState() {
    super.initState();
    _animationController.addListener(() {
      print(_animationController.value);
    });
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant TextAnimations oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if(oldWidget.number != this.widget.number) {
      _animationController.reset();
      _animationController.forward();
    }
  }


  @override
  Widget build(BuildContext context) {

    final Size size  = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(size.width * .45, size.height - (_animationController.value * 450 )),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              child: Text(
                '${this.widget.number}',
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.normal,
                ),
              )
            ),
          ),
        );
      }
    );
  }
}

// Text(
//   '${this.widget.number}',
//   style: const TextStyle(
//     fontSize: 80,
//     fontWeight: FontWeight.normal,
//   ),
// )
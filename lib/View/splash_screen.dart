import 'dart:async';
import 'dart:math' as math;
import 'package:covid_19_tracker_td/View/worldstate.dart';
// import 'package:covid_tracker/world_state.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync:this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 5),()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> WorldState())));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Image(image: AssetImage('images/virus.png')),
                ),
                builder: (BuildContext context,Widget ? child){
                  return Transform.rotate(angle: _controller.value * 2.0 * math.pi,child: child);
                }),
            SizedBox(height:MediaQuery.of(context).size.height * .08),
            const Align(
              alignment: Alignment.center,
              child: Text('Covie-19\n Tracker App',textAlign: TextAlign.center,style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 25
              ),),
            )
          ],
        ),
      ),
    );
  }
}

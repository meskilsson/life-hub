import 'package:flutter/material.dart';

import './animated_menu.dart';

class AnimationDemoPage extends StatefulWidget {
  const AnimationDemoPage({super.key});

  @override
  State<AnimationDemoPage> createState() => _AnimationDemoPageState();
}

class _AnimationDemoPageState extends State<AnimationDemoPage> {
  bool _expanded = false;
  bool _messageVisible = true;
  bool _messageMoved = false;
  bool _isPressed = false;
  bool _isSwitched = false;
  bool _showDetails = false;
  bool _isOnRight = false;
  double _targetWeight = 70;
  bool _extraAir = false;
  bool _isPaused = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 2000),
                curve: Curves.bounceOut,
                width: _expanded ? 220 : 100,
                height: _expanded ? 220 : 100,
                decoration: BoxDecoration(
                  color: _expanded ? Colors.lightBlue : Colors.lightGreen,
                  borderRadius: _expanded
                      ? BorderRadius.circular(20)
                      : BorderRadius.horizontal(
                          left: Radius.elliptical(12, 50),
                          right: Radius.elliptical(12, 50),
                        ),
                ),
                child: AnimatedSlide(
                  duration: Duration(milliseconds: 400),
                  offset: _messageMoved ? Offset(1, 0) : Offset(0, 1),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _messageVisible ? 0.2 : 1,
                    child: const Text(
                      'Visible message',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    child: Text('Toggle size'),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(colors.error),
                    ),
                    onPressed: () {
                      setState(() {
                        _messageVisible = !_messageVisible;
                      });
                    },
                    child: Text(
                      'Hide message',
                      style: TextStyle(color: colors.secondary),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _messageMoved = !_messageMoved;
                      });
                    },
                    child: Text('Move offset'),
                  ),
                  GestureDetector(
                    onTapUp: (_) {
                      setState(() {
                        _isPressed = false;
                      });
                    },
                    onTapDown: (_) {
                      setState(() {
                        _isPressed = true;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _isPressed = false;
                      });
                    },
                    child: AnimatedRotation(
                      duration: Duration(milliseconds: 1500),
                      turns: _isPressed ? 1 : 0,
                      child: AnimatedScale(
                        duration: Duration(milliseconds: 1500),
                        scale: _isPressed ? 0.5 : 1.0,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(24),
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber,
                          ),

                          child: AnimatedSlide(
                            offset: _isPressed
                                ? const Offset(0, -0.5)
                                : Offset.zero,
                            duration: Duration(milliseconds: 700),
                            curve: Curves.bounceOut,
                            child: const Icon(Icons.arrow_forward, size: 64),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSwitched = !_isSwitched;
                  });
                },
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: Icon(
                    key: ValueKey(_isSwitched),
                    _isSwitched ? Icons.favorite : Icons.favorite_border,
                    size: 64,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showDetails = !_showDetails;
                  });
                },
                child: Container(
                  width: 300,
                  color: Colors.pinkAccent,
                  padding: EdgeInsets.all(24),
                  child: AnimatedSize(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _showDetails
                            ? Text(
                                'En animation hjälper användaren att förstå vad som förändras på '
                                'skärmen. När det här kortet växer blir det tydligt att mer innehåll '
                                'visas. Du behöver inte bestämma höjden själv, eftersom Flutter mäter '
                                'innehållet och anpassar utrymmet efter texten. Tryck på kortet igen '
                                'för att dölja detaljerna och se hur det mjukt krymper tillbaka.',
                              )
                            : Text('Visa innehåll'),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isOnRight = !_isOnRight;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(8),
                  color: _isOnRight ? Colors.green : Colors.grey,
                  child: AnimatedAlign(
                    alignment: _isOnRight
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear,
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.indigo,
                      ),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        switchInCurve: Curves.linear,
                        switchOutCurve: Curves.linear,
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Icon(
                          key: ValueKey(_isOnRight),
                          _isOnRight ? Icons.check : Icons.close,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 70, end: _targetWeight),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Text('${value.toStringAsFixed(1)}');
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _targetWeight += 5;
                      });
                    },
                    child: const Text('Öka med 5'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _targetWeight -= 5;
                      });
                    },
                    child: const Text('Minska med 5'),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    _extraAir = !_extraAir;
                  });
                },
                child: Container(
                  width: 200,
                  color: Colors.lightBlue,
                  child: AnimatedPadding(
                    padding: _extraAir
                        ? EdgeInsets.symmetric(horizontal: 40, vertical: 40)
                        : EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: Text('Det här är en text'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isPaused = !_isPaused;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  color: _isPaused ? Colors.grey : Colors.green,
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 400),
                    padding: _isPaused
                        ? EdgeInsets.symmetric(horizontal: 200, vertical: 100)
                        : EdgeInsets.symmetric(horizontal: 100, vertical: 200),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      child: Row(
                        key: ValueKey(_isPaused),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_isPaused ? 'Pausad' : 'Aktiv'),
                          Icon(_isPaused ? Icons.heart_broken : Icons.favorite),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedMenu(),
            ],
          ),
        ),
      ),
    );
  }
}

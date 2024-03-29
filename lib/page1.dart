import 'dart:ui';
import 'package:flutter/material.dart';
import 'common_component.dart';
import 'constants.dart';
import 'page2.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> slideToRightAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    slideToRightAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(1.0, 0.0)).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInCubic));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFF47C74),
          onPressed: () async {
            controller.forward();
            await Future.delayed(const Duration(milliseconds: 1000));
            if (mounted) {
              Navigator.push(context, _nextPageRoute())
                  .then((value) => controller.reset());
            }
          },
          child: const Icon(
            Icons.search,
          )),
      body: Column(
        children: [
          const SizedBox(height: 40),
          HeaderList(slideAnimation: slideToRightAnimation),
          const SizedBox(height: 20),
          Body(slideAnimation: slideToRightAnimation),
        ],
      ),
    );
  }

  Route _nextPageRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final opacityTween = Tween(begin: 0.0, end: 1.0).animate(animation);
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: FadeTransition(opacity: opacityTween, child: child));
        });
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(left: 55.0),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
              color: Color.fromARGB(255, 184, 222, 240)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("You're in", style: TextStyle(color: Color(primaryRedColor))),
            SizedBox(height: 10),
            Text("New york",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                )),
            SizedBox(
                width: 100,
                child: Divider(
                  height: 4,
                  color: Color(primaryRedColor),
                  thickness: 1.5,
                ))
          ],
        ),
      )
    ]);
  }

  @override
  Size get preferredSize => const Size(500, 250);
}

class HeaderList extends StatelessWidget {
  const HeaderList({super.key, required this.slideAnimation});
  final List headers = const <String>[
    "Popular",
    "Features",
    "Trending",
    "Recent"
  ];
  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: slideAnimation,
        child: Wrap(
            spacing: 20,
            children: headers
                .map((title) => Text(title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )))
                .toList()));
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.slideAnimation,
  });

  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 340,
          child: ListView.builder(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 40,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (_, __) {
              return const CardContent();
            },
          ),
        ),
      ),
      // ),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: Image.asset(
                    "images/test.jpeg",
                    fit: BoxFit.cover,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const CommonCalendar(),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("Tea Ceremony",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("1270 Madison Avenue"),
                    ],
                  ),
                ],
              ),
            ),
            // )
          ],
        ));
  }
}

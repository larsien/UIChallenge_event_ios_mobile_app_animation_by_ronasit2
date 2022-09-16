import 'package:flutter/material.dart';

import 'common_component.dart';
import 'constants.dart';

class Page3 extends StatefulWidget {
  const Page3(this.index, {super.key});
  final int index;

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: HeaderAppBar(index: widget.index, controller: controller),
        body: Column(
      children: [
        HeaderAppBar(
          index: widget.index,
        ),
        MainBody(
          index: widget.index,
          controller: controller,
        ),
        BottomBody(
          index: widget.index,
        ),
      ],
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class HeaderAppBar extends StatefulWidget with PreferredSizeWidget {
  const HeaderAppBar({super.key, required this.index});

  final int index;

  @override
  State<HeaderAppBar> createState() => _HeaderAppBarState();
  @override
  Size get preferredSize => const Size(500, 300);
}

class _HeaderAppBarState extends State<HeaderAppBar> {
  late final Animation<Offset> headerBodySlideAnimation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "image${widget.index}",
        child: Container(
          height: 300,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "images/pug.jpeg",
                  )),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              )),
        ));
  }
}

class MainBody extends StatefulWidget {
  const MainBody({
    super.key,
    required this.index,
    required this.controller,
  });

  final int index;
  final AnimationController controller;

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  late AnimationController controller;
  late final Animation<double> calendarScaleUpAnimation;
  late final Animation<double> iconScaleUpFadeInAnimation;
  late final Animation<double> textFadeInAnimation;
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    calendarScaleUpAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.7, curve: Curves.ease)));
    iconScaleUpFadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.25, 0.7, curve: Curves.ease)));
    textFadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.ease)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Hero(
        tag: "content${widget.index}",
        child: Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CalendarItem(
                  text: sampleContentList[widget.index]["title"]!,
                  iconScaleUpAnimation: iconScaleUpFadeInAnimation,
                ),
                const SizedBox(
                  // this divider is not looking good...
                  height: 20,
                ),
                DetailItemRow(
                  icon: Icons.location_pin,
                  iconScaleUpAnimation: iconScaleUpFadeInAnimation,
                  text: sampleContentList[widget.index]["location"]!,
                  textFadeInAnimation: textFadeInAnimation,
                ),
                const SizedBox(
                  height: 10,
                ),
                DetailItemRow(
                  icon: Icons.access_time_filled,
                  iconScaleUpAnimation: iconScaleUpFadeInAnimation,
                  text: "8:00 AM - 10:00 PM",
                  textFadeInAnimation: textFadeInAnimation,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailItemRow extends StatelessWidget {
  const DetailItemRow({
    super.key,
    required this.icon,
    required this.iconScaleUpAnimation,
    required this.text,
    required this.textFadeInAnimation,
  });

  final String text;
  final IconData icon;
  final Animation<double> iconScaleUpAnimation;
  final Animation<double> textFadeInAnimation;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ScaleTransition(
          scale: iconScaleUpAnimation,
          child: Icon(
            icon,
            color: const Color(primaryRedColor),
          ),
        ),
        const SizedBox(width: 5),
        FadeTransition(opacity: textFadeInAnimation, child: Text(text))
      ],
    );
  }
}

class CalendarItem extends StatelessWidget {
  const CalendarItem({
    super.key,
    required this.text,
    required this.iconScaleUpAnimation,
  });
  final Animation<double> iconScaleUpAnimation;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ScaleTransition(
            scale: iconScaleUpAnimation, child: const CommonCalendar()),
        const SizedBox(width: 10),
        SizedBox(
          width: 192,
          child: Text(text,
              maxLines: 2,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}

class BottomBody extends StatelessWidget {
  const BottomBody({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: 40, child: Text(sampleContentList[index]["content"]!)),
          const SizedBox(
              height: 20,
              child: Text("See more ",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

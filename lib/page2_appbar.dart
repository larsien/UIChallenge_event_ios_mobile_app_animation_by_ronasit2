import 'package:flutter/material.dart';

import 'constants.dart';

class CustomCoffeeAppBar extends StatefulWidget with PreferredSizeWidget {
  CustomCoffeeAppBar(this.controller, {super.key});
  final AnimationController controller;
  @override
  State<CustomCoffeeAppBar> createState() => _CustomCoffeeAppBarState();

  @override
  Size get preferredSize => const Size(700, 300);
}

class _CustomCoffeeAppBarState extends State<CustomCoffeeAppBar> {
  late AnimationController controller;
  bool isLoading = true;
  @override
  void initState() {
    controller = widget.controller;

    super.initState();
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedOpacity(
        opacity: isLoading ? 0.3 : 1.0,
        duration: const Duration(seconds: 3),
        child: const AppBarBackground(),
      ),
      AnimatedAlign(
        alignment:
            isLoading ? const Alignment(0.5, 0.7) : const Alignment(0.5, 0.5),
        duration: const Duration(seconds: 3),
        curve: Curves.ease,
        child: Transform.rotate(
          angle: isLoading ? 0.0 : 0.5,
          child: SizedBox(
            height: 70,
            //https://www.pngwing.com/en/free-png-zqryl
            child: Image.asset(
              "images/coffee.png",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
      const AppBarBottomWhiteBackground(),
      SearchForTextWidget(
        controller: controller,
      ),
      const MenuBar(),
    ]);
  }
}

class AppBarBackground extends StatelessWidget {
  const AppBarBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 50.0,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(primaryBlueColor),
        ),
      ),
    );
  }
}

class AppBarBottomWhiteBackground extends StatelessWidget {
  const AppBarBottomWhiteBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
        alignment: Alignment.bottomCenter,
        child: Divider(
          thickness: 60,
          color: Colors.white,
        ));
  }
}

class MenuBar extends StatefulWidget {
  const MenuBar({super.key});

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  bool isMenu1Selected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 40,
          width: 200,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 0.1,
                    spreadRadius: 0.1)
              ],
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                  onTap: () {
                    isMenu1Selected = true;
                    setState(() {});
                  },
                  child: AppBarMenuContainer(
                      isMenuSelected: isMenu1Selected, menuName: "Events")),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    isMenu1Selected = false;
                    setState(() {});
                  },
                  child: AppBarMenuContainer(
                      isMenuSelected: !isMenu1Selected, menuName: "Organizers"))
            ]),
          ),
        ),
      ),
    );
  }
}

class SearchForTextWidget extends StatelessWidget {
  const SearchForTextWidget({
    super.key,
    required this.controller,
  });
  final AnimationController controller;
  final String appBarSearchText = "Search for ...";

  @override
  Widget build(BuildContext context) {
    Animation<double> sizeFactorTween =
        Tween<double>(begin: 0, end: 1).animate(controller);
    return Positioned(
      top: 150,
      left: 20,
      child: SizeTransition(
        sizeFactor: sizeFactorTween,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(appBarSearchText,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
      ),
    );
  }
}

class AppBarMenuContainer extends StatelessWidget {
  final bool isMenuSelected;
  final String menuName;
  const AppBarMenuContainer(
      {super.key, required this.isMenuSelected, required this.menuName});
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: isMenuSelected
                ? const Color.fromARGB(255, 2, 58, 105)
                : Colors.white),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(menuName,
                style: TextStyle(
                    color: isMenuSelected ? Colors.white : Colors.grey))));
  }
}

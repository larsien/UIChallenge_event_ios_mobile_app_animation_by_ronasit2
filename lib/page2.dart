import 'package:flutter/material.dart';
import 'common.dart';
import 'page3.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> headerTextFadeInAnimation;
  late final Animation<Offset> headerTextSlideUpAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    headerTextFadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));
    headerTextSlideUpAnimation = Tween<Offset>(
            begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCoffeeAppBar(controller),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Header(), Body(controller: controller)],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

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

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("Last results",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.controller});
  final AnimationController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: sampleContentList.length,
        itemBuilder: (context, index) {
          var item = sampleContentList[index];

          return GestureDetector(
            onTap: () => Navigator.push(context, _delayedRoute(index)),
            child: ListItem(item: item, index: index),
          );
        },
      ),
    );
  }

  Route _delayedRoute(int index) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => Page3(index),
      transitionDuration: const Duration(milliseconds: 1200),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.item, required this.index});

  final Map<String, String> item;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(item["dayOfWeek"]!, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 5),
              Text(item["day"]!,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color(primaryRedColor),
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Hero(
                tag: "content$index",
                child: CardBody(item: item),
              ),
              Hero(
                tag: "image$index",
                child: CardImage(item: item),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    required this.item,
  });

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12),
      child: Container(
        width: 50,
        height: 80,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    //  Image.asset(item["image"]!)
                    AssetImage(
                  item["image"]!,
                )),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  const CardBody({
    super.key,
    required this.item,
  });

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 15,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 50,
              height: 80,
            ),
          ),
          SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item["title"]!,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(item["location"]!)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

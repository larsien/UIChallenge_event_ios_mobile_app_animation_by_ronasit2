import 'package:flutter/material.dart';

import 'constants.dart';
import 'page3.dart';

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

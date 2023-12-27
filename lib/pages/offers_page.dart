import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class offerspage extends StatelessWidget {
  const offerspage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        offer(
          title: "Offer",
          description: "This is a great offer",
        ),
        offer(
          title: "Offer",
          description: "This is a great offer",
        ),
        offer(
          title: "Offer",
          description: "This is a great offer",
        ),
        offer(
          title: "Offer",
          description: "This is a great offer",
        ),
      ],
    );
  }
}

class offer extends StatelessWidget {
  final String title;
  final String description;

  const offer({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.amber.shade50,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "/background.png",
                ),
              ),
            ),
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.amber.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                )),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.amber.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

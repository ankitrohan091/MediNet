import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Widgets with Like Buttons',
      debugShowCheckedModeBanner: false,
      home: ContainerWidgetWithLikeButtons(),
    );
  }
}
class ContainerWidgetWithLikeButtons extends StatefulWidget {
  const ContainerWidgetWithLikeButtons({super.key});

  @override
  _ContainerWidgetWithLikeButtonsState createState() =>
      _ContainerWidgetWithLikeButtonsState();
}
class _ContainerWidgetWithLikeButtonsState
    extends State<ContainerWidgetWithLikeButtons> {
  List<String> _items = [
    "☛ 𝐇𝐨𝐰 𝐭𝐨 𝐠𝐞𝐭 𝐫𝐢𝐝 𝐨𝐟 𝐫𝐞𝐠𝐮𝐥𝐚𝐫 𝐜𝐨𝐥𝐝?"

        "\n✍ A common cold is usually caused by a viral infection, and there is no cure for it."
        "\n However, there are several things you can do to help alleviate the symptoms "
        "and make yourself more comfortable while your body fights off the virus:"
        "\n𝑹𝒆𝒔𝒕: Getting plenty of rest is important for allowing your body to recover and fight off the infection."
        " Make sure you get plenty of sleep, and take it easy during the day."
        "\n𝑫𝒓𝒊𝒏𝒌 𝒇𝒍𝒖𝒊𝒅𝒔:Drinking plenty of fluids, such as water, tea,"
        " and soup, can help to keep you hydrated and loosen congestion."
        "\n𝑮𝒂𝒓𝒈𝒍𝒆 𝒘𝒊𝒕𝒉 𝒔𝒂𝒍𝒕 𝒘𝒂𝒕𝒆𝒓: Gargling with salt water can help to relieve a sore throat and reduce inflammation."
        "\nIf your symptoms persist for more than a week or if you develop complications,"
        " such as a high fever, difficulty breathing, or chest pain, you should consult a healthcare professional.",
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10'
  ];
  List<String> _likedItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Widgets with Like Buttons'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _items[index],
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _likedItems.contains(_items[index])
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_likedItems.contains(_items[index])) {
                        _likedItems.remove(_items[index]);
                      } else {
                        _likedItems.add(_items[index]);
                      }
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LikedItemsPage(
                likedItems: _likedItems,
              ),
            ),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
class LikedItemsPage extends StatelessWidget {
  final List<String> likedItems;
  LikedItemsPage({required this.likedItems});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Items'),
      ),
      body: ListView.builder(
        itemCount: likedItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Text(
              likedItems[index],
              style: TextStyle(fontSize: 18.0),
            ),
          );
        },
      ),
    );
  }
}
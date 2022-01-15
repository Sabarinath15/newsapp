import 'package:flutter/material.dart';

//widget
import 'news_list.dart';
import 'news_fav_list.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  static const routname = '/newspage';

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _widgetlist = [
    const NewsList(),
    const FavNews(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetlist.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                primary: _selectedIndex == 0 ? Colors.blue[900] : Colors.white,
                minimumSize: Size(MediaQuery.of(context).size.width * .48, 30),
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              icon: Icon(
                Icons.list,
                size: 30,
                color: _selectedIndex == 0 ? Colors.white : Colors.black,
              ),
              label: Text(
                'News',
                style: TextStyle(
                  fontSize: 26,
                  color: _selectedIndex == 0 ? Colors.white : Colors.black,
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                primary: _selectedIndex != 0 ? Colors.blue[900] : Colors.white,
                minimumSize: Size(MediaQuery.of(context).size.width * .48, 30),
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              icon: Icon(
                Icons.favorite,
                size: 30,
                color: _selectedIndex != 0 ? Colors.white : Colors.red,
              ),
              label: Text(
                'Favs',
                style: TextStyle(
                  fontSize: 26,
                  color: _selectedIndex != 0 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app2/shared_ui/navigation_drawer.dart';

class InstagramFeed extends StatefulWidget {
  @override
  _InstagramFeedState createState() => _InstagramFeedState();
}

class _InstagramFeedState extends State<InstagramFeed> {
  TextStyle _hashTagStyle = TextStyle(color: Colors.orange);
  late List<int> favorit=[0,2];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram Feeds"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _drawHeader(position),
                  _drawTitle(),
                  _drawHashTags(),
                  _drawBody(),
                  _drawFooter(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _drawHeader(int position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundImage:
                ExactAssetImage('assets/images/placeholder_bg.png'),
                radius: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Christina Meyers',
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Fri, 12 May 2017 • 14.30',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                if(favorit.contains(position)){favorit.remove(position);}else{favorit.add(position);}
                print(favorit);
                setState(() {

                });
                },
              color:favorit.contains(position)?Colors.red: Colors.grey.shade400,
            ),
            Transform.translate(
                offset: Offset(-12, 0),
                child: Text(
                  '25',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                )),
          ],
        ),
      ],
    );
  }

  Widget _drawTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      child: Text(
        'We also talk about the future of work as the robots',
        style: TextStyle(color: Colors.grey.shade900),
      ),
    );
  }

  Widget _drawHashTags() {
    return Container(
      child: Wrap(
        children: <Widget>[
          FlatButton(
              onPressed: () {},
              child: Text(
                '#advance',
                style: _hashTagStyle,
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#advance',
                style: _hashTagStyle,
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#advance',
                style: _hashTagStyle,
              )),
        ],
      ),
    );
  }

  Widget _drawBody() {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Image(
          image: ExactAssetImage('assets/images/placeholder_bg.png'),
          fit: BoxFit.cover,
        ));
  }

  Widget _drawFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(onPressed: (){}, child: Text('10 OMMENTS'  ,style: _hashTagStyle,)),
        Row(
          children: <Widget>[
            FlatButton(onPressed: (){}, child: Text('SHARE' , style: _hashTagStyle,)),
            FlatButton(onPressed: (){}, child: Text('OPEN' , style: _hashTagStyle,)),
          ],
        ),
      ],
    );
  }
}
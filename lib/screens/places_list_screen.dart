import 'package:flutter/material.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/screens/add_place_screen.dart';
import 'package:greatplaces/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder:(ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator(),)
            : Consumer<GreatPlaces>(
          builder: (ctx, greatPlaces, ch) =>
              greatPlaces.items.length <= 0 ? ch : ListView.builder(
                itemBuilder: (ctx, i) =>ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlaces.items[i].image),
                  ),
                  title: Text(greatPlaces.items[i].title),
                  subtitle: Text(greatPlaces.items[i].location.address),
                  onTap: (){
                    Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.items[i].id);
                  },
                ),
                itemCount: greatPlaces.items.length,
              ),
          child: Center(child: const Text('No Places added yet!'),),
        ),
      ),
    );
  }
}
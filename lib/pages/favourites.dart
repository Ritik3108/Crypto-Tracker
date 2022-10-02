// ignore_for_file: library_private_types_in_public_api

import 'package:cyptotracker/models/cryptoCurrency.dart';
import 'package:cyptotracker/providers/market_provider.dart';
import 'package:cyptotracker/widgets/crypto_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoCurrency> favorites = marketProvider.markets
            .where((element) => element.isFavorite == true)
            .toList();

        if (favorites.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                CryptoCurrency currentCrypto = favorites[index];
                return CryptoListTile(currentCrypto: currentCrypto);
              },
            ),
          );
        } else {
          return const Center(
            child: Text(
              "No favorites yet",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
          );
        }
      },
    );
    // return Container(
    //   child: Text("Favorites will show up here"),
    // );
  }
}

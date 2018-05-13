import 'package:flutter/material.dart';
import 'package:my_theming_app/model/product.dart';
import 'package:my_theming_app/model/data.dart';
import 'package:my_theming_app/colors.dart';
import 'login.dart';

class ShrineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shrine',
      home: new _MyHomePage(),
      theme: _kShrineTheme,
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
    );
  }
}

Route _getRoute(RouteSettings settings) {
  if (settings.name != '/login') {
    return null;
  }
  return MaterialPageRoute<void>(
    settings: settings,
    builder: (context) => new LoginPage(),
    fullscreenDialog: true,
  );
}

ThemeData _kShrineTheme = _buildkShrineTheme();
ThemeData _buildkShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900,
    primaryColor: kShrinePink100,
    buttonColor: kShrinePink100,
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(
      color: kShrineBrown900,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}

class _MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shrine'),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('Menu button');
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridCards(context),
      ),
    );
  }

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = getProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }
    final ThemeData theme = Theme.of(context);

    return products.map((product) {
      return _buildCardItem(product, theme);
    }).toList();
  }

  Card _buildCardItem(Product product, ThemeData theme) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 11,
            child: Image.asset(
              product.assetName,
              package: product.assetPackage,
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    product.name == null ? '' : product.name,
                    style: theme.textTheme.button,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '${product.price}\$',
                    style: theme.textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

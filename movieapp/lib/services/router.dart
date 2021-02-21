import 'package:flutter/material.dart';
import 'package:movieapp/models/items_model.dart';
import 'package:movieapp/screens/my_tickets_screen.dart';
import 'package:movieapp/screens/noRoute_screen.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'package:movieapp/services/authentication.dart';
import 'package:movieapp/services/auth_wrapper.dart';
import 'package:movieapp/screens/cart_screen.dart';
import 'package:movieapp/screens/home_screen.dart';
import 'package:movieapp/screens/movie_screen.dart';
import 'package:movieapp/screens/my_profile_screeen.dart';
import 'package:movieapp/screens/snacks_screen.dart';
import 'package:movieapp/screens/manage_movies_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => StreamProvider<LocalUser>.value(
                  value: LocalUser.instance.user,
                  child: Wrapper(),
                ));

      case "/tickets_screen":
        return MaterialPageRoute(builder: (_) => MyTicketsPage());

      case "/movie_screen":
        return MaterialPageRoute(
            builder: (_) => MovieScreen(
                  movie: args,
                ));

      case "/snack_screen":
        return MaterialPageRoute(builder: (_) => SnacksScreen());

      case "/cart_screen":
        return MaterialPageRoute(builder: (_) => CartScreen());

      case "/profile_screen":
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case "/manage_movie_screen":
        return MaterialPageRoute(builder: (_) => ManageMoviesPage());

      default:
        return MaterialPageRoute(builder: (_) => NoRouteScreen());
    }
  }
}

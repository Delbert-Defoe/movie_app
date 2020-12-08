class Movie {
  String id;
  String title;
  String imageUrl;
  String description;
  String duration;
  List<dynamic> timeScreen;
  bool onscreen;
  String rating;

  Movie({
    this.id,
    this.title,
    this.imageUrl,
    this.duration,
    this.timeScreen,
    this.description,
    this.onscreen,
    this.rating,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
        'duration': duration,
        'timeScreen': timeScreen,
        'description': description,
        'onscreen': onscreen,
        'rating': rating,
      };

  Movie.fromData(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        imageUrl = data['imageUrl'],
        timeScreen = data['timeScreen'],
        description = data['description'],
        onscreen = data['onscreen'],
        rating = data['rating'];
}

/*
List<Movie> movies = [
  Movie(
      title: 'Bad Boys For life',
      imageUrl: 'assets/images/badboys.jpg',
      duration: '1:49:50',
      timeScreen: [
        {
          'Date': DateTime.parse("2020-07-20"),
          'Time': [
            DateTime.parse("2020-07-22 17:30:00"),
            DateTime.parse("2020-07-22 18:30:00"),
            DateTime.parse("2020-07-22 19:30:00"),
            DateTime.parse("2020-07-22 20:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        },
        {
          'Date': DateTime.parse("2020-07-21"),
          'Time': [
            DateTime.parse("2020-07-22 20:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 22:30:00"),
            DateTime.parse("2020-07-22 23:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        },
        {
          'Date': DateTime.parse("2020-07-22"),
          'Time': [
            DateTime.parse("2020-07-22 19:30:00"),
            DateTime.parse("2020-07-22 20:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 22:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        },
        {
          'Date': DateTime.parse("2020-07-23"),
          'Time': [
            DateTime.parse("2020-07-22 14:30:00"),
            DateTime.parse("2020-07-22 15:30:00"),
            DateTime.parse("2020-07-22 16:30:00"),
            DateTime.parse("2020-07-22 17:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        }
      ],
      description:
          'The wife and son of a Mexican drug lord embark on a vengeful quest to kill all those involved in his trial and imprisonment -- including Miami Detective Mike Lowrey. When Mike gets wounded, he teams up with partner Marcus Burnett and AMMO -- a special tactical squad -- to bring the culprits to justice. But the old-school, wisecracking cops must soon learn to get along with their new elite counterparts if they are to take down the vicious cartel that threatens their lives.',
      onscreen: true,
      rating: 'R'),
  Movie(
    title: 'Black Widow',
    imageUrl: 'assets/images/blackwidow.jpg',
    duration: '1:49:50',
    timeScreen: [
      {
        'Date': DateTime.parse("2020-07-22"),
        'Time': [
          DateTime.parse("2020-07-22 18:30:00"),
          DateTime.parse("2020-07-22 19:30:00"),
          DateTime.parse("2020-07-22 20:30:00"),
          DateTime.parse("2020-07-22 21:30:00")
        ],
        'Screening': ['3d', 'Regular', '3d', 'Regular']
      },
      {
        'Date': DateTime.parse("2020-07-23"),
        'Time': [
          DateTime.parse("2020-07-22 21:30:00"),
          DateTime.parse("2020-07-22 22:30:00"),
          DateTime.parse("2020-07-22 23:30:00"),
          DateTime.parse("2020-07-22 00:30:00")
        ],
        'Screening': ['3d', 'Regular', '3d', 'Regular']
      },
      {
        'Date': DateTime.parse("2020-07-24"),
        'Time': [
          DateTime.parse("2020-07-22 21:30:00"),
          DateTime.parse("2020-07-22 22:30:00"),
          DateTime.parse("2020-07-22 23:30:00"),
          DateTime.parse("2020-07-22 00:30:00")
        ],
        'Screening': ['3d', 'Regular', '3d', 'Regular']
      },
      {
        'Date': DateTime.parse("2020-07-25"),
        'Time': [
          DateTime.parse("2020-07-22 21:30:00"),
          DateTime.parse("2020-07-22 21:30:00"),
          DateTime.parse("2020-07-22 21:30:00"),
          DateTime.parse("2020-07-22 21:30:00")
        ],
        'Screening': ['3d', 'Regular', '3d', 'Regular']
      }
    ],
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    onscreen: true,
    rating: 'PG',
  ),
  Movie(
      title: 'Jumanji',
      imageUrl: 'assets/images/jumanji.jpeg',
      duration: '1:49:50',
      timeScreen: [
        {
          'Date': DateTime.parse("2020-07-22"),
          'Time': [
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        },
        {
          'Date': DateTime.parse("2020-07-22"),
          'Time': [
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        },
        {
          'Date': DateTime.parse("2020-07-22"),
          'Time': [
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        },
        {
          'Date': DateTime.parse("2020-07-23"),
          'Time': [
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        }
      ],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      onscreen: true,
      rating: 'R'),
  Movie(
      title: 'John Wick',
      imageUrl: 'assets/images/johnwick.jpg',
      duration: '1:49:50',
      timeScreen: [
        {
          'Date': DateTime.parse("2020-07-22"),
          'Time': [
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        },
        {
          'Date': DateTime.parse("2020-07-22"),
          'Time': [
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        },
        {
          'Date': DateTime.parse("2020-07-22"),
          'Time': [
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        },
        {
          'Date': DateTime.parse("2020-07-23"),
          'Time': [
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00"),
            DateTime.parse("2020-07-22 21:30:00")
          ],
          'Screening': ['3d', 'Regular', '3d', 'Regular']
        }
      ],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      onscreen: false,
      rating: 'PG'),
];
*/

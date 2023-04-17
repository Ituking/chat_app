import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            color: Colors.grey,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 200.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 140.0, 16.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Jane Doe',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Software Engineer',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget ullamcorper est, id pretium nisi. Aliquam vel malesuada magna, eu consectetur sapien. Aliquam consequat felis at nulla lacinia, ut vestibulum urna sollicitudin. Sed fermentum, tellus sed volutpat imperdiet, dolor lectus accumsan nulla, sit amet pharetra metus nisi id purus. Nunc eu lectus dignissim, blandit magna id, bibendum ex. Nam sed elit quam. Aliquam eu leo nulla. Etiam iaculis velit sit amet nunc posuere, vel interdum sapien maximus. Sed porttitor mi mauris, sed vestibulum mauris lacinia vel. Integer vitae quam interdum, commodo tellus non, tincidunt odio. Praesent vel urna ut justo sodales ullamcorper.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

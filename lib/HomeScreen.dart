import 'package:albarakaquizapp/model/comment_model.dart';
import 'package:albarakaquizapp/service/dataservice.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CommentModel>> _commentsFuture;
  List<CommentModel> _allComments = [];
  List<CommentModel> _filteredComments = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _commentsFuture = CommentsSerivceImp().getComment();
    _searchController.addListener(_filterComments);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterComments() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _filteredComments = _allComments.where((comment) {
          final query = _searchController.text.toLowerCase();
          return comment.user.username.toLowerCase().contains(query) ||
              comment.body.toLowerCase().contains(query);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E3A4B),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                height: 60,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Color(0xff77C1C1)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Color(0xff0a324d),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Color(0xff0a324d),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CommentModel>>(
              future: _commentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  _allComments = snapshot.data!;
                  _filterComments(); // Filter the comments immediately after fetching the data
                  return ListView.builder(
                    itemCount: _filteredComments.length,
                    itemBuilder: (context, index) {
                      return CommentCard(comment: _filteredComments[index]);
                    },
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
class CommentCard extends StatelessWidget {
  final CommentModel comment;

  CommentCard({Key? key, required this.comment}) : super(key: key);

  void _shareComment(BuildContext context) {
    final String text = 'Comment: ${comment.body}\nUser: ${comment.user.username}';
    _launchShare(text);
  }

  Future<void> _launchShare(String text) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'marwan.kawadri.2000@gmail.com', // Add email address here if using email sharing
      queryParameters: {
        'subject': 'Shared Comment',
        'body': text,
      },
    );

    final Uri smsUri = Uri(
      scheme: 'sms',
      queryParameters: {
        'body': text,
      },
    );

    try {
      if (await canLaunch(emailUri.toString())) {
        await launch(emailUri.toString());
      } else if (await canLaunch(smsUri.toString())) {
        await launch(smsUri.toString());
      } else {
        print('Could not launch any sharing options');
      }
    } catch (e) {
      print('Error launching sharing options: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      margin: EdgeInsets.all(20),
      child: CustomPaint(
        painter: CardPainter(),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              SizedBox(height: 80),
              CustomPaint(
                painter: TrianglePainter(),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "daTe", // Use the comment body as the date
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 100),
              Column(
                children: [
                  Center(
                    child: Text(
                      ' ${comment.body}', // Display the comment body as project name
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      '${comment.user.username}', // Display the username as creator
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Spacer(), // Added to push the icon to the right
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => _shareComment(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFF48C9B0)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(-5, -25);

    path.quadraticBezierTo(size.width*3, size.height*-.9 , size.width*2 , size.height *0.25);
    path.quadraticBezierTo(size.width *-.3, size.height *2.8, -5, size.height * 1.1);

    path.close();

    canvas.drawPath(path, paint);

    var borderPaint = Paint()
      ..color = Color(0xFF0E3A4B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

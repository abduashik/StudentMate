import 'package:flutter/material.dart';
import 'package:students_mate/models/user.dart' as model;
import 'package:students_mate/providers/user_provider.dart';
import 'package:students_mate/resources/firestore_methods.dart';
import 'package:provider/provider.dart';
import 'package:students_mate/screens/comment_screen.dart';
import 'package:students_mate/widgets/comment_card.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(snap['profImage']),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap['postOwner'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // IMAGE SECTION
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),
          // LIKE, COMMENT SECTION
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await FireStoreMethods()
                        .likePost(snap['postId'], user.uid, snap['likes']);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )),
              IconButton(
                  onPressed: () {}
                  //  => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) =>
                  //         CommentsScreen(snap: snap.toString())))
                  ,
                  icon: const Icon(
                    Icons.comment_outlined,
                  )),
              // IconButton(onPressed: () => {}, icon: const Icon(Icons.send))
            ],
          ),

          // Description and no of comments
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '${snap['likes']} likes',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: '${snap['postOwner']} ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: snap['description'],
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {}
            // => Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => CommentsScreen(
            //           snap: snap.toString(),
            //         )))
            ,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
              child: Text(
                'View all 100 comments',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
            child: Text(
              '22/02/22',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

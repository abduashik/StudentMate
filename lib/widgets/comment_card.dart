import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1645878942010-d51b611ba52a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
            radius: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'username',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'some description')
                ])),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "23/12/21",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

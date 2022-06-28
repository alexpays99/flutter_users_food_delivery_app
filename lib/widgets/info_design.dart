import 'package:flutter/material.dart';
import 'package:users_app/models/sellers.dart';

class InfoDesignWidget extends StatefulWidget {
  InfoDesignWidget({Key? key, this.model, this.context}) : super(key: key);

  Sellers? model;
  BuildContext? context;

  @override
  State<InfoDesignWidget> createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 285,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.sellerAvatarUrl!,
                height: 210.0,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                widget.model!.sellerName!,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontFamily: 'Train',
                ),
              ),
              Text(
                widget.model!.sellerEmail!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: 'Train',
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

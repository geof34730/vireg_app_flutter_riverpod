import 'package:Vireg/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';


import '../_class/DeepLink.dart';
import '../myApp.dart';


class Share extends ConsumerStatefulWidget {
  const Share({Key? key,required this.idList }) : super(key: key);
  final String? idList;
  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends ConsumerState<Share> {
  @override
  void initState() {
    print("initState Share ${widget.idList}");
    if(widget.idList!=null) {
      DeepLink(context:context,ref:ref).shareReceive(personalListId: widget.idList).then((value) {
        Future.delayed(const Duration(seconds: 2), () {
          context.go('/');
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build share");
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height-180  ,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
                LoadingAnimationWidget.dotsTriangle(
                  color: Colors.blue,
                  size: 150.0,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 30.0),
                    child: Text(
                      context.loc.shareLoadingListPersonal,
                      textAlign: TextAlign.center,
                    )
                )
          ],
      ),

    );
  }
}

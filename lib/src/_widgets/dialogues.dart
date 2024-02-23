import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Dialogues extends ConsumerWidget {
  const Dialogues({
    required BuildContext this.context,

  });

  final BuildContext context;



  Future<String?> alertOffline() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width:280.0,
                    child:Text(
                      context.loc.alertOffLine,
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                      textAlign: TextAlign.center,
                    )
                ),
                const SizedBox(height: 15, width: 150),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(context.loc.fermer),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    throw UnimplementedError();
  }


}




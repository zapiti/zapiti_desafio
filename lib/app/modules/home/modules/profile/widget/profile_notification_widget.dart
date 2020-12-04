import 'package:flutter/cupertino.dart';
import 'package:zapiti_desafio/app/component/card/notification_colored_card_widget.dart';
import 'package:zapiti_desafio/app/modules/home/modules/profile/model/profile_notification.dart';

class ProfileNotificationWidget extends StatelessWidget {
  final ProfileNotification notification;

  ProfileNotificationWidget({@required this.notification});

  @override
  Widget build(BuildContext context) {
    return NotificationColoredCardWidget(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.title, style: TextStyle(fontSize: 18)),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Text(
                notification.description,
                maxLines: 10,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

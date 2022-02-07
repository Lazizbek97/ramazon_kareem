import 'package:ramazo_taqvim/core/notifications/nomoz_alarm.dart';

class SetNotifications {
  static // ? Set notifications
      setNotifications({
    required int id,
    required String title,
    required String body,
    required String payload,
    required DateTime joriy_nomoz_vaqti,
  }) {
    final today = DateTime.now();

    DateTime newNotification = DateTime(
      joriy_nomoz_vaqti.year,
      joriy_nomoz_vaqti.month,
      joriy_nomoz_vaqti.day,
      00,
      10,
    );
    if (today.isBefore(newNotification)) {
      Notifications.showNotificationScheduledDailyBasis(
        id: id,
        title: title,
        body: body,
        payload: payload,
        scheduledDate: newNotification,
      );
    } else {
      newNotification = newNotification.add(const Duration(days: 1));
      Notifications.showNotificationScheduledDailyBasis(
        id: id,
        title: title,
        body: body,
        payload: payload,
        scheduledDate: newNotification,
      );
    }
  }

// ? Delete Notifications
  static deleteNotification(int id) async {
    await Notifications.cancelNotification(id);
  }
}

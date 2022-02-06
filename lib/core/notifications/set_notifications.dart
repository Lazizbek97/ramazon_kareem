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
      joriy_nomoz_vaqti.hour,
      joriy_nomoz_vaqti.minute,
    );

    Notifications.showNotificationScheduledDailyBasis(
      id: id,
      title: title,
      body: body,
      payload: payload,
      scheduledDate: newNotification,
    );
  }

// ? Delete Notifications
  static deleteNotification(int id) async {
    await Notifications.cancelNotification(id);
  }
}

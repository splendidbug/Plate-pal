import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.initial() = UEInitial;
  // const factory UserEvent.logout() = UELogout;
  // const factory UserEvent.signInWithGoogle() = UESignInWithGoogle;
  // const factory UserEvent.create({required String name, required String dp}) = UECreate;
  // const factory UserEvent.update({required String name, required String dp}) = UEUpdate;
  // const factory UserEvent.delete() = UEDelete;
  const factory UserEvent.eat({required String recpie}) = UEEat;
  const factory UserEvent.history_delete({required int index}) = UEHDelete;
}

part of 'progress_task_bloc.dart';

@immutable
sealed class ProgressTaskEvent {}

class OnFetchProgressTask extends ProgressTaskEvent {
  final int userId;

  OnFetchProgressTask(this.userId);
}

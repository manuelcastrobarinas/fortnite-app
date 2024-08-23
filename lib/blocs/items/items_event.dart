part of 'items_bloc.dart';

@immutable
sealed class ItemsEvent {}

class OnGetItemsGameEvent extends ItemsEvent {
  final ItemsModel newItems;

  OnGetItemsGameEvent({
    required this.newItems
  });
}
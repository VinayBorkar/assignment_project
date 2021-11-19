class ItemModel {
  String title;
  bool isComplete = false;
  bool isNew = false;
  String? date;

  ItemModel(
    this.title,
    this.isComplete,
    this.date,
    this.isNew,
  );
}

class InformationFlow {
  final String title;
  final String link;
  final int id;
  final bool collect;

  InformationFlow({this.title, this.link, this.id, this.collect})
      : assert(title != null),
        assert(link != null),
        assert(id != null),
        super();
}
class Paper {
  String paperId = '';
  String paperName = '';
  bool isMcq = false;
  bool isStructure = false;
  bool isEssay = false;

  Paper(
      {required this.paperId,
      required this.paperName,
      required this.isMcq,
      required this.isStructure,
      required this.isEssay});
}

class Instructor {
  String instructorId = '';
  String email = '';
   String docId = '';

  Instructor({
    required this.instructorId,
    required this.email,
    required this.docId
  });
}

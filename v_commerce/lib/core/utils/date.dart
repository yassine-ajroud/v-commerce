class DateParser{
  static String getDateDifference(DateTime fromDate){
    String res='';
  DateTime time = DateTime.timestamp();
 if (time.difference(fromDate).inMinutes > 60) {
    if (time.difference(fromDate).inHours > 24) {
      if (time.difference(fromDate).inDays > 7) {
        res=time.difference(fromDate).inDays.toString();
        if(time.difference(fromDate).inDays < 30) {
                 res='${time.difference(fromDate).inDays ~/ 7} weeks';

        }else{
           if(time.difference(fromDate).inDays < 365) {
                  res='${time.difference(fromDate).inDays ~/ 30} months';

        }else{
           res='${time.difference(fromDate).inDays ~/ 365} years';
        }
        }     
      } else {
        res='${time.difference(fromDate).inDays} days';
      }
    } else {
      res='${time.difference(fromDate).inHours} houres';
    }
  } else {
    res='${time.difference(fromDate).inMinutes} minutes';
  }
    return res;
  }
}
String returnDate(String realDate, [bool check = false, bool short = false]) {
  String year = realDate.substring(0, 4);
  String month = realDate.substring(5, 7);
  String day = realDate.substring(8, 10);

  String date;

  switch (month) {
    case "01":
      {
        if (short == true) {
          date = day + " Oca";
        } else {
          date = day + " Ocak";
        }
      }
      break;
    case "02":
      {
        if (short == true) {
          date = day + " Şub";
        } else {
          date = day + " Şubat";
        }
      }
      break;
    case "03":
      {
        if (short == true) {
          date = day + " Mar";
        } else {
          date = day + " Mart";
        }
      }
      break;
    case "04":
      {
        if (short == true) {
          date = day + " Nis";
        } else {
          date = day + " Nisan";
        }
      }
      break;
    case "05":
      {
        if (short == true) {
          date = day + " May";
        } else {
          date = day + " Mayıs";
        }
      }
      break;
    case "06":
      {
        if (short == true) {
          date = day + " Haz";
        } else {
          date = day + " Haziran";
        }
      }
      break;
    case "07":
      {
        if (short == true) {
          date = day + " Tem";
        } else {
          date = day + " Temmuz";
        }
        ;
      }
      break;
    case "08":
      {
        if (short == true) {
          date = day + " Ağu";
        } else {
          date = day + " Ağustos";
        }
      }
      break;
    case "09":
      {
        if (short == true) {
          date = day + " Eyl";
        } else {
          date = day + " Eylül";
        }
      }
      break;
    case "10":
      {
        if (short == true) {
          date = day + " Eki";
        } else {
          date = day + " Ekim";
        }
      }
      break;
    case "11":
      {
        if (short == true) {
          date = day + " Kas";
        } else {
          date = day + " Kasım";
        }
      }
      break;
    case "12":
      {
        if (short == true) {
          date = day + " Ara";
        } else {
          date = day + " Aralık";
        }
      }
      break;
  }
  if (check) {
    return date + " " + year;
  } else {
    return date;
  }
}

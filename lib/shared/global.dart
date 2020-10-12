import 'package:Misas/models/subsidiary.dart';
import 'package:flutter/material.dart';

abstract class Global{
  //Colors
  static const Color primary = const Color(0xff0a81a9);
  static const Color secondary = const Color(0xff96d5ee);

  static List<Subsidiary> subsidiaries = new List<Subsidiary>();

  //Subsidiaries
  static fillSubsidiaries(){
    subsidiaries.add(new Subsidiary('assets/images/lourdes.jpg','Nuestra Señora de Lourdes','Lourdes, Montes de Oca', secondary));
    subsidiaries.add(new Subsidiary('assets/images/vargas.jpg','San Ignacio de Loyola','Vargas Araya, Montes de Oca', Colors.amberAccent));
    subsidiaries.add(new Subsidiary('assets/images/cedros.jpg','Santa Rita de Casia','Cedros, Montes de Oca', Colors.orange[300]));
    subsidiaries.add(new Subsidiary('assets/images/granadilla.jpg','Nuestra Señora de la Paz','Granadilla, Curridabat', Colors.deepOrange[300]));
  }

  //Months
  static String getMonth(month){
    switch(month){
      case 1: return 'Enero'; break;
      case 2: return 'Febrero'; break;
      case 3: return 'Marzo'; break;
      case 4: return 'Abril'; break;
      case 5: return 'Mayo'; break;
      case 6: return 'Junio'; break;
      case 7: return 'Julio'; break;
      case 8: return 'Agosto'; break;
      case 9: return 'Setiembre'; break;
      case 10: return 'Octubre'; break;
      case 11: return 'Noviembre'; break;
      case 12: return 'Diciembre'; break;
      default: return 'error'; break;
    }
  }

}
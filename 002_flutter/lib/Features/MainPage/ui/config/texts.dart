import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text startPageText = new Text("Hier könnten Daten stehen: \n Aktuelle Anzahl an registrierten Bikes\nGefundene Bikes\nVermisste Bikes\n#Newsletter\n#Startseite - Wenn Zugangsdaten gespeichert hier starten!!!!");

Text bikeVerloren = new Text("Bike Verloren", style: GoogleFonts.roboto(
  fontWeight: FontWeight.bold,
  color: Colors.white
),);

Text bikeGefunden = new Text("Bike Gefunden", style: GoogleFonts.roboto(
  fontWeight: FontWeight.bold,
  color: Colors.black
),);
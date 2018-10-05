program Wurfparabel;

uses Crt, Graph;

var Treiber, Modus, x, y, Zaehler           : Integer;
    x_Wert, y_Wert, max_y_Wert, x_Faktor,
    y_Faktor, v0, Alpha, Alpha_in_Grad, g   : Real;
    Taste                                   : Char;
    Text                                    : String;




begin
  ClrScr;
  WriteLn('*****  Programm zur Berechnung und Darstellung einer Wurfparabel  *****');
  GotoXY(8,10);

  v0 := 30;
  Alpha_in_Grad := 60;
  g := 9.81;

  {
  Write('Anfangsgeschwindigkeit in m/sec : '); ReadLn(v0);
  GotoXY(8,13);
  Write('Winkel in Grad (0-90) ..........: '); ReadLn(Alpha_in_Grad);
  GotoXY(8,16);
  Write('Gravitationskraft (9.81) .......: '); ReadLn(g);
  }

  { Umrechnung in Bogenma·:  180 * c = Pi
                                   c = 3.14159 / 180 }
  Alpha := Alpha_in_Grad * 3.14159 / 180;

  Treiber := InstallUserDriver('pvga800', nil);  Modus := 2;
  InitGraph(Treiber,Modus,'');  { Grafikinitialisierung }

      {  fÅr VGA }

  Line(0,465,639,465);          { X-Achse }
  Line(10,0,10,479);          { Y-Achse, Mittelpunkt bei x:10,y:465 }

  Text := 'Hîhe in 10m - Schritten';
  OutTextXY(15,0,Text+GetDriverName);
  OutTextXY(400,472,'Entfernung in 10m - Schritten');

  x_Faktor := 620 / 100;  { x_Werte der Parabel sollen zwischen 0 und 100
                           liegen. Bei 100 soll die x-Koordinate 620 sein
                                      100 * x_Faktor = 620
                                      x_Faktor       = 620 / 100 }
  y_Faktor := 465/100;
      { Der errechnete y_Wert soll hier max. 100 betragen.
        Dann soll die y-Koordinate 0 sein (ganz oben), man mu· also von der
        y-Koordinate des Mittelpunktes mit y = 465    465 abziehen. Der er-
        mittelte y_Wert mu· mit einem Faktor multipliziert werden.
        100 * y_Faktor = 465
        y_Faktor       = 465 / 100 }

  { Einteilung der Achsen in 10-er Schritten }
  for Zaehler := 1 to 10 do
       begin
         x_Wert := Zaehler * 10;
         x := Round(10 + x_Faktor * x_Wert);
         Line(x,465,x,468)
       end;
  for Zaehler := 1 to 10 do
       begin
         y_Wert := Zaehler * 10;
         y := Round(465 - y_Faktor * y_Wert);
         Line(7,y,10,y);
       end;

  x_Wert := 0;
  y_Wert := 0;
  max_y_Wert := 0;
  while (x_Wert <= 100) and (y_Wert >= 0) do
     begin
      y_Wert := x_Wert*(sin(Alpha)/cos(Alpha))-(g*Sqr(x_Wert))/(2*Sqr(v0)*Sqr(cos(Alpha)));
      if y_Wert > max_y_Wert then max_y_Wert := y_Wert; {Maximumermittlung}
      x := Round(10 + x_Faktor * x_Wert); {rundet und liefert einen Integer-}
      y := Round(465 - y_Faktor * y_Wert); {typ }
      PutPixel(x,y,11);                     {setzt einen Punkt mit der Farbe 11}
      x_Wert := x_Wert + 0.1;
     end;
  x_Wert := x_Wert - 0.1;

  Str(Alpha_in_Grad:6:2, Text);
  OutTextXY(400,5,'Anfangswinkel : '+ Text + ' Grad');
  Str(v0:6:2, Text);
  OutTextXY(400,15,'Anfangsgeschw.: '+ Text + ' m/sec');
  Str(max_y_Wert:6:2, Text);
  OutTextXY(400,25,'Maximale Hîhe : '+ Text + ' m');
  Str(x_Wert:6:2, Text);
  OutTextXY(400,35,'Aufschlagpunkt: '+ Text + ' m');
  Taste := ReadKey;  {wartet auf einen Tastendruck}
  CloseGraph         {schlie·t den Grafikmodus und schaltet auf Textmodus um}
end.

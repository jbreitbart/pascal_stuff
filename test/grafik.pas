{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autorin: Gabi Rosenbaum    12.10.92              º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 ºProgramm zur Grafikdemonstration                                  º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
program grafdemo;                                      {Graphdemo.pas}
uses
  crt, graph;

const
  TreiberPfad = 'c:\bp\bgi';           {Verzeichnis, der BGI-Treiber}

var
  GrafikTreiber,
  GrafikModus,
  FehlerCode    : integer;
  xMax, yMax    : integer;
  FehlerMeldung : String;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure InstallGraph;                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Installiert die Grafik.                                           ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure InstallGraph;
begin
  GrafikTreiber := detect;  {Automatischer Kennung des Grafiktreibers}
  InitGraph (GrafikTreiber, GrafikModus, TreiberPfad);  {Installieren}
  FehlerCode := Graphresult;                {Rckgabe des Fehlercodes}
end;                                                {von InstallGraph}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure GrafikWerte                                             ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Gibt die Wert fr den Grafiktreiber, den -Modus und die maximalten³
 ³Koordinaten auf dem Bildschirm aus.                               ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure GrafikWerte (Grafikmodus : integer);
var
  Treiber,
  Modus : string;

begin
  Treiber := GetDriverName;                  {Name des Grafiktreibers}
  Modus := GetModeName(GrafikModus);            {Name des Grafikmodus}
  xMax := GetMaxX;                                  {Maximaler x-Wert}
  yMax := GetMaxY;                                  {Maximaler y-Wert}
  RestoreCrtMode;                               {Zurck zum Textmodus}
  clrscr;
                            {Ausgabe der Daten auf dem Textbildschirm}

  writeln('Der Grafiktreiber ist: ',Treiber);
  writeln('Der Grafikmodus ist: ',Modus);
  writeln('Die linke untere Ecke ist: ',xMax,' * ',yMax,' Punkte');
  readln;
  SetGraphMode(Grafikmodus);                  {Zurck zum Grafikmodus}
end;                                                 {Von Grafikwerte}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TextAusgeben                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Gibt einen Text aus, dabei k”nnen Position, Zeichensatz, Richtung ³
 ³und Gr”áe eingestellt werden.                                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TextAusgeben(x,y : integer;Austext : string;
                       Zeichensatz, Richtung, Groesse : word);

begin
  SetTextJustify(1,1);                 {Text mittig zur Cursorpositon}
  SetTextStyle(Zeichensatz,Richtung,Groesse);       {Textformatierung}
  OutTextXY(x,y,Austext);                 {Ausgabe des Textes bei x/y}
end;                                                {von TextAusgeben}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TextDemo                                                ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Erstellt eine Demonstration der verschiedenen Zeichens„tze in     ³
 ³unterschiedlichen Gr”áen.                                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

Procedure TextDemo;

const
  Austext = 'Hallo';
  Anzahl = 5;

var
  i,k : integer;                                       {Laufvariablen}
  x,y : integer;                     {Koordinaten fr die Textausgabe}

begin                                     {Berechnung der Koordinaten}
  x := getMaxX div 2;
  y := getMaxY div (2*Anzahl);

  for i := 0 to 4 do       {Verschiedene Zeichens„tze werden gebildet}
  begin
    cleardevice;
    for k := 1 to Anzahl do  {Verschiedene Textgr”áen werden gebildet}
        TextAusgeben (x,y*k,AusText,i,0,k);
    readln;
  end;                                  {von for}
end;                                                    {von TextDemo}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure SternenHimmel;                                          ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Erstellt mit Hilfe weiterer Routinen einen Sternenhimmel.         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure SternenHimmel;

const
  MaxPunkt = 100;                         {Maximale Anzahl der Punkte}

type
  Punkt = record
            x, y : integer;{Position}
            m, b : real;             {Steigung und y-Achsenabschnitt}
            farbe : word;
            Radius :word;
          end;                                            {von Punkt}
var
  i,k          : integer;                              {Laufvariable}
  xm, ym       : integer;                    {Spalte und Zeile Mitte}
  PunktMenge : array [1..MaxPunkt] of Punkt;     {Menge aller Punkte}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure init;                                                   ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Initialisiert das Feld und erzeugt Koordinaten fr die Sterne     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure init;
var
  k   : integer;                                        {Laufvariable}
  sp  : integer;                         {Zur Berechnung der Steigung}
begin
  xmax := getmaxx;                                   {Initialisierung}
  ymax := getmaxy;
  xm := xmax div 2;
  ym := ymax div 2;

  for k := 1 to MaxPunkt do
  begin
   punktMenge[k].x := random (xmax);     {Zufallswerte fr die Punkte}
   PunktMenge[k].y := random (ymax);
   PunktMenge[k].Farbe := random (15);
   PunktMenge[k].Radius := random (5);
   sp := xm - Punktmenge[k].x + 1;
   if sp = 0 then sp := 1;
   Punktmenge[k].m:=(ym-PunktMenge[k].y) / sp;              {Steigung}
                                                   {y-Achsenabschnitt}
   PunktMenge[k].b:=(PunktMenge[k].y-PunktMenge[k].m*PunktMenge[k].x);
  end;                                                       {von For}

end;                                                        {von Init}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure NeuerPunkt                                              ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Erzeugt einen neuen Punkt nach der gleichen Methode wie in Init   ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure NeuerPunkt(welcher: integer);
var
  sp : Integer;                          {Zur Berechnung der Steigung}
begin
    PunktMenge[welcher].farbe := random(15);            {Zufallswerte}
    PunktMenge[welcher].Radius := random(5);
    punktMenge[welcher].x := random (xmax);
    if PunktMenge[Welcher].x = 0 then 
                                 PunktMenge[Welcher].x := 1;
    PunktMenge[Welcher].y := random (ymax);
    sp := xm - Punktmenge[Welcher].x +1;
    if sp = 0 then 
              sp := 1;
                                                            {Steigung}
    PunktMenge[Welcher].m := (ym-PunktMenge[Welcher].y) / sp;
                                                   {y-Achsenabschnitt}
    PunktMenge[Welcher].b := (PunktMenge[Welcher].y
                             -PunktMenge[Welcher].m
                             *PunktMenge[Welcher].x);
end;                                                  {von NeuerPunkt}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure zeigePunkt                                              ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Stellt einen Punkt auf dem Bildschirm da, einige Punkt werden     ³
 ³gr”áer (als ausgefllte Kreise) gezeichnet.                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure zeigePunkt(welcher: Integer);

begin
                         {Kreise, wenn 40,80 oder 120 bergeben wird}
   if (Welcher = 40) or (Welcher = 80) or (Welcher = 120) then
   begin
     Setcolor(PunktMenge[welcher].farbe);               {Farbe setzen}
     setfillstyle(1,PunktMenge[welcher].farbe);     {Fllen mit Farbe}
     Fillellipse (PunktMenge[Welcher].x,             {Kreis zeichnen.}
                  PunktMenge[Welcher].y,
                  PunktMenge[welcher].Radius,
                  PunktMenge[welcher].Radius);
   end                                                        {von if}

   else                      {Punkt in der angegebenen Farbe ausgeben}
    PutPixel(PunktMenge[Welcher].x,PunktMenge[Welcher].y,
             PunktMenge[welcher].Farbe);

end;                                                  {von ZeigePunkt}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure loeschePunkt                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³L”scht einen Punkt, indem er mit der Hintergrundfarbe berschreibt³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure loeschePunkt(welcher: punkt);

begin
                                             {40., 80. und 120. Punkt}
  if (k=40) or (k=80) or (k= 120) then
   begin
     Setcolor(0);
     setfillstyle(1,0);
     Fillellipse(Welcher.x,Welcher.y,Welcher.radius,Welcher.Radius);
   end                                                        {von if}

   else
     PutPixel(welcher.x,welcher.y,0);

end;                                                {von LoeschePunkt}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure verschiebePunkt                                         ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Verschiebt einen Punkt anhand der errechneten Werte der Geraden   ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure verschiebePunkt(welcher: integer);

var
  savePoint : Punkt;    {šbernimmt Werte fr den zu l”schenden Punkt}

begin
    savePoint := PunktMenge[welcher];

    if PunktMenge[welcher].x < xm then  {Bei x<xm, x-Wert verringern}
       Dec(PunktMenge[Welcher].x)
    else                                       {sonst x-Wert erh”hen}
       Inc(PunktMenge[welcher].x);
                             {Neuen y-Wert nach y := mx+b, berechnen}
    PunktMenge[Welcher].y := round (PunktMenge[welcher].m
                                  * PunktMenge[welcher].x
                                  + PunktMenge[welcher].b);
    loeschePunkt(savePoint);
end;                                            {von VerschiebePunkt}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Hier beginnt der Code von SternenHimmel                           ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
begin
  ClearDevice;
  TextAusgeben(getMaxX div 2, getMaxY div 2,
               'Demonstration von PutPixel',2,0,10);
  readln;
  clearDevice;
  randomize;                         {Zufallsgenerator initialisieren}
  init;
  repeat;                           {Schleife, wartet auf Tastendruck}
    for i := 1 to MaxPunkt do                     {alle Punkte zeigen}
                           zeigePunkt(i);
    for k := 1 to MaxPunkt do                {alle Punkte verschieben}
                           verschiebePunkt(k);

    for k := 1 to MaxPunkt do   {Wenn Bildschrimgrenzen berschritten}
    begin                             {wird ein neuer Punkt erstellt.}
      if (punktMenge[k].x = 0) or (PunktMenge[k].x = xmax) or
         (punktMenge[k].y = 0) or (PunktMenge[k].y = xmax)
         then NeuerPunkt(k);
    end;

  until Keypressed;
  readln;
end;                                               {von Sternenhimmel}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure Sierpinksi                                              ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Erstellt das Sierpinski-Dreieck mit dem Chaos-Spiel               ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure Sierpinski;
const
  hoehe = 50;                                 {Randabstand der Grafik}
  Endwert = 30000;                   {Anzahl der dargestellten Punkte}
var
   x,y       : array [0..2] of integer;    {Koordinaten der Eckpunkte}
   xp,yp,          {Mittelpunkt zwischen Eckpunkt und gezeichn. Punkt}
   i         : integer;
   p : word;                  {Zufallswert zur Auswahl des Eckpunktes}

begin
  randomize;
  x[0] := getMaxX div 2;               {Bestimmung der drei Eckpunkte}
  y[0] := hoehe;
  x[1] := x[0]-getMaxX div 3;
  y[1] := getMaxY - Hoehe-1;
  x[2] := x[0]+GetMaxX div 3;
  y[2] := GetMaxY - hoehe-1;
  xp := x[0];              {Ein Eckpunkt fr als Startwert ausgew„hlt}
  yp := y[0];
  cleardevice;
  for i := 1 to  Endwert do
  begin
    p := random(3);                {Einen Eckpunkt zuf„llig ausw„hlen}
    xp := (xp+x[p]) div 2;             {Koordinaten des Mittelpunktes}
    yp := (yp+y[p]) div 2;
    putPixel(xp,yp,15)                                {Punkt zeichnen}
  end;                                                       {von for}
  readln;
end;                                                  {von Sierpinski}



{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure LinienZeigen                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Demonstriert verschiedene Linienarten mit SetLineStyle            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure LinienZeigen;
var
  i : integer;                                          {Laufvariable}
  x,y : integer;                               {Anfangs- und Endpunkt}
begin
  ClearDevice;
  SetColor(15);
  TextAusgeben(getMaxX div 2, getMaxY div 2,
               'Linien mit SetLineStyle',2,0,10);
  readln;
  ClearDevice;
  x := (GetMaxX-40) div 10;
  y := getMaxY-20;

  for i := 0 to 3 do
  begin
    SetLineStyle(i,0,1);                            {Linienart setzen}
    Line(x*(i+1),20,x*(i+1),y);                         {Linie ziehen}
  end;                                                       {von for}

  for i := 0 to 3 do
  begin
    SetLineStyle(i,0,3);                            {Linienart setzen}
    Line(x*(i+5),20,x*(i+5),y);                         {Linie ziehen}
  end;                                                       {von for}
  graphdefaults;                       {Voreinstellungen zurcksetzen}
  readln;
end;


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure Rechtecke                                               ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Demonstriert Rechtecke, die mit verschieden Farben gefllt werden ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure Rechtecke;
var
  x1,y1,                                            {Linke obere Ecke}
  x2,y2 : integer;                                {Rechte untere Ecke}
  i : integer;                                         {Laufvariablen}
  Breite : Integer;                             {Breite des Rechtecks}

begin
  ClearDevice;
  TextAusgeben(getMaxX div 2, getMaxY div 2,
               'Farben und Rechtecke',2,0,10);
  readln;
  cleardevice;
  breite := getMaxX div 30;
  x1 := 0;
  y1 := 0;
  y2 := GetMaxY;

  for i := 1 to 15 do
  begin
    setColor(i);                                 {Zeichenfarbe setzen}
    x2 := x1 + Breite;
    RectAngle(x1,y1,x2,y2);                        {Rechteck zeichnen}
    SetFillStyle(1,i);                   {Fllen mit Vordergrundfarbe}
    FloodFill(x1+1,y1+1,i);                         {Fllen mit Farbe}
    x1 := x2 + Breite;
  end;                                                       {von for}

  readln;
  Graphdefaults;                       {Voreinstellungen zurcksetzen}
end;                                                   {von Rechtecke}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure Balkengrafik;                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Erstellt mit Hilfe weiterer Routinen eine Balkengrafik            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure Balkengrafik;

const
  Hoehe = 50;                          {Wert fr die Bildschirmr„nder}

var
  xEnd, yEnd : integer;                {Max. x/y-Werte fr die Grafik}
  Wert : array [1..10] of real;                 {Werte fr die Grafik}
  GroessterWert : real;                     {Gr”áter bergebener Wert}
  Anzahl : integer;                     {Anzahl der bergebenen Werte}
  Muster : boolean;                            {Fllmuster oder Farbe}
  Dimension : boolean;        {Dreidimensional oder zweidimenensional}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure WerteEingeben;                                          ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Zur Eingabe der Werte fr die Grafik                              ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure WerteEingeben;

var
  i : integer;                                          {Laufvariable}
  ch : char;                       {Zum Einlesen der Abbruchbedingung}

begin
  i := 0;                    {Initialisierung von i und GroessterWert}
  GroessterWert := 0;
  restoreCrtMode;                               {Zurck zum Textmodus}
  clrscr;
  writeln ('Es wird eine Balkengrafik erstellt');
  writeln ('Maximal 10 (positive) Werte k”nnen eingegeben werden');

  repeat{Schleife zum Einlesen der Werte bis Anzahl = 10 oder Abbruch}
    Write('Soll ein Wert eingegeben werden? J/N: ');

    repeat               {Abfrage, ob ein Wert eingelesen werden soll}
      ch := upcase (ReadKey);
    until ch in ['J','N'];

    if (ch='J') and (i<=10) then                      {Werte einlesen}
    begin
      clrscr;
      i := i+1;

      repeat                                        {Wert gr”áer Null}
        write('Bitte ',i,'. Wert eingeben: ');
        readln (Wert[i]);
      until wert[i] > 0;

      if groessterWert < Wert[i] then         {Gr”áten Wert bestimmen}
         GroessterWert := Wert[i];

    end;                                       {von if(Werte einlesen}

  until (ch = 'N') or (i = 10);  {Abbruch bei 10 Werten oder Ch = 'N'}
  Anzahl := i;                                       {Anzahl einlesen}

  if Anzahl > 0 then                            {Wenn Werte vorhanden}
  begin
    clrscr;
    Writeln('Soll das Muster in Farbe ausgegeben werden J/N ');

    repeat    {Abfrage, ob die Grafik in Farbe ausgegeben werden soll}
      ch := Upcase(Readkey);
    until ch in ['J','N'];

    if ch = 'J' then    {Muster = true fr Schraffur, false fr Farbe}
                Muster := false
                else
                Muster := true;

    clrscr;
    Writeln('Soll eine dreidimensionale Grafik erstellt werden J/N ');

    repeat   {Abfrage ob dreidimensionale Grafik erstellt werden soll}
      ch := Upcase(Readkey);
    until ch in ['J','N'];

    if ch = 'N' then          {Dimension = true fr 3-D false fr 2-D}
                Dimension := false
                else
                Dimension := true;
  end;                                         {von if(Anzahl > Null)}

  SetGraphMode(Grafikmodus);                  {Zurck zum Grafikmodus}
end;                                               {Von WerteEingeben}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure ZeichneKoordinaten;                                     ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Zeichnet ein Koodinatenkreuz und definiert einen Bildausschnitt   ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure ZeichneKoordinaten;

var
  i,                                                    {Laufvariable}
  Markierung,                    {y-Wert fr die Daten an der y-Achse}
  Ausgabe     : integer;                  {Prozentzahl an der y-Achse}
  TextAusgabe: string;            {Umwandlung von Ausgabe fr Outtext}

begin
  cleardevice;
  SetViewPort(Hoehe,Hoehe,xEnd,yEnd,false);       {Bildschimausschnitt
       folgende Eingaben sind relativ zum Ausschnitt, Zeichnungen, die
                      darber hinausgehen, werden nicht abgeschnitten}
  Line (0,yEnd-hoehe,xEnd-Hoehe,yEnd-Hoehe);        {x-Achse zeichnen}
  Line (0,yEnd-Hoehe,0,0);                          {y-Achse zeichnen}

  for i := 0 to 5 do         {Jede 20% eine Markierung an die y-Achse}
  begin
    Ausgabe := 20*i;                       {Wert fr Ausgabe einlesen}
    Markierung := yEnd-Hoehe-i*((yEnd-Hoehe) div 5);      {Umrechnung}
    str(Ausgabe,TextAusgabe);                   {TextAusgabe einlesen}
    TextAusgabe := TextAusgabe + '%';
    SetTextJustify(2,1);         {Text rechtsbndig zur Cusorposition}
    SetTextStyle(0,0,1);                {Schriftarten, Gr”áe und Stil}
    OuttextXY(0,Markierung,TextAusgabe);  {Ausgabe (neben Ausschnitt)}
  end;                                                       {von for}

  for i := 1 to Anzahl do      {Balkennummer am unteren Rand ausgeben}
  begin
    Ausgabe := i;
    str(Ausgabe,TextAusgabe);
    Markierung := (i-1)*((Xend-Hoehe) div Anzahl-10)+2;
    SetTextJustify(0,2);
    SetTextStyle(0,0,1);
    OuttextXY(Markierung,Yend-Hoehe+10,TextAusgabe);
  end;                                                       {von for}

end;                                          {von ZeichneKoordinaten}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure ZeichneBalkenGrafik;                                    ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Zeichnet die Balkengrafik                                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure ZeichneBalkenGrafik;

var
  i : integer;                                          {Laufvariable}
  UmrechnungsfaktorX : integer;             {Zur Berechnung der Werte}
  UmrechnungsfaktorY : real;
  x1,y1,
  x2,y2,         {Linke obere und rechte untere Ecke der Balkengrafik}
  Zahl               : integer;             {Fr die Ausgabe der H”he}
  Textv,TextN        : string;       {Umwandlung von Zahl fr Outtext}

begin

  if Anzahl > 0 then                            {Wenn Werte vorhanden}
  begin     {Berechnung der Umr.Faktoren nach Anzahl und gr”áten Wert}
    Umrechnungsfaktorx := (Xend-hoehe) div Anzahl-10;
    UmrechnungsfaktorY :=(yEnd-hoehe)/ GroessterWert;

    for i := 1 to Anzahl do            {Schleife fr alle eing. Werte}
    begin
      if Muster = false then          {Fllen mit gesetzer Farbe(i+1)}
                        SetfillStyle(1,i+1)
                        else             {Fllen mit gesetztem Muster}
                        SetfillStyle(i+1,15);
           {Berechnung der linken oberen und der rechten unteren Ecke}
      x1 := 2+UmrechnungsfaktorX*(i-1);
      x2 := x1 + UmrechnungsfaktorX;
      y1 := Round(yEnd-hoehe-UmrechnungsfaktorY*Wert[i]);
      y2 := yEnd-hoehe-2;

      if Dimension = false then             {zweidimensionaler Balken}
                           Bar(x1,y1,x2,y2)
                           else             {dreidimensionaler Balken}
                           Bar3D(x1,y1,x2-20,y2,20,true);

      Zahl := trunc (Wert[i]);        {ganzzahliger Anteil des Wertes}
      str(Zahl,TextV);                    {Umwandlung in Zeichenkette}
      Zahl := round (Frac(Wert[i])*100);  {Nachkommaanteil in Integer}
      str(Zahl,TextN);                    {Umwandlung in Zeichenkette}
      TextV := TextV+'.'+TextN;       {Zusammenfgen und Dezimalpunkt}
      outtextXY((x2+x1)div 2,y1-10,TextV);        {Ausgabe des Textes}
    end;                                                     {von For}

                                                          end;{von if}

           Graphdefaults{Werte des Bildschirmausschnitts zurcksetzen}
end;                                         {von ZeichneBalkenGrafik}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Hier beginnt der Code von BalkenGrafik                            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

begin
  ClearDevice;
  SetColor(15);
  TextAusgeben(getMaxX div 2, getMaxY div 2,
               'Demonstration Balkengrafik',2,0,10);
  readln;
  xEnd := getMaxX- Hoehe;         {Berechnung der maximalen x/y-Werte}
  yEnd := getMaxY -Hoehe;
  WerteEingeben;
  ZeichneKoordinaten;
  ZeichneBalkenGrafik;
  readln;
end;                                                {von BalkenGrafik}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure Kreise                                                  ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Erstellt 12 Kreise, die mit verschiedenen Mustern gefllt werden  ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure Kreise;

const                                   {Selbstdefiniertes Fllmuster}
  Muster :  FillPatternType =
  ($f0,$f0,$f0,$f0,$0f,$0f,$0f,$0f);

var
  i,                                                    {Laufvariable}
  radius,                                                {Kreisradius}
  x,y : integer;                                         {Mittelpunkt}

begin
  ClearDevice;
  SetColor(15);
  TextAusgeben(getMaxX div 2, getMaxY div 2,
               'Kreise mit FllMustern',2,0,10);
  readln;
  cleardevice;
  Radius := getMaxy div 6;
  x := radius;
  y := radius;

  for i := 0 to 10 do
  begin
    setColor(15);                                {Zeichenfarbe setzen}
    circle(x,y,radius-10);                            {Kreis zeichnen}
    setFillStyle(i,15);              {Fllmuster und Farbe einstellen}
    Floodfill(x,y,15);                         {Fllen mit Fllmuster}
    x := x+2*Radius;

    if (i = 3) or (i = 7) then
    begin
      x := radius;
      y := y +2*Radius
    end;                                                      {von if}

  end;                                                        {von if}

  SetFillPattern(Muster,15);     {Kreis mit selbstdef. Fllmuster}
  FillEllipse(x,y,radius-10,Radius-10);
  readln;
  Graphdefaults;                    {Voreinstellungen wieder aufrufen}
end;                                                      {von Kreise}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure TortenGrafik;                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Erstellt mit Hilfe weiterer Routinen eine Tortenrafik             ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TortenGrafik;

const
  Radius = 100;                                    {Radius der Grafik}

var
  Wert         : Array [1..10] of Real;         {Werte fr die Grafik}
  Anzahl,                                           {Anzahl der Werte}
  MittelpunktX,                        {Koordinaten des Mittelpunktes}
  MittelpunktY : integer;
  groessterWert: real;                             {Summe aller Werte}
  Muster       : boolean;                {Fr Farb- oder Mustergrafik}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure WerteEingeben;                                          ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Zur Eingabe der Werte fr die Grafik                              ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure WerteEingeben;

var
  i : integer;                                          {Laufvariable}
  ch : char;                       {Zum Einlesen der Abbruchbedingung}

begin
  i := 0;                    {Initialisierung von i und GroessterWert}
  GroessterWert := 0;
  restoreCrtMode;                               {Zurck zum Textmodus}
  clrscr;
  writeln ('Es wird eine Tortengrafik erstellt');
  writeln ('Maximal 10 (positive) Werte k”nnen eingegeben werden');

  repeat{Schleife zum Einlesen der Werte bis Anzahl = 10 oder Abbruch}
    Write('Soll ein Wert eingegeben werden? J/N: ');

    repeat               {Abfrage, ob ein Wert eingelesen werden soll}
      ch := upcase (ReadKey);
    until ch in ['J','N'];

    if (ch='J') and (i<=10) then                      {Werte einlesen}
    begin
      clrscr;
      i := i+1;                                    {i um eins erh”hen}

      repeat                             {Nur positive Werte einlesen}
        write('Bitte ',i,'. Wert eingeben: ');
        readln (Wert[i]);
      until wert[i] >= 0;

         GroessterWert := GroessterWert+Wert[i]; {Summe GroessterWert}
    end;                                      {von if (Werte einlesen}

  until (ch = 'N') or (i = 10);

  Anzahl := i;                                       {Anzahl einlesen}

  if Anzahl > 0 then                            {wenn Werte vorhanden}
  begin
    clrscr;
    Writeln('Soll die Grafik in Farbe ausgegeben werden J/N ');

    repeat           {Abfrage ob Grafik in Farbe ausgeben werden soll}
      ch := Upcase(Readkey);
    until ch in ['J','N'];

    if ch = 'J' then    {Muster = false fr Farbe, true fr Schraffur}
                Muster := false
                else
                Muster := true;
  end;

  SetGraphMode(Grafikmodus);                  {zurck zum Grafikmodus}
end;                                               {von WerteEinlesen}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³function Sinus                                                    ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Berechnet den Sinus in Gradmaá                                    ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
function Sinus (Eingabe : real): real;

var
  hilf : real;                                          {Hilfvariable}

begin
  Eingabe := Eingabe * Pi / 180;
  hilf := sin(eingabe);
  sinus := hilf;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure ZeichneTortenGrafik;                                    ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Zeichnet die Tortengrafik                                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ZeichneTortenGrafik;

const
  EndWert = 360;                          {Endwinkel fr vollen Kreis}
  Verschiebe = 10;            {Abstand der Markierungen an der Grafik}

var
  Zahl,                    {Fr die Umwandlung zur Ausgabe in Outtext}
  i                : integer;                           {Laufvariable}
  Startwinkel,
  EndWinkel        : word;               {Winkelangaben fr Piesclice}
  TextV,
  TextN            : string;               {Konvertierung fr Outtext}
  PosX,
  PosY             : integer;                    {Position des Textes}
  MWinkel          : word;{WinkelHalbierende von Start- und EndWinkel}
  x,y              : real;    {Fr die Berechnung der Textkoordinaten}
  Umrechnungsfaktor: real;

begin

  if Anzahl > 0 then                     {Abfrage, ob Werte vorhanden}
  begin
    StartWinkel := 0;                     {Initialisierung der Winkel}
    EndWinkel := 0;
    Umrechnungsfaktor :=  Endwert / GroessterWert; {Umrechnungsfaktor}

    for i := 1 to Anzahl do      {Schleife fr die Ausgabe der Grafik}
    begin
      if Muster =  false then                       {Fllen mit Farbe}
                   Setfillstyle (1,i+1)
                   else                         {Fllen mit Schraffur}
                   SetFillStyle (i+2,15);

      StartWinkel := EndWinkel;
                                                 {Endwinkel berechnen}
      Endwinkel := Round(Endwinkel + Wert[i] * Umrechnungsfaktor);

      if Endwinkel > 360 then                 {Endwinkel auf max. 360}
                         Endwinkel := 360;

      Pieslice (MittelPunktX,MittelpunktY,  {Zeichnet das Tortenstck}
                StartWinkel, EndWinkel,Radius);
      Zahl := Trunc(Wert[i]);
      str(Zahl,TextV);
      Zahl := round (Frac(Wert[i])*100);  {Nachkommaanteil in Integer}
      str(Zahl,TextN);                    {Umwandlung in Zeichenkette}
      TextV := TextV+'.'+TextN;       {Zusammenfgen und Dezimalpunkt}
      MWinkel := (StartWinkel + EndWinkel) div 2;  {Winkelhalbierende}
{
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Berechnung von PosX und PosY in Abh„ngigkeit vom Winkel, wobei die ³
³Grafik entgegen dem Uhrzeigersinn erstellt wird.                   ³
³Bis 90ø Abschnitt rechts oben                                      ³
³Bis 180ø Abschnitt links oben                                      ³
³Bis 270ø Abschnitt links unten                                     ³
³Bis 360ø Abschnitt rechts unten                                    ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
      if MWinkel <= 90 then
      begin
        y := Radius * sinus(MWinkel);
        x := sqrt(sqr(Radius)-sqr(y));
        PosX := MittelPunktX + Round(x) + Verschiebe;
        PosY := MittelPunktY - Round(y) - Verschiebe;
      end                                           {von if (bis 90ø)}

      else
      begin

        if MWinkel <= 180 then
        begin
          y := Radius * sinus(MWinkel-90);
          x := sqrt(sqr(Radius)-sqr(y));
          PosX := MittelPunktX - Round(x) - 2*Verschiebe;
          PosY := MittelPunktY - Round(y) - 2*Verschiebe;
        end                                        {von if (bis 180ø)}

        else
        begin

          if MWinkel <= 270 then
          begin
            y := Radius * sinus(MWinkel-180);
            x := sqrt(sqr(Radius)-sqr(y));
            PosX := MittelPunktX - Round(x) - 2*Verschiebe;
            PosY := MittelPunktY + Round(y) + 2*Verschiebe;
          end;                                     {von if (bis 270ø)}

        end;                                                {von else}

      end;                                                  {von else}

      if MWinkel > 270 then
      begin
        y := Radius * sinus(MWinkel-270);
        x := sqrt(sqr(Radius)-sqr(y));
        PosX := MittelPunktX + Round(x) + Verschiebe;
        PosY := MittelPunktY + Round(y) + Verschiebe;
      end;                                                    {von if}
      OuttextXY(PosX,PosY, TextV);
    end;                                {von For (Ausgabe der Grafik)}

  readln;
  end;                                 {von if (Wenn Werte vorhanden)}
end;                                         {von ZeichneTortenGrafik}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Hier beginnt der Code von TortenGrafik                            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
begin
  ClearDevice;
  SetColor(15);
  TextAusgeben(getMaxX div 2, getMaxY div 2,
               'Demonstration TortenGrafik',2,0,10);
  readln;
  WerteEingeben;
  cleardevice;
  MittelPunktX := getMaxX div 2;
  MittelPunktY := getMaxY div 2;
  zeichneTortenGrafik;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Hauptprogramm                                                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
begin
  InstallGraph;

  if FehlerCode = 0 then
  begin
    Grafikwerte(Grafikmodus);
    TextDemo;
    Sternenhimmel;
    Sierpinski;
    LinienZeigen;
    Rechtecke;
    Balkengrafik;
    Kreise;
    TortenGrafik;
    closeGraph;
  end

  else
  begin
    clrscr;
    FehlerMeldung := GraphErrorMsg(Graphresult);
    Write(FehlerMeldung);
    readln;
  end;

end.
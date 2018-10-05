uses crt,graph,graph3d,alles;

const Pyramide : Objekt = (punkte : ((1,1,0),(3,1,0),(3,3,0),(1,3,0),(2,2,1.6));
                           linien : ((von:1;nach:2),(von:2;nach:3),(von:3;nach:4),
                                    (von:4;nach:1),(von:1;nach:5),(von:2;nach:5),
                                    (von:3;nach:5),(von:4;nach:5)));

var winkel : Real;

procedure zeichne_pyramide;

var i : Integer;

begin
 for i:=1 to anz_linien DO
  with pyramide DO
   zeichne_linie(punkte[linien[i].von],punkte[linien[i].nach]);
end;

begin
 winkel:=0;
 grd:=detect;
 initgraph(grd,grm,'');
 repeat
  parameter (4,winkel,1.4);
  setcolor(white);
  zeichne_pyramide;
  winkel:= winkel+delta;
  delay(1000);
  setcolor(black);
  zeichne_pyramide;
 until keypressed;
 closegraph;
end.
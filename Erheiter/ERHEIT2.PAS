Program Erheiterung;

uses crt, graph,alles;

var grd, grm : Integer;
    was      : word;

procedure grklar;

begin
 cleardevice;
end;
  
Begin
 grd:=detect;
 initgraph(grd,grm,'');
 was:=zufall(1,12);
 settextstyle (1,0,2);
 setcolor(white);
 case was of
  1      : outtextxy(100,150,'Ich, ich will weg von hier, dank E.K.');
  2      : outtextxy(100,150,'Special thanks to E.K. (Emil Kaiser)');
  3      : begin
            outtextxy (100,150,'Was ist Kai?');
            delay(2000);
            setcolor (yellow);
            outtextxy (100,200,'Kai ist doof!');
           end;
  4      : begin
            outtextxy (100,150,'Vobisleute sind Fachidioten');
            delay (2000);
            outtextxy (100,200,'Aber ohne Fach');
           end;
  5      : begin
            setcolor(yellow);
            outtextxy(10,150,'Was ist eine Blondiene mit gefÑrbtem Haar?');
            delay (2000);
            outtextxy (10,200,'KÅnstliche Intelligenz');
           end;
  6      : begin
            outtextxy (10,150,'Wem gehîrt die Fahrrad auf das Hof?');
            delay (2000);
            setcolor (red);
            outtextxy (10,200,'Mich!');
           end;
  7      : outtextxy(10,150,'Nachts ist es kÑlter als drau·en');
  8      : begin
            outtextxy(10,150,'In China ist ein Erdbeben, 1000 Tote und 10 Verletzte.');
            outtextxy(10,200,'Fragt ein Verletzter den anderen: "Willste auch`n Joghurt?"');
           end;
  9      : begin
            outtextxy (10,150,'H');
            delay (200);
            outtextxy (30,150,'A');
            delay (200);
            outtextxy (50,150,'L');
            delay (200);
            outtextxy (70,150,'L');
            delay (200);
            outtextxy (80,150,'O');
            delay (200);
            outtextxy (10,200,'E.K. (Erich Honniker)');
           end;
  10     : begin
            outtextxy (10,150,'Der Beste Witz Åberhaupt');
            delay (2000);
            outtextxy (10,200,'Triepstein, denn das Auge schlÑgt mit!');
           end;
  11     : begin
            outtextxy (10,150,'Was ist das gesÅndeste GetrÑnk Åberhaupt?');
            delay (2000);
            outtextxy (10,200,'Selters aus eigenem Anbau.(Nur Rigi ist besser)');
           end;
  12     : begin
            outtextxy (10,150,'Ich sage JA!!!!');
            delay (2000);
            outtextxy (10,200,'Ja zu Rigis Wasser. laut P.M. Magazin (poison mail Magazin)');
           end;
 end;
 waitkey;
end.
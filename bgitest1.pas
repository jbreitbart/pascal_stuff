program treibertest;
uses crt,graph;

var Treiber,Modus,z,x1,y1,x2,y2,MaxF,MaxX,MaxY,Farbe :integer;
    Taste                           :char;


begin
  clrscr;
{
EGAVGA   BGI
PARADISE BGI
SUPERVGA BGI
}
  Treiber := InstallUserDriver('paradise', nil);
  Modus := 3;   {0-5 fÅr den supervga.bgi-treiber}
  InitGraph(Treiber,Modus,'');
  MaxF := GetMaxColor;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  for z := 0 to 255 do
       begin
         SetFillStyle(1,z);
         x1 := z*3; x2 := x1+2; y1 := 0; y2 := 600;
         bar(x1,y1,x2,y2);
       end;
  SetColor(15);
  RecTangle(0,0,765,599);
  Taste:=ReadKey;
  CloseGraph;
  write('Farben: ',MaxF,' Auflîsung: ',MaxX,'x',MaxY);
  Taste := ReadKey
end.


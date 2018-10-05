uses crt,graph,alles,dos;

type Pbild=^TBild;
     TBild = record
              n : Pointer;
              i : array [0..639] of byte;
             end;

var Bild,wurzel : PBild;
    f : File;
    v : Pointer;
    a,b : Word;

procedure laden;
begin
 repeat
  new(bild);
  blockread(f,bild^.i,sizeof(bild^.i));
  bild^.n:=Wurzel;
  wurzel:=bild;
 until eof(f);
end;

procedure bildladen;
begin
 b:=getmaxy;
 while bild <> nil do begin
  for a:= getmaxx downto 0 DO putpixel(a,b,bild^.i[a]);
  b:=b-1;
  bild:=bild^.n;
 end;
end;

begin
 mark(v);
 grd:=detect;
 initgraph(grd,grm,'');
 assign(f,'c:\pascal\data\planet.mip');
 reset(f,1);
 bild:=nil;
 wurzel:=nil;
 laden;
 bild:=wurzel;
 bildladen;
 closegraph;
 release(v);
end.
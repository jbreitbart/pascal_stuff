uses crt,alles,graph;

var grd, grm: Integer;
    s : String;

procedure readtext3d(x,y : word; var s : string);

var taste : char;
    zusammen : array [0..255] of char;
    lv1,cursorpos,a : Laufvar;
    farbealt:byte;
    art : Textsettingstype;

begin
 s:='';
 a:=0;
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 255 DO zusammen[lv1]:='È';
 lv1:=0;
 gettextsettings(art);
 repeat
  setcolor (white);
  if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
  if keypressed then begin
    cursorpos:=cursorpos+1;
    taste:=readkey;
    setcolor (black);
    if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
    else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
    delay(300);
  if (taste = backspace) and (lv1>=1) then begin
   lv1:=lv1-1;
   if zusammen[lv1] <> ' ' then begin
    setcolor(black);
    line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
    x:=x-textwidth(zusammen[lv1]);
    for a := art.charsize downto 0 DO begin
    if (a <> art.charsize) then begin
      settextstyle (art.font,art.direction,a);
      setcolor(farbealt);
      outtextxy(x,y,zusammen[lv1]);
     end;
     delay(a*40);
     setcolor(getbkcolor);
     outtextxy(x,y,zusammen[lv1]);
    end;
  end
  else begin
   setcolor(black);
   line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
   x:=x-textwidth(zusammen[lv1]);
   outtextxy(x,y,zusammen[lv1]);
   zusammen[lv1]:='È';
 end;
  settextstyle (art.font,art.direction,art.charsize);
  zusammen[lv1]:='È';
  taste:='È';
  end;
  if taste = ' ' then begin
   setcolor(farbealt);
   outtextxy(x,y,taste);
   zusammen[lv1]:=taste;
   x:=x+textwidth(taste);
   lv1:=lv1+1;
  end;
  if (taste <> return) and (taste <> backspace) and (taste<>'È') and (taste<>' ') then
  begin
   for a := 0 to art.charsize DO begin
    settextstyle (art.font,art.direction,a);
    setcolor(farbealt);
    outtextxy(x,y,taste);
    delay(a*70);
    if a <> art.charsize then begin
     setcolor(getbkcolor);
     outtextxy(x,y,taste);
    end;
   end;
   zusammen[lv1]:=taste;
   x:=x+textwidth(taste);
   lv1:=lv1+1;
  end;
 end;
 delay(600);
 setcolor (black);
 if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='È' then exit;
  s:=s+zusammen[lv1];
 end;
end;

begin
 grd:=DETECT;
 initgraph(grd,grm,'');
 delay(40);
 settextstyle(2,0,10);
 readtext3d(10,10,s);
 closegraph;
 writeln(s);
end.
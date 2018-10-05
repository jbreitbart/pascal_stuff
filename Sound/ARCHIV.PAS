Program Sound_und_Specials;

Uses crt;

Var a,b,c,d,e,f,g:Integer;

Begin
 clrscr;
 Writeln ('Motorger„usch');
 for a:= 1 to 300 do
                  begin
                   sound(a);
                   delay (300);
                   nosound;
                  end;
 writeln ('Alarm');
 repeat
 for b:= 1 to 300 do
                  begin
                   sound(b);
                   delay (30);
                  end;
 nosound;
 until keypressed;
 readln;
 writeln ('MG');
 repeat
  for c:= 1 to 300 do
                   begin
                    sound (c);
                    delay (4);
                   end;
 nosound;
 until keypressed;
 readln;
 d:=200;
 e:=10;
 writeln('Telefon dauerton');
 repeat
  sound(d+e);
 until keypressed;
 nosound;
 readln;
 writeln('Alarm II');
 repeat
 for f:= 1 to 100 do
                  begin
                   delay (59);
                   sound (f);
                   delay (20);
                  end;
 until keypressed;
 nosound;
 readln;
 Writeln('Geheimcode');
 repeat
 for g:= 1 to 50 do
                 begin
                  sound(g);
                  sound(c);
                  delay(10);
                 end;
 until keypressed;
 nosound;
 readln;
 Writeln ('Flugzeug');
 repeat
 for a:= 1 to 100 do
                  begin
                   sound (a);
                   delay (1)
                  end;
                  nosound;
 until keypressed;
 readln;
 Writeln ('Trecker');
 repeat
 for a:= 1 to 100 do
                  begin
                   sound (a);
                   delay (3);
                  end;
  for a:= 1 to 200 do
                   begin
                    sound (a);
                    delay (6);
                  end;
 for a:= 20 to 400 do
                   begin
                    sound (a);
                    delay (1);
                   end;

 until keypressed;
 nosound;
 readln;
 writeln ('V”gel');
 repeat
 for a:= 1 to 1000 do
                  begin
                   sound (a);
                   delay (3);
                  end;
  for a:= 1 to 2000 do
                   begin
                    sound (a);
                    delay (6);
                  end;
 for a:= 20 to 4000 do
                   begin
                    sound (a);
                    delay (1);
                   end;
 for a:= 1 to 9000 do
                 begin
                  sound (a);
                  delay (2);
                  nosound;
                 end;
 until keypressed;
 nosound;
 Writeln ('Klingel');
 readln;
 sound (500);
 delay (10000);
 nosound;
 sound (300);
 delay (20000);
 nosound;
 readln;
 {}
 writeln ('Pausenglocke');
 sound (800);
 delay (20000);
 nosound;
 sound (600);
 delay (20000);
 nosound;
 sound (400);
 delay (15000);
 nosound;
 sound (200);
 delay (10000);
 nosound;
 readln;
 writeln ('Operette');
 sound (1000);
 delay (6000);
 nosound;
 sound (1000);
 delay (6000);
 nosound ;
 sound (1000);
 delay (6000);
 nosound;
 sound (800);
 delay (10000);
 nosound;
 delay (20000);
 sound (800);
 delay (6000);
 nosound;
 sound (800);
 delay (6000);
 nosound;
 sound (800);
 delay (6000);
 nosound;
 sound (600);
 delay (10000);
 nosound;
 readln;
 
end.
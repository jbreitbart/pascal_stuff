
Program werbung2;

uses crt,graph,utily;
var a,b,c,d,f :integer;
Begin
 grinit;
 settextstyle (2,0,7);
 outtextxy (200,200,'Stupid Two presents');
 delay (30000);
 outtextxy (250,230,'Red Buttons');
 delay (30000);
 outtextxy (180,260,'A storry by Two stupid dogs ');
 delay (30000);
 grklar;
 for a:= 50 to 100 do
 for b:= 50 to 100 do
 putpixel (a,b,green);
 for c:= 100 to 200 do
 for d:= 50 to 100 do
 putpixel (c,d,red);
 setcolor (0);
 settextstyle (2,0,5);
 outtextxy(120,60,'Open/close');
 setcolor (darkgray);
 randomize;
 rectangle (0,0,getmaxx,getmaxy);
 rectangle (200,200,500,500);
 rectangle (190,190,510,510);
 settextstyle (2,0,7);
 outtextxy (100,100,'±');
 setcolor (red);
 outtextxy (100,130,'±');
 setcolor (yellow);
 outtextxy (100,160,'±');
 setcolor (darkgray);
 outtextxy (250,50,'ÉÍÍÍÍÍÍÍÍÍÍÍÍsteuerÍÍÍÍÍÍÍÍÍÍÍÍ»');
 outtextxy (250,70,'                ±               ');
 repeat
 for f:= 1 to 100 do
                  begin
                   delay (59);
                   sound (f);
                   delay (20);
                  end;
 setcolor (random(15));
 outtextxy (201,200,'Dont press the red Button');
 outtextxy (201,220,'Roten Knopf nicht drcken');
 outtextxy (201,240,'Nocht drock rocht knochpf');
 setcolor (random(15));
 outtextxy (250,70,' ±±±±±±±±±±±±±±±±±±±±±± ');
 setcolor (yellow);
 outtextxy (201,260,'±');
 until keypressed;
 nosound;
 readln;
 grklar;
 for a:= 50 to 100 do
 for b:= 50 to 100 do
 putpixel (a,b,red);
 for c:= 100 to 200 do
 for d:= 50 to 100 do
 putpixel (c,d,green);
 setcolor (0);
 settextstyle (2,0,5);
 outtextxy(120,60,'>>>Open<<<');
 setcolor (darkgray);
 randomize;
 rectangle (0,0,getmaxx,getmaxy);
 rectangle (200,200,500,500);
 rectangle (190,190,510,510);
 settextstyle (2,0,7);
 outtextxy (100,100,'±');
 setcolor (red);
 outtextxy (100,130,'±');
 setcolor (yellow);
 outtextxy (100,160,'±');
 setcolor (darkgray);
 outtextxy (250,50,'ÉÍÍÍÍÍÍÍÍÍÍÍÍsteuerÍÍÍÍÍÍÍÍÍÍÍÍ»');
 outtextxy (250,70,'                ±               ');
 repeat
 for f:= 1 to 100 do
                  begin
                   delay (59);
                   sound (f);
                   delay (20);
                  end;
 setcolor (random(15));
 outtextxy (201,200,'Oh OH!!!!!!!');
 outtextxy (201,220,'Scheiáe!!!!!!!');
 outtextxy (201,240,'Och !!!!!!!!');
 setcolor (random(15));
 outtextxy (250,70,' ±±±±±±±±±±±±±±±±±±±±±± ');
 setcolor (yellow);
 outtextxy (201,260,'±');
 until keypressed;
 nosound;
 grout;
end.
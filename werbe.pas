
Program Werbung;

uses crt,alles, utily, graph;

Var x,y,a,b:integer;
Begin
 grinit;
 settextstyle (1,0,4);
 outtextxy (80,100,'Die Macher von Day of the Dogs');
 outtextxy (80,110,'______________________________');
 delay (3000);
 outtextxy (150,190,'  Pr„sentieren');
 delay (2500);
 grklar;
 settextstyle (1,0,7);
 outtextxy (80,100,'Two stupid Dogs');
 delay (3000);
 x:=300;
 y:=250;
 setcolor (red);
 circle (x,y,70);
 settextstyle (1,0,1);
 outtextxy (250,250,'Red Buttons');
 delay (2000);
 grout;
end.
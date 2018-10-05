Program SoundTest;

{ *-------------------------------* }
{ |                               | }
{ | Abspielen von .SND mit Pascal | }
{ |                               | }
{ |   (c) Copyright Kai Burkard   | }
{ |                               | }
{ *-------------------------------* }


Uses Crt, Graph, Gemischt;

Begin
 GrafikModus;
 LoadIcon(30,30,'Funicon',7);
 SetTextStyle(5,0,1);
 OutTextXY(75,37,'Fun Softwars Entertaiment');
 LoadIcon(30,215,'Speaker',White);
 SetTextStyle(8,0,4);
 SetTextJustify(CenterText,CenterText);
 SetColor(White);
 OutTextXY(320,240,'Sound by Kai Burkard');
 SetColor(Brown);
 Line(0,271,639,271);
 Line(0,218,639,218);
 SetColor(LightRed);
 Line(0,259,043,259);
 SetColor(LightBlue);
 Line(0,257,042,257);
 PlaySnd('C:\Pascal\Sound\Mix1.snd');
 WaitKey;
 CloseGraph;
End.
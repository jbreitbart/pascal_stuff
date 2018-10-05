{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autorin: Gabi Rosenbaum    22.10.92              �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 �Programm Fenster1                                                 �
 ������������������������������������������������������������������ͼ}
Program Fenster1;                                       {Fenster1.pas}
uses
  crt;

Type
  TRahmen = Array[0..6] of Char;

Const
  RahmenNormal : TRahmen =
  ('�','�','�',
   '�',
   '�','�','�');

{������������������������������������������������������������������Ŀ
 �Objekt TFenster                                                   �
 ��������������������������������������������������������������������}
Type
  TFenster = Object
               As,Az,
               Es,Ez    : Word;    {Anfang/Ende von Zeile und Spalte.}
               RahmenArt: TRahmen;
               Procedure Init(AAs,AAz,AEs,AEz: Word);
               Procedure Zeichne;
             end;
{������������������������������������������������������������������Ŀ
 �Procedure TFenster.Init                                           �
 ������������������������������������������������������������������Ĵ
 �Initialisiert die Werte f�r die Ecken des Fensters.               �
 ��������������������������������������������������������������������}
Procedure TFenster.Init;
Begin
  As := AAs;
  Es := AEs;
  Az := AAz;
  Ez := AEz;
  RahmenArt := RahmenNormal;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TFenster.Zeichne                                        �
 ������������������������������������������������������������������Ĵ
 �Zeichnet ein Fenster auf den Bildschirm.                          �
 ��������������������������������������������������������������������}
Procedure TFenster.Zeichne;
Var
  I : Word;
Begin
  Gotoxy(As,Az);                              {Die 4 Ecken zeichnen.}
  Write(RahmenArt[0]);
  Gotoxy(Es,Az);
  Write(RahmenArt[2]);
  Gotoxy(As,Ez);
  Write(RahmenArt[4]);
  Gotoxy(Es,Ez);
  Write(RahmenArt[6]);

  For I := Az+1 to Ez-1 do         {Die beiden Senkrechten zeichnen.}
  Begin
    Gotoxy(As,I);
    Write(RahmenArt[3]);
    Gotoxy(Es,I);
    Write(RahmenArt[3]);
  end;                                                     {von for.}

  For I := As+1 to Es-1 do        {Die beiden Waagerechten zeichnen.}
  Begin
    Gotoxy(I,Az);
    Write(RahmenArt[1]);
    Gotoxy(I,Ez);
    Write(RahmenArt[5]);
  end;                                                    {von for.}

end;                                                  {von Zeichne.}


Var
  Rahmen1,
  Rahmen2  : TFenster;
Begin
  ClrScr;
  Rahmen1.Init(5,5,75,20);
  Rahmen1.Zeichne;
  Rahmen2.Init(8,7,30,14);
  Rahmen2.Zeichne;
  ReadLn;
  ClrScr;
End.

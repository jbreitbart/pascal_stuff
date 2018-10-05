
{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autorin: Gabi Rosenbaum    22.10.92              �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 �Programm Fenster2                                                 �
 ������������������������������������������������������������������ͼ}
Program Fenster2;                                       {Fenster2.pas}
uses
  crt;

Type
  TRahmen = Array[0..6] of Char;

Const
  RahmenNormal : TRahmen =
  ('�','�','�',
   '�',
   '�','�','�');
  RahmenDoppelt : TRahmen =
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

Const
   raEinfach = 0;
   raDoppelt = 1;

{������������������������������������������������������������������Ŀ
 �Objekt TFenster2                                                  �
 ��������������������������������������������������������������������}
Type
   TFenster2 = Object(TFenster)
                 KopfName: String;
                 FensterNr : Word;
                 Procedure Init(AAs,AAz,AEs,AEz: Word;AFensterNr: Word);
                 Procedure Setzerahmen(ARahmenArt: Word);
                 Procedure KopfZeile(AKopfName: String);
                 Procedure Zeichne;
                 Procedure Cursor(OnOff: Boolean);
                 Procedure SchreibeFensterNr;
               end;

{������������������������������������������������������������������Ŀ
 �Procedure TFenster2.Init                                          �
 ������������������������������������������������������������������Ĵ
 �Initialisiert das Fenster.                                        �
 ��������������������������������������������������������������������}
Procedure TFenster2.Init;
Begin
  inherited Init(AAs,AAz,AEs,AEz);
  FensterNr := AFensterNr;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TFenster2.Kopfzeile                                     �
 ������������������������������������������������������������������Ĵ
 �Gibt eine Kopfzeile auf dem Fenster aus.                          �
 ��������������������������������������������������������������������}
Procedure TFenster2.KopfZeile;
Begin
  KopfName := AKopfName;
  Gotoxy(As+(Es-As-Length(KopfName)) DIV 2, Az);
  Write(' ',KopfName,' ');
end;

{������������������������������������������������������������������Ŀ
 �Procedure TFenster2.SetzeRahmen                                   �
 ������������������������������������������������������������������Ĵ
 �Bestimmt ob ein Rahmen einfach oder doppelt gezeichnet wird.      �
 ��������������������������������������������������������������������}
Procedure TFenster2.SetzeRahmen;
Begin
  If Boolean(ARahmenArt) then
  RahmenArt := RahmenDoppelt else
  RahmenArt := RahmenNormal;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TFenster2.Zeichne                                       �
 ������������������������������������������������������������������Ĵ
 �Schreibt den Rahmen und die Fensternummer auf den Bildschim.      �
 ��������������������������������������������������������������������}
Procedure TFenster2.Zeichne;
Begin
  Cursor(False);
  inherited Zeichne;
  SchreibeFensterNr;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TFenster2.SchreibeFensterNr                             �
 ������������������������������������������������������������������Ĵ
 �Gibt eine Fensternummer auf dem Bildschirm aus.                   �
 ��������������������������������������������������������������������}
Procedure TFenster2.SchreibeFensterNr;
Begin
  GotoXY(Es-5,Az);
  Write('Nr.',FensterNr);
end;

{������������������������������������������������������������������Ŀ
 �Procedure TFenster2.Cursor                                        �
 ������������������������������������������������������������������Ĵ
 �Assemblerroutine, die den Cursor auf dem Bildschirm ein- und aus- �
 �schaltet.                                                         �
 ��������������������������������������������������������������������}
Procedure TFenster2.Cursor;Assembler;
Asm
     XOR Ax,Ax                                            {Ax auf 0.}
     MOV Al,OnOff                      {Cursor an- oder ausschalten?}
     Or  Al,Al
     JA  @1                                   {Wenn on dann nach @1.}
     SUB Ax,Ax                                            {Ax auf 0.}
     MOV Ah,01h                                       {Funktion 01h.}
     MOV Ch,20h                              {Ch auf gleichen Wert..}
     MOV Cl,20h                                           {..wie Cl.}
     INT 10h                                    {Bios-Interrupt 10h.}
     JMP @3                                      {ans Ende springen.}
@1:                                     {Routine Cursor einschalten.}
     Xor Ax,Ax                                            {Ax auf 0.}
     Mov Ah,0Fh                                       {Funktion 0Fh.}
     Int 10h                                    {Bios-Interrupt 10h.}
     Cmp Ah,7                                    {Wenn Ergebnis = 7.}
     JE  @2                          {Dann liegt Farbbildschirm vor.}
     XOR Al,Al                                            {Al auf 0.}
     MOV AH,01h                                       {Funktion 01h.}
     MOV CX,0607h                            {Cursorgr��e festlegen.}
     INT 10h                                    {Bios-Interrupt 10h.}
     JMP @3                                      {ans Ende springen.}
@2:                                 {Routine f�r den Farbbildschirm.}
     SUB Al,Al                                            {Al auf 0.}
     MOV Ah,01h                                       {Funktion 01h.}
     MOV CX,0C0Dh                            {Cursorgr��e festlegen.}
     INT 10h                                    {Bios-Interrupt 10h.}
@3:                                               {Ende der Routine.} 
end;

Var
  Rahmen1,
  Rahmen2  : TFenster2;
Begin
  ClrScr;
  Rahmen1.Init(5,5,75,20,1);
  Rahmen1.Zeichne;
  Rahmen1.KopfZeile('Das erste Fenster');
  Rahmen2.Init(8,7,50,14,2);
  Rahmen2.SetzeRahmen(raDoppelt);
  Rahmen2.Zeichne;
  Rahmen2.KopfZeile('Das zweite Fenster');
  ReadLn;
  ClrScr;
  Rahmen2.Cursor(True);
End.

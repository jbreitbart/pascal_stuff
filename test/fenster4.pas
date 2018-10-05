
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autorin: Gabi Rosenbaum    22.10.92              �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 �Programm Fenster4                                                 �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Fenster4;                                      {Fenster4.pas}
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

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Objekt TFenster                                                   �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Type
  TFenster = Object
               As,Az,
               Es,Ez    : Word;    {Anfang/Ende von Zeile und Spalte.}
               RahmenArt: TRahmen;
               Constructor Init(AAs,AAz,AEs,AEz: Word);
               Procedure Zeichne; Virtual;
             end;
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Constructor TFenster.Init                                         �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Initialisiert die Werte f�r die Ecken des Fensters.               �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Constructor TFenster.Init;
Begin
  As := AAs;
  Es := AEs;
  Az := AAz;
  Ez := AEz;
  RahmenArt := RahmenNormal;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TFenster.Zeichne                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Zeichnet ein Fenster auf den Bildschirm.                          �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Objekt TFenster2                                                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Type
   TFenster2 = Object(TFenster)
                 KopfName: String;
                 FensterNr : Word;
                 Constructor Init(AAs,AAz,AEs,AEz: Word;AFensterNr: Word);
                 Procedure Setzerahmen(ARahmenArt: Word); virtual;
                 Procedure KopfZeile(AKopfName: String); virtual;
                 Procedure Zeichne; virtual;
                 Procedure Cursor(OnOff: Boolean); 
                 Procedure SchreibeFensterNr;  virtual;
               end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Constructor TFenster2.Init                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Initialisiert das Fenster.                                        �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Constructor TFenster2.Init;
Begin
  Inherited Init(AAs,AAz,AEs,AEz);
  FensterNr := AFensterNr;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TFenster2.Kopfzeile                                     �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Gibt eine Kopfzeile auf dem Fenster aus.                          �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TFenster2.KopfZeile;
Begin
  KopfName := AKopfName;
  Gotoxy(As+(Es-As-Length(KopfName)) DIV 2, Az);
  Write(' ',KopfName,' ');
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TFenster2.SetzeRahmen                                   �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Bestimmt ob ein Rahmen einfach oder doppelt gezeichnet wird.      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TFenster2.SetzeRahmen;
Begin
  If Boolean(ARahmenArt) then
  RahmenArt := RahmenDoppelt else
  RahmenArt := RahmenNormal;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TFenster2.Zeichne                                       �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Schreibt den Rahmen und die Fensternummer auf den Bildschim.      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TFenster2.Zeichne;
Begin
  Cursor(False);
  inherited Zeichne;
  SchreibeFensterNr;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TFenster2.SchreibeFensterNr                             �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Gibt eine Fensternummer auf dem Bildschirm aus.                   �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TFenster2.SchreibeFensterNr;
Begin
  GotoXY(Es-5,Az);
  Write('Nr.',FensterNr);
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TFenster2.Cursor                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Assemblerroutine, die den Cursor auf dem Bildschirm ein- und aus- �
 �schaltet.                                                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Objekt TFenster3                                                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Type
   TFenster3 = Object(TFenster2)
     Procedure SchreibeFensterNr; virtual;
   end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TFenster3.SchreibeFensterNr                             �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Gibt eine Fensternummer auf dem Rahmen aus.                       �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TFenster3.SchreibeFensterNr;
Begin
  GotoXY(Es-2,Az);
  Write(FensterNr);
end;


Var
  Rahmen1,
  Rahmen2  : TFenster3;
Begin
  ClrScr;
  Rahmen1.Init(5,5,75,20,1);
  Rahmen1.Zeichne;
  Rahmen1.KopfZeile('Das erste Fenster');
  Rahmen2.Init(8,7,50,14,2);
  Rahmen2.Zeichne;
  Rahmen2.KopfZeile('Das zweite Fenster');
  ReadLn;
  ClrScr;
  Rahmen2.Cursor(True);
End.

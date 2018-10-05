
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autorin: Gabi Rosenbaum    22.10.92              �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 �Programm Fenster5                                                 �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Fenster5;                                      {Fenster5.pas}
uses
  crt, dos;

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
 �Procedure TFenster.Init                                           �
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
 �Objekt TFenster                                                   �
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
 �Procedure TFenster2.Init                                          �
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


Type
 PVirtualScr   = ^TVirtualScr;           
 TVirtualScr   = ARRAY[1..4000] of Byte;                              

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Objekt TBildschirm                                                �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
 PBildSchirm = ^TBildSchirm;
 TBildSchirm = Object
                 Sichern    : PVirtualScr;
                 Puffer     : PVirtualScr;
                 Addr       : Word;
                 Constructor Init;
                 Destructor  Done;Virtual;
                 Procedure   Write(X,Y: Byte; Str: String;
		                   Attr: Byte);Virtual;
                 Procedure   Push;Virtual;
                 Procedure   Pop;Virtual;
                 Function    GetAddr: Word;
                 Procedure   Clearbuf;
 end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Constructor TBildschirm.Init                                      �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Initialisiert die Zeiger f�r den Bildschirmpuffer                 �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}

Constructor TBildSchirm.Init;
Var
  P : Pointer;
Begin
   Addr := GetAddr;            {Ermittelt die Adresse des Bildschims.}
   Sichern := New(PVirtualScr);              {Erzeugt zwei Zeiger auf}
   Puffer  := New(PVirtualScr);                      {den Bildschirm.}
   P := PTR(Addr,$0);       {Konvertiert die Adresse in einen Zeiger.}     
   Move(P^,Sichern^,4000);      {Kopiert den Inhalt von P in Sichern.}
   Puffer^ := Sichern^;   {Schreibt den Inhalt von Sichern in Puffer.}
end;                                                           {Init.}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Destructor TBildschirm.Done                                       �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Entfernt die dynamischen Variablen vom Heap.                      �  
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Destructor TBildSchirm.Done;
Begin
  Dispose(Sichern);
  Dispose(Puffer);
end;                                                          {Done.}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Function TBildschrim.Getaddr                                      �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Ermittelt die Adresse eines Farb- oder Monochrombildschirms       �  
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Function TBildSchirm.GetAddr: Word;
Var
  Color: Boolean;
  Regs : Registers;
Begin
  Color := True;
  intr($11,Regs);
  If (regs.Ax and 48) = 48 then
  Color := False;
  If Color then GetAddr := $B800 else
                GetAddr := $B000;
end;                                                       {GetAddr.}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TBildschirm.Write                                       �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Schreibt neue Zeichen in den Bildschirmpuffer.                    �  
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TBildSchirm.Write;
Var
  Anfang: Word;
  I     : Word;
Begin
 If Puffer <> NIL then
 Begin
  Anfang := (X-1) + ((Y-1)*80);
  For I := Anfang to Anfang + (Length(Str)-1) do
  Begin
   Puffer^[(I*2)+1] := Ord(Str[I-Anfang+1]);
   Puffer^[(I*2)+2] := Attr;
  end;                                                      {von for.}
 end;                                                        {von if.}
end;                                                          {Write.}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TBildschirm.Push                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Gibt den Bildschirmpuffer auf dem Bildschirm aus.                 �  
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TBildSchirm.Push;
Var
  P : Pointer;
Begin
  P := PTR(Addr,$0);
  Move(Puffer^,P^,4000);
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TBildschirm.Pop                                         �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Sichert den Inhalt des Bildschirm in den Puffer.                  �  
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TBildSchirm.Pop;
Var
  P : Pointer;
Begin
  P := PTR(Addr,$0);
  Move(Sichern^,P^,4000);
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TBildschirm.ClearBuf                                    �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Schreibt den Inhalt von Puffer in Sichern.                        �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure TBildschirm.ClearBuf;
begin
  Puffer^ := Sichern^;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Objekt TFenster5                                                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Type
   PFenster5 = ^TFenster5;
   TFenster5 = Object(TFenster3)
     BildSchirm:  PBildSchirm;
     Farbe     :  Word;
     Constructor Init(AAs,AAz,AEs,AEz: Word;AKopfName: String; AFensterNr: Word);
     Procedure SetzeFarbe(VorderGrund,HinterGrund: Word);
     Destructor  Done;Virtual;
     Procedure Zeichne;Virtual;
   end;


{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Constructor TFenster5.Init                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Initialisiert das Objekt. Erzeugt einen Zeiger auf den Bildschirm.�
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Constructor TFenster5.Init;
Begin
  inherited Init(AAs,AAz,AEs,AEz,AFensterNr);
  KopfName := AKopfName;
  BildSchirm := New(PBildSchirm,Init);
  Farbe := 112;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TFenster5.SetzeFarbe                                    �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Setzt Vorder- und Hintergrundfarbe f�r die Fenster.               �  
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TFenster5.SetzeFarbe;
Begin
  Farbe := 0;
  Farbe := HinterGrund SHL 4;
  Farbe := Farbe + VorderGrund;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Destructor TFenster5.Done                                         �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Entfernt die dynamischen Variablen vom Heap.                      �  
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Destructor TFenster5.Done;
Begin
  BildSchirm^.Pop;
  Dispose(Bildschirm,Done);
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TFenster5.Zeichne;                                      �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Schreibt den neuen Bildschirm im Puffer und gibt den gesamten     �  
 �Inhalt des Puffers auf dem Bildschirm aus.                        �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TFenster5.Zeichne;
Var
  I,J    : Word;
  StrNr  : String;
Begin
                                               {Die 4 Ecken zeichnen.}
  BildSchirm^.Write(As,Az,RahmenNormal[0],Farbe);
  BildSchirm^.Write(Es,Az,RahmenNormal[2],Farbe);
  BildSchirm^.Write(As,Ez,RahmenNormal[4],Farbe);
  BildSchirm^.Write(Es,Ez,RahmenNormal[6],Farbe);
                                    {Die beiden Senkrechten zeichnen.}
  For I := Az+1 to Ez-1 do
  Begin
    BildSchirm^.Write(As,I,RahmenNormal[3],Farbe);
    BildSchirm^.Write(Es,I,RahmenNormal[3],Farbe);
  end;
                                   {Die beiden Waagerechten zeichnen.}
  For I := As+1 to Es-1 do
  Begin
    BildSchirm^.Write(I,Az,RahmenNormal[1],Farbe);
    BildSchirm^.Write(I,Ez,RahmenNormal[5],Farbe);
  end;
                                      {Den Bildschirminhalt ausmalen.}
  For I := As+1 to Es-1 do
  For J := Az+1 to Ez-1 do
  BildSchirm^.Write(I,J,' ',Farbe);
                                             {Die Kopfzeile zeichnen.}
  BildSchirm^.Write(As+(Es-As-Length(KopfName)) DIV 2, Az,
                    ' '+KopfName+' ',Farbe);
                                         {Die FensterNummer zeichnen.}
  Str(FensterNr,StrNr);
  GotoXY(Es-2,Az);
  BildSchirm^.Write(Es-2,Az,StrNr,Farbe);
  BildSchirm^.Push;              {Den gesamten Bildschirm darstellen.}
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure Cursor                                                  �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Assemblerroutine, die den Cursor auf dem Bildschirm ein- und aus- �
 �schaltet.                                                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure Cursor(OnOff: Boolean); Assembler;
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
@3:
end;

Var
  Rahmen1,
  Rahmen2  : TFenster5;
Begin
  ClrScr;
  Cursor(False);
  Rahmen1.Init(5,5,75,20,'Das erste Fenster',1);
  Rahmen1.SetzeFarbe(0,7);
  Rahmen1.Zeichne;
  ReadLn;
  Rahmen2.Init(8,7,50,14,'Das zweite Fenster',2);
  Rahmen2.SetzeFarbe(7,0);
  Rahmen2.Zeichne;
  ReadLn;
  Rahmen2.Done;
  ReadLn;
  Rahmen1.Done;
  Cursor(True);
End.



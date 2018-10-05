{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autorin: Gabi Rosenbaum 28.10.1992               �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 �  Assemblerdemo, Cursor einstellen                                �
 ������������������������������������������������������������������ͼ}
Program AssemblerDemo_01;                    {Asm02.pas}
Uses
  Crt, Dos;                      {Units aus Turbo Pascal}

Type
  MonTyp = (Mono,Color);               {Entscheidungsset
                              f�r Mono- und Colormonitor}

Var
  VideoAdresse : Word;   {ermittelte Videoanfangsadresse}
  MonitorTyp   : MonTyp;        {Variable f�r Monitortyp}

{���������������������������������������������������������}
{ Videokarte ermitteln                                    }
{���������������������������������������������������������}
Procedure VideoKarte;
Var
  Dummy : Byte;         {Schnittstelle vom Assemblerblock
                                             zur Prozedur}
Begin
  ASM
   Xor  Ax,Ax                    {Ax auf 0 initialisieren}
   Mov  Ah,0Fh                        {Funktionsaufruf 0F
                                      - Videostatus lesen}
   Int  10h                       {Interrupt 10h aufrufen}
   mov  Dummy,al                     {Ergebnis nach Dummy}
  end;
  Case Dummy  of
    {Wenn Ah = 0..3 liegt ein Colormonitor (Textmodus)vor}
    0..3    : Begin
                VideoAdresse   := $B800;
                MonitorTyp     := Color;
              End;
       {Wenn Ah = 7 liegt ein Monomonitor vor (Textmodus)}
    7       : Begin
                VideoAdresse   := $B000;
                MonitorTyp     := Mono;
              End;
  End;   {Case}
End;     {Videokarte}

{���������������������������������������������������������}
{ Cursor ausschalten                                      }
{���������������������������������������������������������}
Procedure CursorOff; Assembler;
ASM
  Xor  Ax,Ax                     {Ax auf 0 initialisieren}
  Mov  Ah,01h          {Funktionsaufruf 01h - Cursorgr��e}
  Mov  Ch,20h                       {Cursoranfangswert...}
  Mov  Cl,20h                {...auf Cursorendwert setzen}
  Int  10h                         {Interrupt 10 aufrufen}
end;{CursorOff}

{���������������������������������������������������������}
{ Strichcursor einschalten                                }
{���������������������������������������������������������}
Procedure CursorStrich;
Begin
  Case Monitortyp of
  Mono: Begin
         ASM
          Mov  Ah,01h   {Funktionsaufruf 01h - Cursorgr��e}
          Mov  CX,0C0Dh {Cursorgr��e im CX Register setzen}
          Int  10h                 {Interrupt 10h aufrufen}
         end;
        end;
  Color: Begin
          ASM
           Mov  Ah,01h  {Funktionsaufruf 01h - Cursorgr��e}
           Mov  CX,0607h       {Cursorgr��e im CX Register
                                                    setzen}
           Int  10h                {Interrupt 10h aufrufen}
          end;
         end;
   end;{Case}
end;{Cursorstrich}

{���������������������������������������������������������}
{ Blockcursor einschalten                                 }
{���������������������������������������������������������}
procedure CursorBlock;
Label Mon;       {Label f�r Sprung nach Monomonitorroutine}
Var
  Index : Byte;      {Entscheidungsvariable f�r Monitortyp}
Begin
                                     {Index initialisieren}
 If MonitorTyp = Mono then Index := 0
                      else Index := 1;
 ASM
       Xor  Ax,Ax                 {Ax auf 0 initialisieren}
       Mov  Ah,01h      {Funktionsaufruf 01h - Cursorgr��e}
       Mov  Ch,00h              {Cursoranfang auf 0 setzen}
       Mov  Al,1           {Vergleichsoperant auf 1 setzen}
       cmp  Al,Index             {al mit Index vergleichen}
       jl   Mon   {Wenn Index < 1 dann nach Mon springen..}
       Mov  Cl,07     {.. sonst Cursorende auf 07 setzen..}
       jmp  @01         {.. und nach Sprungmarke @01 gehen}
 Mon:  Mov  Cl,0D               {Cursorende auf 0Dh setzen}
 @01:  Int  10h                    {Interrupt 10h aufrufen}
 End;  {Asm}
End;   {CursorBlock}

{���������������������������������������������������������}
{ Hauptprogramm zur Demonstration der Assemblerroutinen   }
{���������������������������������������������������������}
begin
  VideoKarte;                        {Videokarte ermitteln}
  ClrScr;                              {Bildschirm l�schen}
  Write(^J^J'  Cursor ist weg --> ');
  CursorOff;                           {Cursor ausschalten}
  ReadLn;
  Write(^J'  Strichcursor   --> ');
  CursorStrich;                  {Strichcursor einschalten}
  ReadLn;
  Write(^J'  Blockcursor    --> ');
  CursorBlock;                    {Blockcursor einschalten}
  ReadLn;
  CursorStrich;                       {Wieder Strichcursor}
end.{Asm02.pas}

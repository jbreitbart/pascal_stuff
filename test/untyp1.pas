{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Kopierprogramm: Verwendet untypisierte Dateien.                  �
 ������������������������������������������������������������������ͼ}
Program KopierProgramm;                            {Datei: Untyp1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Quelle, Ziel: file;                                 {Dateivariablen}
  Quelldatei,                          {Diskettendatei der Quelldatei}
  Zieldatei: string;                    {Diskettendatei der Zieldatei}
  Gelesen: integer;                                 {Gelesene Records}
  Buf: array[1..5120] of byte;                        {5 KByte Puffer}

begin
  ClrScr;
  writeln('Kopierprogramm');
  writeln;

  write('Gib die Quelldatei an: ');
  readln(Quelldatei);
  Assign(Quelle,Quelldatei);
  {$I-}  Reset(Quelle,1);  {$I+}

  if IOResult <> 0
  then begin {1} {�����������������������Quelldatei nicht vorhanden��}
         write(^G);                                          {Piepton}
         writeln('Datei ',Quelldatei,' nicht vorhanden!');
         writeln;
         writeln('Programm wird beendet.');
       end {then (1)}
  else begin {1} {�����������������������������Quelldatei vorhanden��}
         write('Gib die Zieldatei an: ');
         readln(Zieldatei);
         Assign(Ziel,Zieldatei);
         {$I-}  Rewrite(Ziel,1);  {$I+}

         if IOResult <> 0
         then begin {2} {����Zieldatei konnte nicht ge�ffnet werden��}
                write(^G);                                   {Piepton}
                writeln('Fehler beim �ffnen der Zieldatei!');
                writeln;
                writeln('Programm wird beendet.');
              end {then (2)}
         else begin {2} {������������������������Datei wird kopiert��}
                write('Es werden ',FileSize(Quelle));
                writeln(' Bytes kopiert!');
                BlockRead(Quelle,Buf,SizeOf(Buf),Gelesen);

                while Gelesen > 0 do
                begin
                  BlockWrite(Ziel,Buf,Gelesen);
                  BlockRead(Quelle,Buf,SizeOf(Buf),Gelesen);
                end; {while}

                Close(Quelle);
                Close(Ziel);
                writeln;
                writeln('***** Kopiervorgang beendet *****');
              end; {else (2)}
       end; {else (1)}

  GotoXY(1,25);
  write('Bitte [Return]-Taste dr�cken...'); 
  readln;                                        {Auf [Return] warten}
end.
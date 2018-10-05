{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autorin: Gabi Rosenbaum    12.10.92              �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 �Fehlerhaftes Programm zur Fehlersuche mit dem Debugger            �
 ������������������������������������������������������������������ͼ}
program DebugDemo;  {Debug.PAS}
uses crt;

const
  maxZahl =  9;                             {Zufallszahlen 0..maxZahl}
  maxAnz  =  5;                              {Anzahl der Feldelemente}

var
  ZufallsZahlen: array[1..maxAnz] of integer;
  Sortieren    : array[1..maxAnz] of integer;

{������������������������������������������������������������������Ŀ
 �Procedure FelderInitialisieren;                                   �
 ��������������������������������������������������������������������}
Procedure FelderInitialisieren;

var  i: integer;                                        {Laufvariable}

begin

  for i:= 1 to maxAnz do
  begin
    zufallsZahlen[i]:= 0;
    sortieren[i]    := 0;
  end;                                                      {von for}

end;

{������������������������������������������������������������������Ŀ
 �procedure Erzeugen;                                               �
 ��������������������������������������������������������������������}
procedure Erzeugen;

var
  i: integer;                                           {Laufvariable}

begin

  for i:= 1 to maxAnz do
  begin
    randomize;
                                          {Initialisierung des Feldes}
    zufallsZahlen[i]:= random(maxZahl+1);
  end;                                                       {von for}

end;

{������������������������������������������������������������������Ŀ
 �procedure Sort;                                                   �
 ��������������������������������������������������������������������}
procedure Sort;

var
  i,k,m: integer;                                      {Laufvariablen}
  ok   : boolean;                                   {Sortieren fertig}

begin
  ok:= false;                            {Sortieren noch nicht fertig}
  i := 1;
  k := 0;

  repeat

    while i <= maxAnz do
    begin
      for m:= 1 to maxAnz do
      begin

        if zufallsZahlen[m] = k then
        begin
          sortieren[i]:= k;
          i:= i + 1;
        end;                                                  {von if}

      end;                                                   {von for}
      k:= k + 1;

    end;                                                   {von while}

    if i = maxAnz then
                  ok:= true;
  until ok;

end;
{������������������������������������������������������������������Ŀ
 �procedure Ausgabe;                                                �
 ��������������������������������������������������������������������}
procedure Ausgabe;
var
  i: integer;                                           {Laufvariable}

begin
  clrscr;
  write('Erzeugte  Zufallszahlen: ');

  for i:= 1 to maxAnz do
            write(zufallsZahlen[i]:5,',');
  writeln;
  write('Sortierte Zufallszahlen: ');

  for i:= 1 to maxAnz do
            write(sortieren[i]:5,',');
  writeln;
  writeln;
  writeln('Bitte [Return] dr�cken...');
  readln;
end;

{������������������������������������������������������������������Ŀ
 �Hauptprogramm                                                     �
 ��������������������������������������������������������������������}
begin
  clrscr;
  FelderInitialisieren;
  Erzeugen;
  Sort;
  Ausgabe;
end.
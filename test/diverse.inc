{������������������������������������������������������������������Ŀ
 � Sterne                                                           �
 ������������������������������������������������������������������Ĵ
 � Zeichnet eine bestimmte Anzahl von Sternen auf den Bildschirm.   �
 ��������������������������������������������������������������������}
procedure Sterne(Anz: integer);
var i: integer;                                         {Z�hlvariable}

begin
  for i:= 1 to Anz do write('*');
end; {Sterne}
{������������������������������������������������������������������Ŀ
 � Linien                                                           �
 ������������������������������������������������������������������Ĵ
 � Zeichnet eine Linie auf den Bildschirm.                          �
 ��������������������������������������������������������������������}
procedure Linien(Laenge: integer);
const
  Zeichen = #196;                                      {ASCII-Zeichen}

var
  i: integer;                                           {Z�hlvariable}

begin
  for i:= 1 to Laenge do write(Zeichen);
end; {Linien}
{������������������������������������������������������������������Ŀ
 � Warten                                                           �
 ������������������������������������������������������������������Ĵ
 � Wartet in der 25. Zeile auf einen beliebigen Tastendruck.        �
 ��������������������������������������������������������������������}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
end; {Warten}
{��������������������������������������������������������������������}
Unit OvrUnit2;                                   {Datei: OvrUnit2.pas}
{$F+,O+}                           {FAR-Codierung und Overlay allowed}

{������������������������������������������������������������������Ŀ
 � Interface                                                        �
 ��������������������������������������������������������������������}
Interface
  procedure Meldung2;

{������������������������������������������������������������������Ŀ
 � Implementation                                                   �
 ��������������������������������������������������������������������}
Implementation
uses
  Crt;                                   {Bibliothek aus Turbo Pascal}

{������������������������������������������������������������������Ŀ
 � Meldung2                                                         �
 ��������������������������������������������������������������������}
procedure Meldung2;
begin
  writeln('Hier meldet sich Overlay-Datei 2');
  Delay(1000);
end; {Meldung2}
{������������������������������������������������������������������Ŀ
 � End of Unit                                                      �
 ��������������������������������������������������������������������}
end.
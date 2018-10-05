program zeiger;{zeiger01.pas}
var
  Software : string;
  PSoftware,NSoftware : ^string;     {Zeiger auf einen String}
begin
  Software := 'Turbo Pascal 6.0';
  PSoftware := @(Software);
                                     {PSoftware wird auf die Adresse von 
                                      Software gerichtet}
  writeln(Software);                 {Gibt Turbo Pascal 6.0 aus}
  writeln (PSoftware^);              {Gibt Turbo Pascal 6.0 aus
                                      Ausgabe des Inhaltes der n„chsten 
                                      256 Adressen ab PSoftware}
  NSoftware := PSoftware;            {NSoftware wird auf die gleiche Adresse
                                      wie PSoftware gerichtet}
  NSoftware^ := 'Borland Pascal 7.0';{Eingabe eines neuen Dateninhalts ab 
                                      der Adresse von NSoftware}
  writeln (PSoftware^);              {Gibt Borland Pascal 7.0 aus
                                      Ausgabe des Inhaltes der n„chsten 
                                      256 Adressen ab PSoftware}
  readln;
end.

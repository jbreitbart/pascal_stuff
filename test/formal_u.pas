Unit <Bezeichner>;  {���������������������������������Kopf der Unit��}

{�������������������������������������Interface (�ffentlicher Teil)��}
Interface         
  uses ... ;                        { Liste der einzubindenden Units }
  const ... ;                 { Vereinbarung der globalen Konstanten }
  type ... ;                  { Vereinbarung der globalen Datentypen }
  var ... ;                    { Vereinbarung der globalen Variablen }

                         { Hier nur die Prozedur- und Funktionsk�pfe }
  procedure ... ;             { Vereinbarung der globalen Prozeduren }
  function ... ;              { Vereinbarung der globalen Funktionen }

{��������������������������Implementation (Nicht-�ffentlicher Teil)��}
Implementation
  uses ... ;              { Liste der einzubindenden (lokalen) Units }
  const ... ;                  { Vereinbarung der lokalen Konstanten }
  type ... ;                   { Vereinbarung der lokalen Datentypen }
  var ... ;                     { Vereinbarung der lokalen Variablen }
  procedure ... ;              { Vereinbarung der lokalen Prozeduren }
  function ... ;               { Vereinbarung der lokalen Funktionen }

                  { Quellcode der globalen Prozeduren und Funktionen }

{���������������������������������������������Initialisierungs-Teil��}
begin           
  Anweisung; 
  ...
  Anweisung;
end.

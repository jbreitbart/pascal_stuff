Unit <Bezeichner>;  {컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴횷opf der Unit컴}

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴횵nterface (셟fentlicher Teil)컴}
Interface         
  uses ... ;                        { Liste der einzubindenden Units }
  const ... ;                 { Vereinbarung der globalen Konstanten }
  type ... ;                  { Vereinbarung der globalen Datentypen }
  var ... ;                    { Vereinbarung der globalen Variablen }

                         { Hier nur die Prozedur- und Funktionsk봯fe }
  procedure ... ;             { Vereinbarung der globalen Prozeduren }
  function ... ;              { Vereinbarung der globalen Funktionen }

{컴컴컴컴컴컴컴컴컴컴컴컴컴Implementation (Nicht-봣fentlicher Teil)컴}
Implementation
  uses ... ;              { Liste der einzubindenden (lokalen) Units }
  const ... ;                  { Vereinbarung der lokalen Konstanten }
  type ... ;                   { Vereinbarung der lokalen Datentypen }
  var ... ;                     { Vereinbarung der lokalen Variablen }
  procedure ... ;              { Vereinbarung der lokalen Prozeduren }
  function ... ;               { Vereinbarung der lokalen Funktionen }

                  { Quellcode der globalen Prozeduren und Funktionen }

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴횵nitialisierungs-Teil컴}
begin           
  Anweisung; 
  ...
  Anweisung;
end.

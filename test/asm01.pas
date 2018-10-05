{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autorin: Gabi Rosenbaum 16.10.1992               º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º  Konvertieren eines Strings in Groábuchstaben                    º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program ASM01;                                     {Datei: Asm01.pas}
Uses
  Crt;                                  {Bibliothek aus Turbo Pascal}

Function KleinInGross(Str: String) : String;Assembler;
Asm
  Push DS          {Datensegment retten                                }
  CLD              {Direction-Flag l”schen, der String wird            }
                   {von vorne nach hinten gelesen                      }
  LDS SI,Str       {Den String ins Sourceindex DS:SI                   }
  LES DI,@Result   {Das Funktionsergebnis nach Destindex ES:DI         }
  LODSB            {Die Stringl„nge laden   str[0]                     }
  STOSB            {und abspeichern                                    }
                   {in Al steht jetzt die Stringl„nge                  }
  Xor Ah,Ah        {Ah mit 0 initialisieren                            }
  Xchg AX,CX       {Akku tauschen AX,CX                                }
                   {Jetzt steht die Stringl„nge in CX, das ist         }
                   {gleichzeitig die Laufvariable fr die Loop-Schleife}  
  JCXZ @3          {Wenn Stringl„nge = 0 dann zum ende gehen           }
@1:                {Loop-Schleife                                      }
  LODSB            {Ein Zeichen laden                                  }
  CMP AL,'a'       {Das Zeichen mit dem kleinen a vergleichen          }
  JB  @2           {Wenn kleiner, dann liegt schon ein Groábuchstabe   }
                   {vor, weil diese im ASC-Zeichensatz vor den Klein-  }
                   {buchstaben kommen, oder es liegt gar kein Buch-    }
                   {stabe vor                                          }
  CMP Al,'z'       {Das zeichen mit dem kleinen z vergleichen          }
  JA @2            {Wenn gr”áer, dann liegt ebenfalls kein Buchstabe   }
                   {vor                                                }
  SUB AL,20h       {Vom Zeichen 32 abziehen (hex 20), das ist der      }
                   {Unterschied von Groá- zu Kleinbuchstabem in ASC    }
@2:
  STOSB            {Das Zeichen abspeichern                            }
  Loop @1          {Schleife wiederhohlen (bis CX Null ist)            }
@3:
  POP DS           {Datensegment wieder restaurieren                   }
end;{Asm01.pas}

Var
  Ergebnis : String;
Begin
  ClrScr;
  Ergebnis := KleinInGross('Das grosse Buch zu Turbo-Pascal');
  Writeln(Ergebnis);
  ReadLn;
end.{Asm01.pas}
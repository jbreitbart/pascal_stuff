{$A-,B-,D+,E+,F-,G+,I+,L+,N-,O-,R+,S+,V+,X-}
{$M 16384,0,655360}

Program SchulerDaten;

uses crt,graph,alles,dos;

type TAdr = record
             Str,Ort : String[20];
             HN  : 1..999;
             plz : 10000..99999;
            end;

     TGeb = record
             Tag   : 1..31;
             Monat : 1..12;
             Jahr  : Word;
            end;

     TZen = record
             F1,F2,F3,F4 : array [1..4] of 1..6;
            end;

     Tschuler = record
                 Vor, Nach : String[20];
                 Geb       : TGeb;
                 Adr       : TAdr;
                 Zen       : TZen;
                end;

var Schuler : array [1..40] of TSchuler;
    letz    : 1..41;
    gesp  : Boolean;

procedure Anfang;

begin
 clrscr;
 writeln;
 writeln('1. Alle SchÅler anzeigen');
 writeln;
 writeln('2. Bestimmten SchÅler anzeigen');
 writeln;
 writeln('3. SchÅler eingeben');
 writeln;
 writeln('4. SchÅler Ñndern');
 writeln;
 writeln('5. SchÅler lîschen');
 writeln;
 writeln('6. Alle SchÅler lîschen');
 writeln;
 writeln('7. SchÅler Daten speichern');
 writeln;
 writeln('8. SchÅler Daten laden');
 gotoxy(1,24);
 writeln('Q. Beenden');
end;

procedure aschulo;
var lv1,lv2 : Laufvar;
begin
 gesp:=false;
 for lv1:=1 to 40 DO begin
  Schuler[lv1].Vor:='';
  Schuler[lv1].Nach:='';
  Schuler[lv1].Geb.tag:=1;
  Schuler[lv1].Geb.Monat:=1;
  Schuler[lv1].Geb.Jahr:=0;
  Schuler[lv1].adr.Str:='';
  Schuler[lv1].adr.HN:=1;
  Schuler[lv1].adr.Plz:=66666;
  Schuler[lv1].adr.Ort:='';
  for lv2:=1 to 4 DO begin
   Schuler[lv1].Zen.F1[lv2]:=1;
   Schuler[lv1].Zen.F2[lv2]:=1;
   Schuler[lv1].Zen.F3[lv2]:=1;
   Schuler[lv1].Zen.F4[lv2]:=1;
  end;
 end;
 letz:=1;
 anfang;
end;

procedure schuein;
begin
 clrscr;
 gesp:=false;
 write('Nachname [20]: ');
 readln(Schuler[letz].nach);
 write('Vorname [20]: ');
 readln(Schuler[letz].vor);
 writeln;
 writeln('Geburtstag');
 write('Tag : ');
 readln(Schuler[letz].Geb.tag);
 write('Monat : ');
 readln(Schuler[letz].Geb.monat);
 write('Jahr : ');
 readln(Schuler[letz].Geb.Jahr);
 writeln;
 writeln('Adresse');
 write('Stra·e [20]: ');
 readln(Schuler[letz].adr.str);
 write('Hausnummer [999]: ');
 readln(Schuler[letz].adr.HN);
 write('Ort [20]: ');
 readln(Schuler[letz].adr.Ort);
 write('Plz : ');
 readln(Schuler[letz].adr.PLZ);
 writeln;
 writeln('Zensuren');
 write('Fach 1 Note 1 : ');
 readln(Schuler[letz].zen.f1[1]);
 write('Fach 1 Note 2 : ');
 readln(Schuler[letz].zen.f1[2]);
 write('Fach 1 Note 3 : ');
 readln(Schuler[letz].zen.f1[3]);
 write('Fach 1 Note 4 : ');
 readln(Schuler[letz].zen.f1[4]);
 write('Fach 2 Note 1 : ');
 readln(Schuler[letz].zen.f2[1]);
 write('Fach 2 Note 2 : ');
 readln(Schuler[letz].zen.f2[2]);
 write('Fach 2 Note 3 : ');
 readln(Schuler[letz].zen.f2[3]);
 write('Fach 2 Note 4 : ');
 readln(Schuler[letz].zen.f2[4]);
 write('Fach 3 Note 1 : ');
 readln(Schuler[letz].zen.f3[1]);
 write('Fach 3 Note 2 : ');
 readln(Schuler[letz].zen.f3[2]);
 write('Fach 3 Note 3 : ');
 readln(Schuler[letz].zen.f3[3]);
 write('Fach 3 Note 4 : ');
 readln(Schuler[letz].zen.f3[4]);
 write('Fach 4 Note 1 : ');
 readln(Schuler[letz].zen.f4[1]);
 write('Fach 4 Note 2 : ');
 readln(Schuler[letz].zen.f4[2]);
 write('Fach 4 Note 3 : ');
 readln(Schuler[letz].zen.f4[3]);
 write('Fach 4 Note 4 : ');
 readln(Schuler[letz].zen.f4[4]);
 letz:=letz+1;
 anfang;
end;

procedure Aschuanz;

var lv1,lv2 : Laufvar;

begin
 clrscr;
 for lv1 :=1 to letz-1 DO begin
  writeln;
  writeln('Nachname : ',schuler[lv1].nach);
  writeln('Vorname : ',schuler[lv1].Vor);
  writeln('Geburtstag : ',schuler[lv1].geb.tag,'.',schuler[lv1].geb.monat,'.',schuler[lv1].geb.jahr);
  writeln('Stra·e : ',schuler[lv1].adr.str,' Nr.',schuler[lv1].adr.hn);
  writeln('Ort : ',schuler[lv1].adr.plz,' ',schuler[lv1].adr.ort);
  writeln;
  writeln('F1.1 F1.2 F1.3 F1.4 F2.1 F2.2 F2.3 F2.4 F3.1 F3.2 F3.3 F3.4 F4.1 F4.2 F4.3 F4.4');
  write(' ');
  for lv2:=1 to 4 DO begin
   write(schuler[lv1].zen.f1[lv2],'    ');
  end;
  for lv2:=1 to 4 DO begin
   write(schuler[lv1].zen.f2[lv2],'    ');
  end;
  for lv2:=1 to 4 DO begin
   write(schuler[lv1].zen.f3[lv2],'    ');
  end;
  for lv2:=1 to 4 DO begin
   write(schuler[lv1].zen.f4[lv2],'    ');
  end;
  writeln;
  if ((lv1/2)=(Round(lv1/2))) and (lv1<>letz-1) then begin
                                                      waitkey;
                                                      clrscr;
                                                     end;
 end;
 waitkey;
 anfang;
end;

procedure schuspei;

var f : file of Tschuler;
    s,v : string;
    c : Char;
    r : Word;
    DirInfo: SearchRec;

begin
 clrscr;
 write('Bitte Verzeichnissname eingeben [Laufwerk\Verz]: ');
 readln(v);
 writeln;
 {$I-}
 MkDir(v);
 if IOResult = 0 then begin
                       WriteLn('Verzeichniss erstellt!');
                       writeln;
                      end
 else begin
  dirinfo.name:='*.sda';
  FindFirst(v+'\*.sda', Archive, DirInfo);
  writeln ('Vorhandene Dateien: ');
  while DosError = 0 do begin
                         WriteLn(DirInfo.Name);
                         FindNext(DirInfo);
                        end;
 end;
 {$I+}
 writeln;
 write('Namen der Datei [Name] : ');
 readln(s);
 if FileExists(v+'\'+s+'.sda') then begin
                        write('Datei existiert bereits! Datei Åberschreiben (J/N) ');
                        c:=readkey;
                        c:=upcase(c);
                        if c='N' then begin
                         anfang;
                         clrscr;
                        end;
                       end;
 assign(f,v+'\'+s+'.sda');
 rewrite(f);
 for r := 1 to 40 DO write(f,SCHULER[r]);
 close(f);
 gesp:=true;
 anfang;
end;

procedure schula;

var f : File of Tschuler;
    s,v : string;
    c : char;
    r : Word;
    DirInfo: SearchRec;

begin
 clrscr;
 write('Namen des Verzeichnisses [Laufwerk\Verz] : ');
 readln(v);
 dirinfo.name:='*.sda';
 FindFirst(v+'\*.sda', Archive, DirInfo);
 writeln;
 writeln ('Mîgliche Dateien: ');
 while DosError = 0 do begin
                        WriteLn(DirInfo.Name);
                        FindNext(DirInfo);
                       end;
 writeln;
 write('Name der Datei [Name] : ');
 readln(s);
 if fileexists(v+'\'+s+'.sda') then begin
  if (letz<>1) and (gesp=false) then begin
   writeln;
   write('Achtung ihre eingegeben Datein gehen verloren! Trozdem laden ?(J/N)');
   c:=readkey;
   c:=upcase(c);
   if c='N' then begin
    anfang;
    exit;
   end;
  end;
  assign(f,v+'\'+s+'.sda');
  reset(f);
  for r := 1 to 40 DO read(f,SCHULER[r]);
  close(f);
  letz:=1;
  r:=1;
  repeat
   if (schuler[r].vor<>'') and (schuler[r].nach<>'') then letz:=letz+1
   else begin
    anfang;
    exit;
   end;
   r:=r+1;
  until (r=41);
 end
 else begin
  writeln;
  writeln('Datei existiert nicht!');
  waitkey;
 end;
 anfang;
end;

procedure Bschuanz;

var n : String[20];
    lv1,a,lv2 : Laufvar;

begin
 clrscr;
 write('Bitte den Nachnamen eingeben : ');
 readln(n);
 clrscr;
 a:=0;
 for lv1:=1 to letz DO begin
  if fgross(schuler[lv1].nach)=fgross(n) then begin
   writeln;
   a:=a+1;
   writeln('Nachname : ',schuler[lv1].nach);
   writeln('Vorname : ',schuler[lv1].Vor);
   writeln('Geburtstag : ',schuler[lv1].geb.tag,'.',schuler[lv1].geb.monat,'.',schuler[lv1].geb.jahr);
   writeln('Stra·e : ',schuler[lv1].adr.str,' Nr.',schuler[lv1].adr.hn);
   writeln('Ort : ',schuler[lv1].adr.plz,' ',schuler[lv1].adr.ort);
   writeln;
   writeln('F1.1 F1.2 F1.3 F1.4 F2.1 F2.2 F2.3 F2.4 F3.1 F3.2 F3.3 F3.4 F4.1 F4.2 F4.3 F4.4');
   write(' ');
   for lv2:=1 to 4 DO write(schuler[lv1].zen.f1[lv2],'    ');
   for lv2:=1 to 4 DO write(schuler[lv1].zen.f2[lv2],'    ');
   for lv2:=1 to 4 DO write(schuler[lv1].zen.f3[lv2],'    ');
   for lv2:=1 to 4 DO write(schuler[lv1].zen.f4[lv2],'    ');
   writeln;
   if ((lv1/2)=(Round(lv1/2))) and (lv1<>letz-1) then begin
                                                       waitkey;
                                                       clrscr;
                                                      end;

  end;
 end;
 if a=0 then write('Keine Person mit diesem Namen gefunden!');
 waitkey;
 anfang;
end;

procedure schuand;

var n,v : String[20];
    lv1,lv2,anz : Laufvar;
    num : Byte;
    c : char;

begin
 clrscr;
 gesp:=false;
 write('Nachname des SchÅlers : ');
 readln(n);
 anz:=0;
 num:=0;
 for lv1:=1 to letz DO begin
  if (fgross(schuler[lv1].nach)=fgross(n)) then begin
   anz:=anz+1;
   num:=lv1;
  end;
 end;
 if anz=0 then begin
  writeln;
  writeln('Keinen SchÅler gefunden!');
 end;
 if anz>1 then begin
  writeln('Mehrere SchÅler mit gleichen Namen gefunden!');
  writeln;
  write('Bitte Vornamen eingeben : ');
  readln(v);
  anz:=0;
  for lv1:=1 to 40 DO begin
   if (fgross(schuler[lv1].nach)=fgross(n)) and (fgross(schuler[lv1].vor)=fgross(v)) then begin
    anz:=anz+1;
    num:=lv1;
   end;
  end;
  if anz>1 then begin
   writeln;
   writeln('SchÅler existiert doppelt! Abgebrochen!');
   waitkey;
  end;
 end;
 if anz=1 then begin
  clrscr;
  writeln('Alte Werte');
  writeln;
  writeln('Nachname : ',schuler[num].nach);
  writeln('Vorname : ',schuler[num].Vor);
  writeln('Geburtstag : ',schuler[num].geb.tag,'.',schuler[num].geb.monat,'.',schuler[num].geb.jahr);
  writeln('Stra·e : ',schuler[num].adr.str,' Nr.',schuler[num].adr.hn);
  writeln('Ort : ',schuler[num].adr.plz,' ',schuler[num].adr.ort);
  writeln;
  writeln('F1.1 F1.2 F1.3 F1.4 F2.1 F2.2 F2.3 F2.4 F3.1 F3.2 F3.3 F3.4 F4.1 F4.2 F4.3 F4.4');
  write(' ');
  for lv2:=1 to 4 DO write(schuler[num].zen.f1[lv2],'    ');
  for lv2:=1 to 4 DO write(schuler[num].zen.f2[lv2],'    ');
  for lv2:=1 to 4 DO write(schuler[num].zen.f3[lv2],'    ');
  for lv2:=1 to 4 DO write(schuler[num].zen.f4[lv2],'    ');
  writeln;
  writeln('Welchen Wert wollen Sie Ñndern ?(N/V/G/S/O/1/2/3/4)');
  c:=readkey;
  c:=upcase(c);
  writeln;
  if c='N' then begin
   write('Neuer Nachname : ');
   readln(schuler[num].nach);
  end;
  if c='V' then begin
   write('Neuer Vorname : ');
   readln(schuler[num].Vor);
  end;
  if c='G' then begin
   writeln('Neuer Geburtstag : ');
   write('Tag : ');
   readln(schuler[num].geb.tag);
   write('Monat : ');
   readln(schuler[num].geb.monat);
   write('Jahr : ');
   readln(schuler[num].geb.jahr);
  end;
  if c='S' then begin
   write('Neue Strasse : ');
   readln(schuler[num].adr.str);
   write('Neue Hasunummer : ');
   readln(schuler[num].adr.Hn);
  end;
  if c='O' then begin
   write('Neuer Ort : ');
   readln(schuler[num].adr.ort);
   write('Neue Plz : ');
   readln(schuler[num].adr.plz);
  end;
  if c='1' then begin
   writeln('Neue Noten in Fach 1');
   write('Note 1 : ');
   readln(Schuler[letz].zen.f1[1]);
   write('Note 2 : ');
   readln(Schuler[letz].zen.f1[2]);
   write('Note 3 : ');
   readln(Schuler[letz].zen.f1[3]);
   write('Note 4 : ');
   readln(Schuler[letz].zen.f1[4]);
  end;
  if c='2' then begin
   writeln('Neue Noten in Fach 2');
   write('Note 1 : ');
   readln(Schuler[letz].zen.f2[1]);
   write('Note 2 : ');
   readln(Schuler[letz].zen.f2[2]);
   write('Note 3 : ');
   readln(Schuler[letz].zen.f2[3]);
   write('Note 4 : ');
   readln(Schuler[letz].zen.f2[4]);
  end;
  if c='3' then begin
   writeln('Neue Noten in Fach 3');
   write('Note 1 : ');
   readln(Schuler[letz].zen.f3[1]);
   write('Note 2 : ');
   readln(Schuler[letz].zen.f3[2]);
   write('Note 3 : ');
   readln(Schuler[letz].zen.f3[3]);
   write('Note 4 : ');
   readln(Schuler[letz].zen.f3[4]);
  end;
  if c='4' then begin
   writeln('Neue Noten in Fach 4');
   write('Note 1 : ');
   readln(Schuler[letz].zen.f4[1]);
   write('Note 2 : ');
   readln(Schuler[letz].zen.f4[2]);
   write('Note 3 : ');
   readln(Schuler[letz].zen.f4[3]);
   write('Note 4 : ');
   readln(Schuler[letz].zen.f4[4]);
  end;
 end;
 anfang;
end;

procedure schulo;
var n,v : String[20];
    lv1,lv2,anz : Laufvar;
    num : Byte;
    c : char;

begin
 clrscr;
 gesp:=false;
 write('Nachname des SchÅlers : ');
 readln(n);
 anz:=0;
 num:=0;
 for lv1:=1 to letz DO begin
  if (fgross(schuler[lv1].nach)=fgross(n)) then begin
   anz:=anz+1;
   num:=lv1;
  end;
 end;
 if anz=0 then begin
  writeln;
  writeln('Keinen SchÅler gefunden!');
 end;
 if anz>1 then begin
  writeln('Mehrere SchÅler mit gleichen Namen gefunden!');
  writeln;
  write('Bitte Vornamen eingeben : ');
  readln(v);
  anz:=0;
  for lv1:=1 to 40 DO begin
   if (fgross(schuler[lv1].nach)=fgross(n)) and (fgross(schuler[lv1].vor)=fgross(v)) then begin
    anz:=anz+1;
    num:=lv1;
   end;
  end;
 end;
 if anz>=1 then begin
  clrscr;
  writeln('Werte');
  writeln;
  writeln('Nachname : ',schuler[num].nach);
  writeln('Vorname : ',schuler[num].Vor);
  writeln('Geburtstag : ',schuler[num].geb.tag,'.',schuler[num].geb.monat,'.',schuler[num].geb.jahr);
  writeln('Stra·e : ',schuler[num].adr.str,' Nr.',schuler[num].adr.hn);
  writeln('Ort : ',schuler[num].adr.plz,' ',schuler[num].adr.ort);
  writeln;
  writeln('F1.1 F1.2 F1.3 F1.4 F2.1 F2.2 F2.3 F2.4 F3.1 F3.2 F3.3 F3.4 F4.1 F4.2 F4.3 F4.4');
  write(' ');
  for lv2:=1 to 4 DO write(schuler[num].zen.f1[lv2],'    ');
  for lv2:=1 to 4 DO write(schuler[num].zen.f2[lv2],'    ');
  for lv2:=1 to 4 DO write(schuler[num].zen.f3[lv2],'    ');
  for lv2:=1 to 4 DO write(schuler[num].zen.f4[lv2],'    ');
  writeln;
  write('SchÅler wirklich lîschen ?(J/N) ');
  c:=readkey;
  c:=upcase(c);
  if c='J' then begin
   letz:=letz-1;
   for lv1:=num to letz-1 DO begin
    if lv1<>40 then schuler[lv1]:=schuler[lv1+1]
    else begin
     Schuler[lv1].Vor:='';
     Schuler[lv1].Nach:='';
     Schuler[lv1].Geb.tag:=1;
     Schuler[lv1].Geb.Monat:=1;
     Schuler[lv1].Geb.Jahr:=0;
     Schuler[lv1].adr.Str:='';
     Schuler[lv1].adr.HN:=1;
     Schuler[lv1].adr.Plz:=66666;
     Schuler[lv1].adr.Ort:='';
     for lv2:=1 to 4 DO begin
      Schuler[lv1].Zen.F1[lv2]:=1;
      Schuler[lv1].Zen.F2[lv2]:=1;
      Schuler[lv1].Zen.F3[lv2]:=1;
      Schuler[lv1].Zen.F4[lv2]:=1;
     end;
    end;
   end;
  end;
 end;
 anfang;
end;

var Taste : Char;

begin
 aschulo;
 gesp:=false;
 repeat
  taste:=readkey;
  Taste:=upcase(taste);
  if Taste='1' then begin
                     if letz=1 then begin
                                     gotoxy(1,22);
                                     write('Keine Daten eingegeben');
                                    end
                     else Aschuanz;
                    end;
  if Taste='2' then begin
                     if letz=1 then begin
                                     gotoxy(1,22);
                                     write('Keine Daten eingegeben');
                                    end
                     else Bschuanz;
                    end;
  if Taste='3' then begin
                     if letz>40 then begin
                      gotoxy(1,22);
                      write('Bereits 40 SchÅler eingegeben');
                     end
                     else Schuein;
                    end;
  if Taste='4' then begin
                     if letz=1 then begin
                                     gotoxy(1,22);
                                     write('Keine Daten eingegeben');
                                    end
                     else Schuand;
                    end;
  if Taste='5' then begin
                     if letz=1 then begin
                                     gotoxy(1,22);
                                     write('Keine Daten eingegeben');
                                    end
                     else schulo;
                    end;
  if Taste='6' then begin
                     if letz=1 then begin
                                     gotoxy(1,22);
                                     write('Keine Daten eingegeben');
                                    end
                     else begin
                      gotoxy(1,22);
                      writeln('Sind Sie sicher ?(J/N)');
                      taste:=readkey;
                      taste:=upcase(Taste);
                      if taste='J' then aschulo;
                      if taste='N' then anfang;
                     end;
                    end;
  if Taste='7' then begin
                     if letz=1 then begin
                                     gotoxy(1,22);
                                     write('Keine Daten eingegeben');
                                    end
                     else schuspei;
                    end;
  if Taste='8' then schula;
 until Taste='Q';
 if (gesp=false) and (letz>1) then begin
  clrscr;
  writeln('Achtung Sie haben die Daten nicht gespeichert!');
   write('Wollen sie ihre Daten jetzt speichern, anzeigen oder verwerfen(S/A/V)? ');
  repeat
   taste:=readkey;
   taste:=upcase(taste);
   if taste='A' then begin
                      aschuanz;
                      clrscr;
                      writeln('Achtung Sie haben die Daten nicht gespeichert!');
                      write('Wollen sie ihre Daten jetz speichern, anzeigen oder verwerfen(S/A/V)? ');
                     end;
  until (taste='V') or (taste='S');
  if taste='S' then schuspei;
  clrscr;
 end;
end.

{ 40 SchÅler Adresse Name 4F a 4 Noten}
{ALo; Schuein; ASchuanz; Schuspei; AschuSpei}
{Verzeichnisse mkdir}
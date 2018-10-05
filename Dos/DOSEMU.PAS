{$A-,B-,D+,E+,F-,G+,I+,L+,N+,O-,R+,S+,V+,X-}
{$M 8192,0,0}
Program DosEmulation;

uses crt, dos;

var command, verz, programm : String;
    fehler: Integer;

procedure Datum ;

const days : array [0..6] of String[9] = ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
var y, m, d, dow : Word;
begin
  GetDate(y,m,d,dow);
  Write(days[dow],', ',m:0,'.', d:0,'.', y:0,' ');
end;

procedure uhr;

var h, m, s, hund : Word;

function LeadingZero(w : Word) : String;

var s : String;
begin
  Str(w:0,s);
  if Length(s) = 1 then s := '0' + s;
  LeadingZero := s;
end;

begin
  GetTime(h,m,s,hund);
  Write(' ',LeadingZero(h),':',LeadingZero(m),':',LeadingZero(s),'.',LeadingZero(hund));
end;

procedure gross (var s:String);
var i : Integer;

begin
 for i := 1 to Length(s) do s[i] := UpCase(s[i]);
end;

procedure dir;
var Command: string[79];

begin
  command:='dir';
  if Command <> '' then Command := '/C ' + Command;
  SwapVectors;
  Exec(GetEnv('COMSPEC'), Command);
  SwapVectors;
end;

procedure Festplaate_chikkenbutt;
var gesammt, frei : LONGInt;

begin
 gesammt := disksize(0);
 frei := diskfree(0);
 writeln;
 write ('Es sind von ');
 write (gesammt);
 write (' Bytes ');
 write (frei);
 writeln (' Bytes frei.');
 Write('Es sind von ',gesammt div 1024,' kb ');
 WriteLn(frei div 1024,' kb frei');
end;

begin
 ClrScr;
 write ('TOS, ');
 datum;
 uhr;
 write(' ');
 getdir(0,verz);
 verz := verz+'>';
 write(verz);
 readln(command);
 gross (command);
 if command = 'DIR' then dir;
 if command = 'FREI' then Festplaate_chikkenbutt;
 programm := verz + command;
 exec (programm,command);
 fehler := doserror;
 readln;
end.
diskfree disksize
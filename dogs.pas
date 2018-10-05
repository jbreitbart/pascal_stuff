Unit Dogs;

interface

uses CRT;

procedure dick;
procedure klein;
procedure neutral;
procedure warten;
procedure wrong;
procedure mob;
procedure wuh;
procedure anders;
procedure ahh;

implementation
 Procedure dick;
  Begin
  Textcolor (15);
  END;
 Procedure klein;
  Begin
  Textcolor (6);
  END;
 Procedure neutral;
  Begin
  Textcolor (3);
  End;
 procedure warten;
  Begin
  delay (2000);
  End;
 procedure wrong;
  Begin
  Textcolor (4);
  End;
 procedure mob;
  Begin
  sound (50);
  delay (5000);
  nosound;
  End;
 procedure wuh;
  Begin
   sound (30);
   delay (2700);
   nosound;
  END;
 procedure anders;
  Begin
   textcolor (blue);
  end;
 procedure ahh;
  Begin
   sound (900);
   delay (7000);
   nosound;
  END;
END.
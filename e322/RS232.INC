function com_adr(cport:integer):integer;
var pt : ^word;
begin
  if not cport in [1..4]
    then error('Com: Illegal port number');
  pt := ptr($00,$3fe+(cport shl 1));
  if pt^ = 0 then error('Com: Port not used');
  com_adr := pt^;
  {
  case cport of
    1 : com_adr:=$3f8;
    2 : com_adr:=$2f8;
    3 : com_adr:=$3e8;
    4 : com_adr:=$2e8;
    else error('Com: Illegal port number');
  end;
  }
end;

function com_data(cport:integer):boolean;
var p:integer;
begin
  p := com_adr(cport);
  com_data := (port[p+5] and 1)=1;
end;

function com_read(cport:integer):char;
var p:integer;
begin
  p := com_adr(cport);
  port[p+3] := port[p+3] and $7f;
  if (port[p+5] and 1)=1
    then com_read:=chr(port[p])
    else error('Com: FIFO underrun');
end;

procedure com_write(cport:integer;c:char);
var p:integer;
begin
  p := com_adr(cport);
  port[p+3] := port[p+3] and $7f;
  while (port[p+5] and 32)=0 do;
  port[p] := ord(c);
end;

procedure com_baud(cport:integer;b:longint);
var p:integer;
begin
  p := com_adr(cport);
  port[p+3] := port[p+3] or $80;
  b := 115200 div b;
  if (b=0) or (b>3000)
    then error('Com: illegal baud rate');
  port[p] := b and $ff;
  port[p+1] := b div $100;
  port[p+3] := port[p+3] and $7f;
end;

procedure com_bits(cport:integer;db,sb:byte);
var p:integer;
begin
  p := com_adr(cport);
  if not db in [5..8]
    then error('Com: illegal number of data bits');
  if not sb in [1,2]
    then error('Com: illegal number of stop bits');
  port[p+3] := (port[p+3] and $f8) or (db-5) or ((sb - 1)*4);
end;

procedure com_parity(cport:integer;pb:char);
var p:integer;
    v:byte;
begin
  p := com_adr(cport);
  pb := upcase(pb);
  case pb of
    'N' : v:=0;
    'O' : v:=$08;
    'E' : v:=$18;
    'H' : v:=$28;
    'L' : v:=$38;
    else error('Com: illegal parity');
  end;
  port[p+3] := (port[p+3] and $c7) or v;
end;

procedure com_rts(cport:integer;v:boolean);
var p:integer;
begin
  p := com_adr(cport);
  if v
    then port[p+4]:=port[p+4] or 2
    else port[p+4]:=port[p+4] and 253;
end;

procedure com_dtr(cport:integer;v:boolean);
var p:integer;
begin
  p := com_adr(cport);
  if v
    then port[p+4]:=port[p+4] or 1
    else port[p+4]:=port[p+4] and 254;
end;

function com_cts(cport:integer):boolean;
var p:integer;
begin
  p := com_adr(cport);
  com_cts := (port[p+6] and 16)=16;
end;

function com_dsr(cport:integer):boolean;
var p:integer;
begin
  p := com_adr(cport);
  com_dsr := (port[p+6] and 32)=32;
end;

function com_cd(cport:integer):boolean;
var p:integer;
begin
  p := com_adr(cport);
  com_cd := (port[p+6] and 128)=128;
end;

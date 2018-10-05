{
 Programm: Unit SBlast
 Funktion: Bereitstellung und Demonstra-
           tion grundlegender SBFunktionen
 Sprache:  Turbo Pascal ab 6.0
 Autor:    Boris Bertelsons
 (c) 1993 DMV Widuch GmbH & Co. KG
}
UNIT SBlaster;

interface
Uses Crt,dos;

Const dsp_adr       : word = $220;
      dsp_irq       : byte = $5;
      SbRegDetected : BOOLEAN = FALSE;

var SbVersMaj : byte;
    SbVersMin : byte;
    SbVersStr : string[5];

procedure init_sb;
procedure wr_dsp(v : byte);
function  SbReadByte : byte;
procedure SB_Befehl10h(v : byte);
procedure Set_Timeconst(tc : byte);
procedure Sende_Stilleblock(slaenge : word);
procedure Lautsprecher_Ein;
procedure Lautsprecher_Aus;
procedure Stopp_DMA;
procedure Continue_DMA;
function  Lautsprecher_Aktiv : boolean;
procedure GetDSPVersion;

implementation

function wrt_dsp_adr : string;
{
 Liefert die Base-Adresse des SB als
 String zurÅck
}
begin;
  case dsp_adr of
    $210 : wrt_dsp_adr := '210';
    $220 : wrt_dsp_adr := '220';
    $230 : wrt_dsp_adr := '230';
    $240 : wrt_dsp_adr := '240';
    $250 : wrt_dsp_adr := '250';
    $260 : wrt_dsp_adr := '260';
    $270 : wrt_dsp_adr := '270';
    $280 : wrt_dsp_adr := '280';
   END;
end;

function Reset_sb : boolean;
{
 Die Function resetet den DSP. War das
 Resetten erfolgreich, wird TRUE zu-
 rÅckgeliefert, ansonsten FALSE
}
const ready = $AA;
var   ct, stat : BYTE;
BEGIN
  port[dsp_adr+$6] := 1;
	{ dsp_adr+$6 = Resettfunktion}
  for ct := 1 to 100 do;
  port[dsp_adr+$6] := 0;
  stat := 0;
  ct   := 0;
  while (stat <> ready)
  and   (ct < 100)      do begin
  { Der Vergleich ct < 100, da die Ini-
	  tialisierung ca.100ms dauert }
    stat := PORT[dsp_adr+$E];
    stat := PORT[dsp_adr+$a];
    inc(ct);
  end;
  Reset_sb := (stat = ready);
END;

function Detect_Reg_sb : boolean;
{
 Die Funktion liefert TRUE zurÅck, wenn
 ein Soundblaster initialisiert werden
 konnte, ansonsten FALSE. Die Variable
 dsp_adr wird auf die Base-Adresse des
 SB gesetzt.
}
VAR Port, Lst : word;
BEGIN
 Detect_Reg_sb := SbRegDetected;
 IF SbRegDetected THEN EXIT;
 { Exit, wenn initialisiert   }
 Port := $210;
 Lst  := $280;
 { Mîgliche SB-Adressen zwischen $210
   und $280 ! }

 while (not SbRegDetected)
 and   (Port <= Lst)  do begin
   dsp_adr := Port;
   SbRegDetected := Reset_sb;
   if not SbRegDetected then
     inc(Port, $10);
 end;
 Detect_Reg_sb := SbRegDetected;
END;

procedure init_sb;
{
 Die Procedure prÅft, ob ein Soundblaster
 vorhanden ist, und initialisiert diesen
 mit der richtigen BASE - Adresse
}
BEGIN;
 clrscr;
 if Detect_Reg_Sb then begin;
   writeln('Soundblaster an Base ',
	  wrt_dsp_adr,'h gefunden !');
   writeln('Karte erfolgreich ',
	  'initialisiert');
 end else begin;
   writeln('Keinen Soundblaster oder',
	  ' kompatibele Karte gefunden');
   writeln('PrÅfen Sie ihre Karte !');
 end;
END;

procedure wr_dsp(v : byte);
{
 Wartet, bis der DSP zum Schreiben bereit
 ist, und schreibt dann das in "v" Åber-
 gebene Byte in den DSP
}
begin;
  while port[dsp_adr+$c] >= 128 do ;
  port[dsp_adr+$c] := v;
end;

function SbReadByte : byte;
{
 Die Function wartet, bis der DSP gelesen
 werden kann und liefert den gelesenen
 Wert zurÅck
}
begin;
  while port[dsp_adr+$a] = $AA do ;
	{ warten, bis DSP ready      }
  SbReadByte := port[dsp_adr+$a];
	{ Wert schreiben             }
end;


procedure SB_Befehl10h(v : byte);
{
 Direkte Ausgabe von 8-Bit Daten am SB
}
begin;
 	wr_dsp($10);
  wr_dsp(v);
end;

procedure Set_Timeconst(tc : byte);
{
 Timeconstant setzten, die nach der
 Formel tc = 256-(1000000/Real_Frequenz)
 berechnet wird.
}
begin;
 	wr_dsp($40);
  wr_dsp(tc);
end;

procedure Meine_Routine; interrupt;
begin;
end;

procedure Sende_Stilleblock(slaenge
: word);
{
 Sendet einen Stilleblock, fÅr Ruheblocks
 im VOC-Format verwenden
}
Const Frequenz : word = 22000;
begin;
	setintvec(dsp_irq,@Meine_Routine);
	Set_Timeconst(256-(1000000 div Frequenz));
	wr_dsp($80);
	wr_dsp(Lo(slaenge-1));
	wr_dsp(Hi(slaenge-1));
end;

procedure Lautsprecher_Ein;
{
 Schaltet den Lautsprecher ein
}
begin;
	wr_dsp($D1);
end;

procedure Lautsprecher_Aus;
{
 Schaltet den Lautsprecher aus
}
begin;
	wr_dsp($D3);
end;

procedure Stopp_DMA;
{
 Unterbricht die DMA-Ausgabe
}
begin;
	wr_dsp($D0);
end;

procedure Continue_DMA;
{
 Setzt die mit Stopp_DMA angehaltene
 Ausgabe fort
}
begin;
	wr_dsp($D4);
end;

function Lautsprecher_Aktiv : boolean;
{
 Liefert TRUE, wenn der Lautsprecher
 eingeschaltet ist, sonst FALSE
 Erst ab SB Pro !
}
begin;
	wr_dsp($D8);
	if SbReadByte = 0 then
		Lautsprecher_Aktiv := false
	else
		Lautsprecher_Aktiv := true;
end;

procedure GetDSPVersion;
{
 Ermittelt die Version des DSP und gibt
 diese aus
}
var i : word;
    t : WORD;
    s : STRING[2];
begin
	wr_dsp($E1);
	SbVersMaj := SbReadByte;
	sbVersMin := SbReadByte;
	str(SbVersMaj, SbVersStr);
	SbVersStr := SbVersStr + '.';
	str(SbVersMin, s);
	if SbVersMin > 9 then
		SbVersStr := SbVersStr +       s
	else
		SbVersStr := SbVersStr + '0' + s;
	writeln('Sie haben die Soundblaster-',
	'Version ',SbVersStr);
end;

begin;
end.
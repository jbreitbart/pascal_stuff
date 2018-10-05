{Programm: modplay.pas
 Funktion: MOD-Dateien im Hintergrund
           abspielen
 Sprache : Turbo Pascal ab 6.0
 Autor   : Boris Bertelsons
 (c) 1993 DMV Daten- u. Medienverlag}

{$A+,B-,D+,E+,F-,G+,I-,L+,N-,O-,R-,S-,V-,X+}
{$M 16384,0,655360}

unit modplay;

interface uses crt,dos;

{$define Typ1}

TYPE
  pt = record
    ofs,sgm  :  word;
  end;
 { ermîglicht die einfache Behandlung von
   Pointern}

  Effect_Type = record
     p : pointer;
     l : longint;
   end;
 { Typ fÅr Soundeffekte }

  Param_Table = record
    mult  : word;
    Speed : word;
    bgr   : word;
    Ab    : integer;
   end;
 { FÅr Speed-énderungen }


CONST
  frames = 37;
  waitret_flag        : byte = 0;
  PC    = 0;
  AMIGA = 1;
  Choose_lower_freq : boolean = false;
  { Wird auf True gesetzt, wenn der PC
    fÅr die engestellte Smplingrate zu
    langsam arbeitet ! }
  timer_per_second  : word = 1000;
  { Anzahl Interrupts per Sec. }
  Sampling_Frequenz : word = 10000;
  { Die Samplingfreq.; Default }
  in_retrace        : boolean = false;
  { Gerade in Retracing-Proc ? }
  dsp_irq           : byte = $5;
  { Interrupt des SB, Wert wird durch
    die Init-Routine  geÑndert }
  dma_ch            : byte = 1;
  { DMA Chanel, standartmÑ·ig = 1, auf
    SB 16 ASP auch an dere Werte mîglich }
  dsp_adr           : word = $220;
  { Die Base-Adress des DSP. Wert wird
    durch die Init Routine geÑndert }
  SbVersMin         : BYTE = 0;
  { Die Versions - Kennung }
  SbVersMaj         : BYTE = 0;
  STEREO            : BOOLEAN = FALSE;
  { In Stereo abspielen }
  SbRegDetected     : BOOLEAN = FALSE;
  { normale SB vorhanden ? }
  IRQDetected       : BOOLEAN = FALSE;
  SbRegInited       : BOOLEAN = FALSE;
  SbProDetected     : BOOLEAN = FALSE;
  { SB Pro vorhanden ? }
  SbProInited       : BOOLEAN = FALSE;
  Sb16Detected      : BOOLEAN = FALSE;
  { SB 16 ASP vorhanden ? }
  Sb16Inited        : BOOLEAN = FALSE;
  MixerDetected     : BOOLEAN = FALSE;
  { Wenn ja, Karte >= SB Pro }
  OldTimerInt                 = $71;
  { Orginal Int-Routine des verbogenen
    Timer - Int. }
  Stimmen           : integer = 4;
  { Anzahl der Stimmen im MOD-File }
  Modoktave : array[1..60] of word =
   (
    1712,1616,1525,1440,1359,1283,1211,
    1143,1078,961,907,856,808,763,720,
    679,641,605,571,539,509,480,453,428,
    404,381,360,340,321,303,286,270,254,
    240,227,214,202,191,180,170,160,151,
    143,135, 127,120,113,107,101,95,90,
    85,80,76,71,67,64,60,57,0);
  { Die Werte in Modoktave entsprechen den
    im MOD-File als Tonhîhen gespeicherten
    Werten }
  Vkt : array[1..84] of word =
     (
      0,0,0,0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,0,0,0,
      0,0,1,1,1,1,1,1,1,1,1,
      1,1,1,2,2,2,2,2,2,2,3,
      3,3,3,3,4,4,4,4,5,5,5,
      6,6,6,7,7,8,8,8,9,10,10,
      11,11,12,13,14,15,16
     );
  { Die Vorkomma - Stellen der Frequenz-
    abhÑngigen SprÅnge }
 Nkt : array[1..84] of byte =
     (
      12,13,14,15,16,17,18,19,21,22,24,
      25,26,28,30,31,33,35,37,40,42,45,
      47,50,53,56,59,63,67,71,75,79,84,
      89,94,00,06,12,19,26,33,41,50,59,
      68,78,89,00,12,24,38,52,67,83,00,
      17,36,56,78,00,24,49,76,04,34,66,
      00,35,73,13,55,00,48,98,51,08,68,
      31,99,70,45,25,10,00
     );
  { Die Nachkomma - Stellen der Frequenz-
    abhÑngigen SprÅnge }
 Ndiff : array[1..84] of byte =
     (
      1,1,1,1,1,1,1,2,1,2,1,
      1,2,2,1,2,2,2,3,2,3,2,
      3,3,3,3,4,4,4,4,4,5,5,
      5,6,6,6,7,7,7,8,9,9,9,
      10,11,11,12,12,14,14,15,16,17,17,
      19,20,22,22,24,25,27,28,30,32,34,
      35,38,40,42,45,48,50,53,57,60,63,
      68,71,75,80,85,90,0
     );
  { Differenzen zwischen den Nachkomma-
    Stellen }
 PermUp_1           : byte = 0;
 PermUp_2           : byte = 0;
 PermUp_3           : byte = 0;
 PermUp_4           : byte = 0;
 PermUp_5           : byte = 0;
 PermUp_6           : byte = 0;
 PermUp_7           : byte = 0;
 PermUp_8           : byte = 0;
 { Portamento Up der Stimme ? }
 PermDo_1           : byte = 0;
 PermDo_2           : byte = 0;
 PermDo_3           : byte = 0;
 PermDo_4           : byte = 0;
 PermDo_5           : byte = 0;
 PermDo_6           : byte = 0;
 PermDo_7           : byte = 0;
 PermDo_8           : byte = 0;
 { Portamento Down der Stimme ? }
 PermNk1            : word = 0;
 PermNk2            : word = 0;
 PermNk3            : word = 0;
 PermNk4            : word = 0;
 PermNk5            : word = 0;
 PermNk6            : word = 0;
 PermNk7            : word = 0;
 PermNk8            : word = 0;
 AUTO = 9999;
 { Kennung fÅr Auto detection }
 ON   = true;
 OFF  = false;
 playeffect         : boolean = false;
 effectvolume       : byte = 64;
 converteff         : byte = 0;
 Aktspeed           : byte = 6;

VAR
 efi                 : file;
 ModPara             : array[1..31] of
                       Param_Table;
 blockgroesse        : word;
 { Grî·e des Sound-Puffers }
 dsp_rdy_sb16        : boolean;
 { Flag fÅr Ende der öbertragung der
   Daten via DMA }
 SbVersStr           : string[5];
 { Die SB-Version als String  }
 Speed               : word;
 { Abspielgeschwindigkeit     }
 oldInt              : pointer;
 { Zur Sicherung des vom SB zum DMA-
   Transfer benîtigten Interrupts }
 irqmsk              : byte;
 { zur Interruptbehandlung    }
 Vermische_proc      : pointer;
 nmw_proc            : pointer;
 innen_proc          : pointer;
 { Zeiger auf Routinen, die je nach
   Anzahl der vorhandenen Stimmen
   ausgefÅhrt werden }
 Noten_Anschlag      : array[1..8]
                       of integer;
 { Zeit seid letztem Anschlag }
 Rm_Song             : Array[1..64,1..8,
                          1..4] of Byte;
 { Ein Pattern }
 rm                  : array[0..128]
                       of pointer;
 { Die einzelnen Pattern }
 Lied                : array[1..128]
                       of byte;
 { Arrangement des Liedes }
 blk                 : pointer;
 { Pointer auf Daten - Puffer }
 inst1,inst2         : pointer;
 inst3,inst4         : pointer;
 inst5,inst6         : pointer;
 inst7,inst8         : pointer;
 { Pointer auf die in der jeweiligen
   Stimme aktiven Sampels }
 Sampeldata          : Array[1..31]
                       of pointer;
 Samp                : Array[1..31]
                        of pointer;
 { Feld mit Zeigern auf Sampels }
 Sam_l               : Array[1..31]
                       of word;
 Sam_vol             : array[1..31]
                       of byte;
 { Die LÑnge der Sampels }
 loop_s              : array[0..31]
                       of word;
 { Loop-Start der Sampels }
 loop_l              : array[0..31]
                       of word;
 { Loop-LÑnge der Sampels }
 i1,i2,i3,i4,
 i5,i6,i7,i8         : pt; { Pointer auf
  aktive Sampels in "pt"-Form }
 in1l,in2l,in3l,
 in4l,in5l,in6l,
 in7l,in8l           : word;
 { LÑnge der Sampledaten der einzelnen
   Stimmen }
 in1p,in2p,in3p,
 in4p,in5p,in6p,
 in7p,in8p           : word;
 { Position in den jeweiligen
   Sampledaten }
 i                   : word;
 mlj                 : word;
 { SchleifenzÑhler, Aktuelles Pattern }
 mli                 : word;
 { SchleifenzÑhler, Aktuelle Zeile im
   Pattern }
 Vk1,Vk2,Vk3,
 Vk4,Vkh,Vk5,
 Vk6,Vk7,Vk8         : word;
 { Vorkommawert des Faktors, um den die
   Pos. in den Sampledaten erhîht werden
   mu· }
 Nk1,Nk2,Nk3,
 Nk4,Nkh,Nk5,
 Nk6,Nk7,Nk8         : byte;
 { Vorkommawert des Faktors, um den die
   Pos. in den Sampledaten erhîht werden
   mu· }
 Dif1,Dif2,Dif3,
 Dif4,Dif5,Dif6,
 Dif7,Dif8           : byte;
 Difb1,Difb2,Difb3,
 Difb4,Difb5,Difb6,
 Difb7,Difb8         : byte;
 Inst1vk             : word;
 Inst2vk             : word;
 Inst3vk             : word;
 Inst4vk             : word;
 Inst5vk             : word;
 Inst6vk             : word;
 Inst7vk             : word;
 Inst8vk             : word;
 { Zeigt auf aktuelles Samplebyte in den
   Daten }
 Inst1nk             : byte;
 Inst2nk             : byte;
 Inst3nk             : byte;
 Inst4nk             : byte;
 Inst5nk             : byte;
 Inst6nk             : byte;
 Inst7nk             : byte;
 Inst8nk             : byte;
 { Nachkommateil des Samplebytes }
 In_St1,In_St2,
 In_St3,In_St4,
 In_St5,In_St6,
 In_St7,In_St8       : byte;
 { Aktives Instrument der Stimme }
 sam_anz             : byte;
 { Anzahl der Sampel          }
 pat_anz             : byte;
 { Anzahl der Pattern         }
 m_played            : boolean;
 { Musik gespielt worden ???  }
 Sound_Schleifen     : word;
 { Anzahl der DurchlÑufe der Misch-Proc }
 Sampling_Rate       : byte;
 { dem DSP Åbergebene Frequenz-Wert }
 mod_name            : string;
 { DOS-Name der Mod-Datei     }
 tpw                 : integer;
 { Transposer - Wert          }
 loop_pos            : word;
 { Laufvar., von 0 bis Speed  }
 phase_1,phase_2     : boolean;
 { Die zwei Phasen der Interrupt-
   Mischprozedur         }
 modmultiply         : word;
 { Speed-Angabe im Song * Modmultiply
   = Speed }
 mloop               : boolean;
 { Wenn TRUE beginnt das MOD nach dem
   Abspielen von vorn }
 periodisch_anhalten : pointer;
 { Pointer auf Stop_Prozedur fÅr Ausgabe }
 music_aus           : boolean;
 { Wenn TRUE wird keine Musik gespielt }
 Notvol1,Notvol2,
 Notvol3,Notvol4,
 Notvol5,Notvol6,
 Notvol7,Notvol8     : byte;
 { LautstÑrke der einzelnen KanÑle }
 Pnk1,Pnk2,Pnk3,
 Pnk4,Pnk5,Pnk6,
 Pnk7,Pnk8           : byte;
 { Nachkomma des Portamento }
 Old_TZaehler        : word;
 { Zur Syncronisation des alten
   Timerinterrupts }
 Dma_Zaehler         : integer;
 { Zum abfangen des DMA_Ready
   Interrupts }
 dma_abbruch         : integer;
 { Abbruchwert fÅr Dma_Zaehler}
 mod_terminated      : boolean;
 { Mod-Ausgabe beendet        }
 ls1,ls2,ls3,ls4,
 ls5,ls6,ls7,ls8     : word;
 { Start der Loop im Sampel   }
 ll1,ll2,ll3,ll4,
 ll5,ll6,ll7,ll8     : word;
 { LÑnge der Loop im Sampel }
 Songname            : string[20];
 { Der Name des Modfiles }
 Instnamen           : array[1..31]
                       of string[22];
 { Namen der Instrumente }
 Liedlaenge          : byte;
 { LÑnge des Liedes }
 Seczaehler          : word;
 { zur Zeitermittlung }
 Timerzaehler        : word;
 { fÅr alten Timer-Interrupt }
 Laufsec,Laufmin     : byte;
 { Laufzeit des Liedes }
 Pattgroesse         : integer;
 { Die dem Modtyp entspr. Patterngrî·e }
 note1,note2,
 note3,note4,
 note5,note6,
 note7,note8 :byte;
 { Aktives Instument der Stimme }
 effektgroesse       : word;
 effektposi          : word;
 Effvk               : word;
 Effnk               : byte;
 Effistvk            : word;
 Effistnk            : byte;
 Effekt              : pt;
 { Zur Effekt-Behandlung }
 mycli : byte;
 { Flag, ob Soundberechnung aktiv }


 procedure vermische_start_8;
 procedure nmw_all_8;
 procedure innen_schleife_8n;
 procedure vermische_start_4;
 procedure nmw_all_4;
 procedure innen_schleife_4;
 procedure Set_Timeconst_sb16(tc : byte);
 procedure initialisiere_vermischen;


 procedure init_sb;
 {
  Die Procedure init_sb initialisiert die
  Soundblaster-Karte. Sie erkennt auto-
  matisch Base-Adress und IRQ, prÅft, um
  welche Soundblasterversion es sich
  handelt und setzt entsprechende globale
  Variablen, die z.B. mittels write_sb-
  Config ausgegeben werden kînnen
 }

 procedure dsp_block_sb16;
 {
  Spielt den Åber blk adressierten
  Block via DMA ab
 }

 procedure mod_waitretrace;
 {
  Das Warten auf einen Bildschirm-Retrace
  sollte mit dieser Procedure erfolgen,
  wenn MOD's abgespielt werden
 }

 procedure mod_SetSpeed(msp : word);
 {
  Setzt die Variable "Speed"
 }

 procedure mod_SetMultiply(msm : word);
 {
  Setzt den Multiply-Faktor.
 }

 procedure mod_SetLoop(msl : word);
 {
  Setzt die Variable "Sound_Schleifen"
 }

 procedure mod_SetLoopflag(loopen
 : boolean);
 {
  Setzt ON/OFF, ob eine zu Ende abge-
  spielte Moddatei wieder von Anfang
  an abgespielt wird
 }

 procedure mod_transpose(transposerwert
 : integer);
 {
  Setzt den Transposer-Wert.
 }

 procedure mod_Samplefreq(Rate : integer);
 {
  Setzt die Samplefrequenz fÅr die Aus-
  gabe. Wert*1000 = Frequenz.ZulÑssige
  Werte sind 8,10,16,22
 }

 function lade_moddatei(modname : string;
 ispeed,iloop : integer) : integer;
 {
  LÑd die unter modname angegebene Mod-
  datei. Mittels ispeed und iloop kînnen
  die Variablen "Speed" und "Sound_
  Schleifen" vorgegeben werden, sinnvoller
  ist jedoch die Angabe AUTO !
 }

 procedure ende_mod;
 {
  Beendet das Abspielen einer Mod-Datei
  und entfernt sie aus dem Speicher
 }

 procedure periodisch_on;
 {
  Schaltet das Abspielen einer MOD-Datei
  ein. Mu· zum Starten aufgerufen werden
 }

 procedure periodisch_off;
 {
  HÑlt das Abspielen einer MOD-Datei an.
  Die MOD-Datei bleibt im Speicher und
  kann Åber periodisch_on wieder gestartet
  werden
 }

 procedure write_sbConfig;
 {
  Gibt die gefundene Konfiguration aus
  (Textmodus !). Alternativ: Direkter
  Zugriff auf die entsprechenden Variablen
 }

 function Lade_Soundeffekt(s : string;
 var ef : effect_type) : integer;
 {
  LÑd den in s Åbergebenen Soundeffekt
  von Disk in den Speicher
 }

 procedure Starte_Soundeffekt(ef
 :effect_type;frequenz,Vol,styp : word);
 {
  Startet den geladenen Soundeffekt.
  Frequenz = Sampelfreq. (z.B. 13000)
  Vol darf zwischen 0 und 64 liegen
  styp = PC oder AMIGA fÅr signed und
  unsigned Sample Data
 }

 procedure dispose_Soundeffekt(ef
 : effect_type);
 {
  Gibt den belegten Speicher wieder frei
 }

procedure wr_dsp_sb16(v : byte);

 procedure calculate_music;
 {
  Intern! Berechnet die Musik, wird vom
  Timer-Int. aufgerufen
 }

implementation

const
 Speed3 : word = 58;
 { Zum modifizieren von Speed }
 Loop3  : word = 42;

Var
 SaveExitProc : Pointer;
 { Nîtig, da eigene Exitproc  }
 music_played : boolean;
 { Flag, TRUE wenn Musik gespielt wurde }
 tonhoehe : word;
 { Der Wert der Tonhîhe, wie er in der
   MOD-Datei steht }
 ziel : pt;
 { Abspielpuffer im pt-Format }
 Modp  : pointer;
 { Pointer auf Rm_Song }
 altx,alty : integer;
 lax,lbx,lcx,ldx,
 lsi,ldi,les,lds : word;
 yax,ybx,ycx,ydx,
 ysi,ydi,yes,yds : word;
 gax,gbx,gcx,gdx,
 gsi,gdi,ges,gds     : word;
 { Hilfsvariablen zur Sicherung der
   Register }

procedure wr_dsp_sb16(v : byte);
{
 Wartet, bis der DSP zum Schreiben bereit
 ist, und schreibt dann das in "v" Åber-
 gebene Byte in den DSP
}
begin;
  while port[dsp_adr+$c] >= 128 do ;
  port[dsp_adr+$c] := v;
end;

FUNCTION SbReadByte : BYTE;
{
 Die Function wartet, bis der DSP gelesen
 werden kann und liefert den gelesenen
 Wert zurÅck
}
begin;
  while port[dsp_adr+$a] = $AA do ;
  { warten, bis DSP ready }
  SbReadByte := port[dsp_adr+$a];
  { Wert schreiben }
end;


FUNCTION Reset_sb16 : BOOLEAN;
{
 Die Function resetet den DSP. War das
 Resetten erfolgreich, wird TRUE zurÅck-
 geliefert, ansonsten FALSE
}
CONST  ready = $AA;
VAR ct, stat : BYTE;
BEGIN
  PORT[dsp_adr+$6] := 1;
  { dsp_adr+$6 = Resettfunktion}
  FOR ct := 1 TO 100 DO;
  PORT[dsp_adr+$6] := 0;
  stat := 0;
  ct   := 0;
  WHILE (stat <> ready)
  AND   (ct < 100)      DO BEGIN
    stat := PORT[dsp_adr+$E];
    stat := PORT[dsp_adr+$a];
    INC(ct);
  END;
  { Der Vergleich ct < 100, da die
    Initialisierung ca.100ms dauert }
  Reset_sb16 := (stat = ready);
END;

FUNCTION Detect_Reg_sb16 : BOOLEAN;
{
 Die Funktion liefert TRUE zurÅck, wenn
 ein Soundblaster initialisiert werden
 konnte, ansonsten FALSE. Die Variable
 dsp_adr wird auf die Base-Adresse des
 SB gesetzt.
}
VAR
  Port, Lst : WORD;
BEGIN
 Detect_Reg_sb16 := SbRegDetected;
 IF SbRegDetected THEN EXIT;
 { Exit, wenn initialisiert   }
 Port := $210;
 Lst  := $280;
 { Mîgliche SB-Adressen zwischen $210
   und $280 ! }
 WHILE (NOT SbRegDetected)
 AND   (Port <= Lst)  DO BEGIN
   dsp_adr := Port;
   SbRegDetected := Reset_sb16;
   IF NOT SbRegDetected THEN
     INC(Port, $10);
 END;
 Detect_Reg_sb16 := SbRegDetected;
END;

PROCEDURE Write_MixerReg_sb16(Reg,
Val: BYTE);
{
 Schreibt den in Val Åbergebenen Wert an
 das in Reg angegebene Register des
 Mixer - Chips
}
begin;
 Port[dsp_adr+$4] := Reg;
 Port[dsp_adr+$5] := Val;
END;

FUNCTION Read_MixerReg_sb16(Reg: BYTE)
: BYTE;
{
 Die Function liefert den Inhalt des Åber
 Reg indizierten Registers des Mixer-Chips
}
begin;
  Port[dsp_adr+$4] := Reg;
  Read_MixerReg_sb16 := Port[dsp_adr+$5];
end;

procedure reset_Mixer; assembler;
{
 Resettet den Mixer Chip auf seine
 Default - Werte
}
asm
  mov dx,dsp_adr+$4
  mov al,0
  out dx,al
  mov cx,50
@loop:
  loop @loop
  inc dx
  inc al
  out dx,al
end;

FUNCTION Detect_Mixer_sb16 : BOOLEAN;
{
 Function zu Erkennung des Mixer-Chips.
 TRUE, wenn der Mixer gefunden wurde,
 ansonsten FALSE
}
VAR SaveReg : WORD;
    NewReg  : WORD;
BEGIN
  Detect_Mixer_sb16 := MixerDetected;
  IF (NOT SbRegDetected)
  OR MixerDetected THEN EXIT;
  { Abbruch, wenn keine Soundblaster-Karte
    vorhanden oder Mixer-Chip schon
    initalisiert }
  Reset_Mixer;
  SaveReg := Read_MixerReg_sb16($22);
  { Register sichern }
  Write_MixerReg_sb16($22, 243);
  NewReg  := Read_MixerReg_sb16($22);
  { Wenn der geschribene wert mit dem
    zurÅckgelesenen Åbereinstimmt, so
    ist ein Zugriff mîglich und somit
    ein Mixer vorhanden }
  IF NewReg = 243 THEN begin;
    MixerDetected := TRUE;
    STEREO := True;
  end;
  Write_MixerReg_sb16($22, SaveReg);
  { Altes Register zurÅck }
  Detect_Mixer_sb16 := MixerDetected;
END;

PROCEDURE SbGetDSPVersion;
VAR i : WORD;
    t : WORD;
    s : STRING[2];
BEGIN
  wr_dsp_sb16($E1);
  { $E1 = Versionsabfrage }
  SbVersMaj := SbReadByte;
  SbVersMin := SbReadByte;
  str(SbVersMaj, SbVersStr);
  SbVersStr := SbVersStr + '.';
  str(SbVersMin, s);
  if SbVersMin > 9 then
    SbVersStr := SbVersStr +       s
  else
    SbVersStr := SbVersStr + '0' + s;
END;

procedure dsp_int_sb16; interrupt;
{
 Diese Procedure wird bei verbogenem SB-
 Interrupt nach Beendigung einer Sound-
 Ausgabe via DMA angesprungen. Die Pro-
 zedur sollte aber NICHT angesprungen
 werden, wenn der Computer schnellgenug
 arbeite, da wir ja gerade dies Åber die
 Timer-Programmierung abfangen. Deshalb
 erfolgt die Ausgabe einer Warnung.
}
var h : byte;
begin;
  h := port[dsp_adr+$E];
  dsp_rdy_sb16 := true;
  Port[$20] := $20;
  Choose_lower_freq := true;
end;

function wrt_dsp_adr_sb16 : string;
{
 Liefert die Base-Adresse des SB als
 String zurÅck
}
begin;
  case dsp_adr of
    $210 : wrt_dsp_adr_sb16 := '210';
    $220 : wrt_dsp_adr_sb16 := '220';
    $230 : wrt_dsp_adr_sb16 := '230';
    $240 : wrt_dsp_adr_sb16 := '240';
    $250 : wrt_dsp_adr_sb16 := '250';
    $260 : wrt_dsp_adr_sb16 := '260';
    $270 : wrt_dsp_adr_sb16 := '270';
    $270 : wrt_dsp_adr_sb16 := '280';
   END;
end;

function wrt_dsp_irq : string;
{
 Liefert den IRQ des SB als String zurÅck
}
begin;
  case dsp_irq of
     $2 : wrt_dsp_irq := '2 h';
     $3 : wrt_dsp_irq := '3 h';
     $5 : wrt_dsp_irq := '5 h';
     $7 : wrt_dsp_irq := '7 h';
    $10 : wrt_dsp_irq := '10 h';
   END;
end;

procedure Set_Timeconst_sb16(tc : byte);
{
 Procedure zum setzen der Time-Konstanten.
 Sie berechnet sich nach der Formel
 tc := 256 - (1000000 / Frequenz).
}
begin;
  wr_dsp_sb16($40);
  { $40 = Setze Sample Rate }
  wr_dsp_sb16(tc);
end;

procedure testIRQ; interrupt;
{
 Diese Routine wird zur Erkennung
 des IRQ benîtigt
}
begin;
  IRQDetected := TRUE;
end;

procedure detect_sbIRQ;
{
 Diese Routine erkennt den IRQ der Sound-
 blaster-Karte. Es werden dazu alle mîg-
 lichen Interrupts durchgetestet. Dazu
 werden kurze Blocke via DMA ausgegeben.
 Wenn am Ende der Ausgabe der eingestellte
 Interrupt angesprungen wird, so ist der
 richtige gefunden.
}
const moegliche_irqs : array[1..5] of byte
 = ($2,$3,$5,$7,$10);
var i : integer;
begin;
 getmem(blk,12);
 set_Timeconst_sb16(211);
 wr_dsp_sb16($D3);
 { Lautsprecher aus }
 i := 1;
 while (i <= 5) and (not IRQDetected) do
   begin;
     dsp_irq := moegliche_irqs[i];
     { zu Testender IRQ }
     getintvec($8+dsp_irq,oldint);
     { Interrupt Verbiegen }
     setintvec($8+dsp_irq,@testIRQ);
     irqmsk := 1 shl dsp_irq;
     port[$21] := port[$21] and
       not irqmsk;
     blockgroesse := 12;
     dsp_block_sb16;
     { testweise Ausgabe }
     delay(30);
     setintvec($8+dsp_irq,oldint);
     { Interrupt wieder zurÅck    }
     port[$21] := Port[$21] or irqmsk;
     port[dsp_adr+$c] := $d3;
     Port[$20] := $20;
     inc(i);
   end;
 wr_dsp_sb16($D1);
 { Lautsprecher wieder ein }
 freemem(blk,12);
end;

function Init_Sb16 : boolean;
{
 Diese Function initialisiert den Sound-
 blaster. Sie liefert TRUE zurÅck, wenn
 die Initialisierung erfolgreich war,
 ansonsten FALSE. Der Lautsprecher fÅr
 Sampling-Ausgabe wird eingeschaltet. Der
 DMA-Ready Interrupt wird auf eine eigene
 Routine verbogen.
}
begin;
 if not detect_Reg_sb16 then begin;
   Init_Sb16 := false;
   exit;
 end else Init_Sb16 := true;
 { Soundblaster gefunden }
 detect_sbIRQ;
 { IRQ auto-detection }
 if Detect_Mixer_sb16 then begin;
   SbProDetected := TRUE;
   { SB Pro gefunden }
 end;
 SbGetDspVersion;
 if SbVersMaj > 4 then
  { SB 16 ASP gefunden }
   Sb16Detected := true;
 wr_dsp_sb16($D1);
 { Lautsprecher ein }
 getintvec($8+dsp_irq,oldint);
 { Alten Interrupt sichern, }
 setintvec($8+dsp_irq,@dsp_int_sb16);
 { auf eigene Routine setzen }
 irqmsk := 1 shl dsp_irq;
 { Interrupt einmaskieren }
 port[$21] := port[$21] and not irqmsk;
end;

procedure write_sbConfig;
{
 Die Procedure gibt die gefundene Konfi-
 guration auf dem Bildschirm aus. Sie
 dient vornehmlich als Beispiel, wie die
 Informationen verwendet werden kînnen.
}
begin;
  if SbRegDetected then begin;
    writeln('Soundkarte an Base ',
    wrt_dsp_adr_sb16,'h mit IRQ ',
    wrt_dsp_irq,' gefunden.');
  end else begin;
    writeln('Keine Soundblaster-',
    'kompatibele Karte gefunden !');
  end;
  if MixerDetected then begin;
    writeln('Mixer - Chip gefunden');
    if SbVersMaj < 4 then
      writeln('Die gefundene Karte ist',
      ' ein Soundblaster Pro oder ',
      'kompatibel')
    else
      writeln('Die gefundene Karte ist',
      ' ein Soundblaster 16 ASP oder ',
      'kompatibel');
  end else begin;
    writeln('Die gefundene Karte ist',
    ' ein Soundblaster oder kompatibel');
  end;
  writeln('Die Versionsnummer lautet ',
  SbVersStr);
end;

procedure Exit_Sb16;
{
 Diese Prozedur wir beim Beenden des
 Programms aufgerufen und setzt den
 verbogenen DMA-Interrupt auf seinen
 Ausgangswert
}
begin;
  setintvec($8+dsp_irq,oldint);
  port[$21] := Port[$21] or irqmsk;
  { Alten Interrupt wieder herstellen und
    Maskierung auf alten Wert zurÅck }
  port[dsp_adr+$c] := $d3;
  { Lautsprecher aus }
  Port[$20] := $20;
end;

procedure Spiele_Sb16(Segm,Offs
 ,dsize : word);
{
 Diese Procedure spielt den Åber
 Segm:Offs adressierten Block mit der
 Grî·e dsize ab. Es ist darauf zu achten,
 das der DMA-Controller NICHT SeitenÅber-
 greifend arbeiten kann ...
}
begin;
  port[$0A] := dma_ch+4;
  { DMA-Kanal sperren }
  Port[$0B] := $49;
  { fÅr Soundausgabe }
  Port[$0c] := 0;
  Port[$02] := Lo(offs);
  Port[$02] := Hi(offs);
  { Adresse des Puffers (blk) an
    DMA-Controller }
  Port[$83] := Segm;
  Port[$03] := Lo(dsize-1);
  Port[$03] := Hi(dsize-1);
  { Grî·e des Blockes (blockgroesse)
    an DMA-Controller }
  Port[$0A] := dma_ch;
  { DMA-Kanal freigeben }
{  wr_dsp_sb16($14);}
  { DSP-Befehl 8-Bit Åber DMA  }
  wr_dsp_sb16($D0);
  wr_dsp_sb16($14);
  wr_dsp_sb16(Lo(dsize-1));
  wr_dsp_sb16(Hi(dsize-1));
  { Grî·e des Blockes an den DSP }
end;

procedure dsp_block_sb16;
{
 Diese Procedure startet die Ausgabe
 des Daten-Blocks blk mit der Grî·e
 blockgroesse Åber DMA
}
var l : longint;
    pn,ofs : word;
    hbyte : byte;
    a : word;
    OldV,NewV,Hilfe : byte;
begin;
  dsp_rdy_sb16 := false;
  l := 16*longint(pt(blk).sgm)+
  pt(blk).ofs;
  pn := pt(l).sgm;
  ofs := pt(l).ofs;
  Spiele_Sb16(pn,ofs,blockgroesse);
end;

procedure memmovew(q,d : pt;anzahl
 : word); assembler;
{
 Procedure zum schnellen kopieren von zwei
 Speicherbereichen. öberlappungen werden
 nicht berÅcksichtigt
}
asm
  push ds
  mov si,q.sgm
  mov ds,si
  mov si,q.ofs
  mov di,d.sgm
  mov es,di
  mov di,d.ofs
  mov cx,anzahl
  rep movsw
  pop ds
end;

procedure sreg; assembler;
{
 Sichert die Register in die Variablen
 lax bis ldi
}
asm
 mov lax,ax
 mov lbx,bx
 mov lcx,cx
 mov ldx,dx
 mov lsi,si
 mov ldi,di
 mov ax,es
 mov les,ax
 mov ax,ds
 mov lds,ax
end;

procedure rreg; assembler;
{
 Stellt die Register mit den Werten aus
 lax bis ldi wieder her
}
asm
 mov bx,lbx
 mov cx,lcx
 mov dx,ldx
 mov si,lsi
 mov di,ldi
 mov ax,les
 mov es,ax
 mov ax,lds
 mov ds,ax
 mov ax,lax
end;

procedure syreg; assembler;
{
 Sichert die Register in die Variablen
 yax bis ydi
}
asm
 mov yax,ax
 mov ybx,bx
 mov ycx,cx
 mov ydx,dx
 mov ysi,si
 mov ydi,di
 mov ax,es
 mov yes,ax
 mov ax,ds
 mov yds,ax
end;

procedure ryreg; assembler;
{
 Stellt die Register mit den Werten aus
 yax bis ydi wieder her
}
asm
 mov bx,ybx
 mov cx,ycx
 mov dx,ydx
 mov si,ysi
 mov di,ydi
 mov ax,yes
 mov es,ax
 mov ax,yds
 mov ds,ax
 mov ax,yax
end;

procedure get_pctune(hoehe : word;Var vk
: word;VAR nk,dif : byte);
{
 Die Procedure ermittelt aus der Åberge-
 benen Tonhîhe (so wie sie in der MOD-
 Datei steht) die fÅr die Frequenz-Mani-
 pulation benîtigten Vor- und Nachkomma-
 stellen.
}
var nct : byte;
    gefunden : boolean;
begin;
 nct := 1;
 gefunden := false;
 while (nct < 60) and not gefunden do
 { Bis gefunden oder letzter Wert in
   Tabelle }
 begin;
   if hoehe > Modoktave[nct] then
     gefunden := true;
   inc(nct);
 end;
 if gefunden then begin;
   dif := ndiff[nct-tpw+12];
   vk  := vkt[nct-tpw+12];
   nk  := nkt[nct-tpw+12];
   { Werte aus Tabelle holen. Tuning Åber
     die tpw }
 end;
end;

procedure innen_schleife_4; assembler;
{
 Hier erfolgt die eigentliche Vermischung
 der Daten. Der Puffer blk wird dabei mit
 den berechneten Daten gefÅllt.
}
Var Output : word;
asm
  mov cx,Sound_Schleifen
@Die_Schleife:
    push cx
    xor ax,ax  { Register zurÅcksetzen }
    xor dx,dx
    mov Output,ax
    mov bx,in1l
    sub bx,in1p
    cmp bx,10
    ja  @Nochn_label1
 { Ton holen, da alles normal }
    cmp ll1,10
    jae @Ton_St1_loop
 { Wenn Loopen, dann Loopproc und weiter }
    mov Vk1,0
    mov Nk1,0
 { Ende erreicht, stehenbleiben }
@Nochn_label1:
    mov bx,i1.sgm  { Instr. 1 laden }
    mov es,bx
    mov bx,Inst1vk
    mov al,es:[bx]
    sub al,128
    mul Notvol1  { LautstÑrke berechnen }
    shr ax,6
    jmp @Weiter_Stimme_1
@Ton_St1_loop:
    mov ax,ls1  { Auf Loopstart setzen }
    add ax,5    { + 5 wgn. Knacken }
    mov in1p,ax
    mov Inst1vk,ax
    jmp @Nochn_label1
@Weiter_Stimme_1:
    mov bx,Vk1  { Zeiger weitersetzen }
    add Inst1vk,bx
    add in1p,bx
    mov bl,Inst1nk
    mov dl,Nk1  { Nachkomma Behandlung }
    add bl,dl
@CheckPermUp_1:
    cmp PermUp_1,0
    je  @CheckPermDo_1
    inc nk1
    dec Dif1           { Dec Dif }
    jnz @ueberlauf_1
    mov PermUp_1,0
 { Wenn Dif = 0 => PerUp = 0 }
    jmp @ueberlauf_1
@CheckPermDo_1:
    cmp PermDo_1,0
    je  @ueberlauf_1
    dec nk1
    dec Dif1           { Dec Dif }
    jnz @ueberlauf_1
    mov PermDo_1,0
 { Wenn Dif = 0 => PerDo = 0 }
@ueberlauf_1:   { Nachkomma - Korrektur }
    cmp bl,100
    jna @Inst1_weiter
    sub bl,100
    inc Inst1vk
    inc in1p
    jmp @ueberlauf_1
@Inst1_weiter:
    mov Inst1nk,bl
@Stimme_2:
    mov Output,ax
    mov bx,in2l
    sub bx,in2p
    cmp bx,10
    ja  @Nochn_label2
    cmp ll2,10
    jae @Ton_St2_loop
    mov Vk2,0
    mov Nk2,0
@Nochn_label2:
    mov bx,i2.sgm
    mov es,bx
    mov bx,Inst2vk
    mov al,es:[bx]
    sub al,128
    mul Notvol2
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_2
@Ton_St2_loop:
    mov bx,ls2
    add bx,5
    mov in2p,bx
    mov Inst2vk,bx
    jmp @Nochn_label2
@Weiter_Stimme_2:
    mov bx,Vk2
    add Inst2vk,bx
    add in2p,bx
    mov bl,Inst2nk
    mov dl,Nk2
    add bl,dl
@CheckPermUp_2:
    cmp PermUp_2,0
    je  @CheckPermDo_2
    inc nk2
    dec Dif2
    jnz @ueberlauf_2
    mov PermUp_2,0
    jmp @ueberlauf_2
@CheckPermDo_2:
    cmp PermDo_2,0
    je  @ueberlauf_2
    dec nk2
    dec Dif2
    jnz @ueberlauf_2
    mov PermDo_2,0
@ueberlauf_2:
    cmp bl,100
    jna @Inst2_weiter
    sub bl,100
    inc Inst2vk
    inc in2p
    jmp @ueberlauf_2
@Inst2_weiter:
    mov Inst2nk,bl
@Stimme_3:
    mov bx,in3l
    sub bx,in3p
    cmp bx,10
    ja  @Nochn_label3
    cmp ll3,10
    jae @Ton_St3_loop
    mov Vk3,0
    mov Nk3,0
@Nochn_label3:
    mov bx,i3.sgm
    mov es,bx
    mov bx,Inst3vk
    mov al,es:[bx]
    sub al,128
    mul Notvol3
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_3
@Ton_St3_loop:
    mov bx,ls3
    add bx,5
    mov in3p,bx
    mov Inst3vk,bx
    jmp @Nochn_label3
@Weiter_Stimme_3:
    mov bx,Vk3
    add Inst3vk,bx
    add in3p,bx
    mov bl,Inst3nk
    mov dl,Nk3
    add bl,dl
@CheckPermUp_3:
    cmp PermUp_3,0
    je  @CheckPermDo_3
    inc nk3
    dec Dif3
    jnz @ueberlauf_3
    mov PermUp_3,0
    jmp @ueberlauf_3
@CheckPermDo_3:
    cmp PermDo_3,0
    je  @ueberlauf_3
    dec nk3
    dec Dif3
    jnz @ueberlauf_3
    mov PermDo_3,0
@ueberlauf_3:
    cmp bl,100
    jna @Inst3_weiter
    sub bl,100
    inc Inst3vk
    inc in3p
    jmp @ueberlauf_3
@Inst3_weiter:
    mov Inst3nk,bl
@Stimme_4:
    mov bx,in4l
    sub bx,in4p
    cmp bx,10
    ja  @Nochn_label4
    cmp ll4,10
    jae @Ton_St4_loop
    mov Vk4,0
    mov Nk4,0
@Nochn_label4:
    mov bx,i4.sgm
    mov es,bx
    mov bx,Inst4vk
    mov al,es:[bx]
    sub al,128
    mul Notvol4
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_4
@Ton_St4_loop:
    mov bx,ls4
    add bx,5
    mov in4p,bx
    mov Inst4vk,bx
    jmp @Nochn_label4
@Weiter_Stimme_4:
    mov bx,Vk4
    add Inst4vk,bx
    add in4p,bx
    mov bl,Inst4nk
    mov dl,Nk4
    add bl,dl
@CheckPermUp_4:
    cmp PermUp_4,0
    je  @CheckPermDo_4
    inc nk4
    dec Dif4
    jnz @ueberlauf_4
    mov PermUp_4,0
    jmp @ueberlauf_4
@CheckPermDo_4:
    cmp PermDo_4,0
    je  @ueberlauf_4
    dec nk4
    dec Dif4
    jnz @ueberlauf_4
    mov PermDo_4,0
@ueberlauf_4:
    cmp bl,100
    jna @Inst4_weiter
    sub bl,100
    inc Inst4vk
    inc in4p
    jmp @ueberlauf_4
@Inst4_weiter:
    mov Inst4nk,bl
@Weiter_Ziel:
    cmp playeffect,1
 { Effekt abspielen ? }
    jne @effekt_ende
    mov bx,Effekt.sgm
    mov es,bx
    mov bx,Effistvk
    mov ah,0
    mov al,es:[bx]
    cmp converteff,1
    jne @PC_Format { FÅr PC/AMIGA Format }
    sub al,128
@PC_Format:
    mul effectvolume
    shr ax,6
 { LautstÑrke berechnen }
    add Output,ax
    add Output,ax
    add Output,ax
    add Output,ax
    shr Output,3
    mov bx,effektgroesse
    sub bx,effektposi
    cmp bx,5
    ja   @Sound_moves
    jmp  @Sound_raus
@Sound_moves:
    mov bx,Effvk
    add Effistvk,bx
    add Effektposi,bx
    mov bl,Effistnk
    mov dl,Effnk
    add bl,dl
@ueberlauf_E:
    cmp bl,100 { Nachkomma - Behandlung }
    jna @Effekt_weiter
    sub bl,100
    inc Effistvk
    inc Effektposi
    jmp @ueberlauf_E
@effekt_weiter:
    mov Effistnk,bl
    mov bx,effektgroesse
    sub bx,effektposi
    cmp bx,0
    ja  @Sound_raus
    mov playeffect,0
    jmp @Sound_raus
@effekt_Ende:
    shr Output,3
@Sound_raus:
    mov bx,ziel.sgm
    mov es,bx
    mov bx,ziel.ofs
    mov ax,Output
    mov es:[bx],al
 {Byte ins Ziel schreiben}
    inc ziel.ofs
    pop cx
    dec cx
    cmp cx,0
    ja  @Die_Schleife
end;

procedure innen_schleife_8n; assembler;
{
 Hier erfolgt die eigentliche Vermi-
 schung der Daten. Der Puffer blk wird
 dabei mit den berechneten Daten gefÅllt.
}
Var Output : word;
asm
  mov cx,Sound_Schleifen
@Die_Schleife:
    push cx
    xor ax,ax  { Register zurÅcksetzen }
    xor dx,dx
    mov Output,ax
    mov bx,in1l
    sub bx,in1p
    cmp bx,10
    ja  @Nochn_label1
 { Ton holen, da alles normal }
    cmp ll1,10
    jae @Ton_St1_loop
 { Wenn Loopen, dann Loopproc und weiter }
    mov Vk1,0
    mov Nk1,0
 { Ende erreicht, stehenbleiben }
@Nochn_label1:
    mov bx,i1.sgm  { Instr. 1 laden }
    mov es,bx
    mov bx,Inst1vk
    mov al,es:[bx]
    sub al,128
    mul Notvol1  { LautstÑrke berechnen }
    shr ax,6
    jmp @Weiter_Stimme_1
@Ton_St1_loop:
    mov ax,ls1  { Auf Loopstart setzen }
    add ax,5    { + 5 wgn. Knacken }
    mov in1p,ax
    mov Inst1vk,ax
    jmp @Nochn_label1
@Weiter_Stimme_1:
    mov bx,Vk1  { Zeiger weitersetzen }
    add Inst1vk,bx
    add in1p,bx
    mov bl,Inst1nk
    mov dl,Nk1  { Nachkomma Behandlung }
    add bl,dl
@CheckPermUp_1:
    cmp PermUp_1,0
    je  @CheckPermDo_1
    inc nk1
    dec Dif1           { Dec Dif }
    jnz @ueberlauf_1
    mov PermUp_1,0
 { Wenn Dif = 0 => PerUp = 0 }
    jmp @ueberlauf_1
@CheckPermDo_1:
    cmp PermDo_1,0
    je  @ueberlauf_1
    dec nk1
    dec Dif1           { Dec Dif }
    jnz @ueberlauf_1
    mov PermDo_1,0
 { Wenn Dif = 0 => PerDo = 0 }
@ueberlauf_1:   { Nachkomma - Korrektur }
    cmp bl,100
    jna @Inst1_weiter
    sub bl,100
    inc Inst1vk
    inc in1p
    jmp @ueberlauf_1
@Inst1_weiter:
    mov Inst1nk,bl
@Stimme_2:
    mov Output,ax
    mov bx,in2l
    sub bx,in2p
    cmp bx,10
    ja  @Nochn_label2
    cmp ll2,10
    jae @Ton_St2_loop
    mov Vk2,0
    mov Nk2,0
@Nochn_label2:
    mov bx,i2.sgm
    mov es,bx
    mov bx,Inst2vk
    mov al,es:[bx]
    sub al,128
    mul Notvol2
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_2
@Ton_St2_loop:
    mov bx,ls2
    add bx,5
    mov in2p,bx
    mov Inst2vk,bx
    jmp @Nochn_label2
@Weiter_Stimme_2:
    mov bx,Vk2
    add Inst2vk,bx
    add in2p,bx
    mov bl,Inst2nk
    mov dl,Nk2
    add bl,dl
@CheckPermUp_2:
    cmp PermUp_2,0
    je  @CheckPermDo_2
    inc nk2
    dec Dif2
    jnz @ueberlauf_2
    mov PermUp_2,0
    jmp @ueberlauf_2
@CheckPermDo_2:
    cmp PermDo_2,0
    je  @ueberlauf_2
    dec nk2
    dec Dif2
    jnz @ueberlauf_2
    mov PermDo_2,0
@ueberlauf_2:
    cmp bl,100
    jna @Inst2_weiter
    sub bl,100
    inc Inst2vk
    inc in2p
    jmp @ueberlauf_2
@Inst2_weiter:
    mov Inst2nk,bl
@Stimme_3:
    mov bx,in3l
    sub bx,in3p
    cmp bx,10
    ja  @Nochn_label3
    cmp ll3,10
    jae @Ton_St3_loop
    mov Vk3,0
    mov Nk3,0
@Nochn_label3:
    mov bx,i3.sgm
    mov es,bx
    mov bx,Inst3vk
    mov al,es:[bx]
    sub al,128
    mul Notvol3
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_3
@Ton_St3_loop:
    mov bx,ls3
    add bx,5
    mov in3p,bx
    mov Inst3vk,bx
    jmp @Nochn_label3
@Weiter_Stimme_3:
    mov bx,Vk3
    add Inst3vk,bx
    add in3p,bx
    mov bl,Inst3nk
    mov dl,Nk3
    add bl,dl
@CheckPermUp_3:
    cmp PermUp_3,0
    je  @CheckPermDo_3
    inc nk3
    dec Dif3
    jnz @ueberlauf_3
    mov PermUp_3,0
    jmp @ueberlauf_3
@CheckPermDo_3:
    cmp PermDo_3,0
    je  @ueberlauf_3
    dec nk3
    dec Dif3
    jnz @ueberlauf_3
    mov PermDo_3,0
@ueberlauf_3:
    cmp bl,100
    jna @Inst3_weiter
    sub bl,100
    inc Inst3vk
    inc in3p
    jmp @ueberlauf_3
@Inst3_weiter:
    mov Inst3nk,bl

@Stimme_4:
    mov bx,in4l
    sub bx,in4p
    cmp bx,10
    ja  @Nochn_label4
    cmp ll4,10
    jae @Ton_St4_loop
    mov Vk4,0
    mov Nk4,0
@Nochn_label4:
    mov bx,i4.sgm
    mov es,bx
    mov bx,Inst4vk
    mov al,es:[bx]
    sub al,128
    mul Notvol4
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_4
@Ton_St4_loop:
    mov bx,ls4
    add bx,5
    mov in4p,bx
    mov Inst4vk,bx
    jmp @Nochn_label4
@Weiter_Stimme_4:
    mov bx,Vk4
    add Inst4vk,bx
    add in4p,bx
    mov bl,Inst4nk
    mov dl,Nk4
    add bl,dl
@CheckPermUp_4:
    cmp PermUp_4,0
    je  @CheckPermDo_4
    inc nk4
    dec Dif4
    jnz @ueberlauf_4
    mov PermUp_4,0
    jmp @ueberlauf_4
@CheckPermDo_4:
    cmp PermDo_4,0
    je  @ueberlauf_4
    dec nk4
    dec Dif4
    jnz @ueberlauf_4
    mov PermDo_4,0
@ueberlauf_4:
    cmp bl,100
    jna @Inst4_weiter
    sub bl,100
    inc Inst4vk
    inc in4p
    jmp @ueberlauf_4
@Inst4_weiter:
    mov Inst4nk,bl

@Stimme_5:
    mov bx,in5l
    sub bx,in5p
    cmp bx,10
    ja  @Nochn_label5
    cmp ll5,10
    jae @Ton_St5_loop
    mov Vk5,0
    mov Nk5,0
@Nochn_label5:
    mov bx,i5.sgm
    mov es,bx
    mov bx,Inst5vk
    mov al,es:[bx]
    sub al,128
    mul Notvol5
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_5
@Ton_St5_loop:
    mov bx,ls5
    add bx,5
    mov in5p,bx
    mov Inst5vk,bx
    jmp @Nochn_label5
@Weiter_Stimme_5:
    mov bx,Vk5
    add Inst5vk,bx
    add in5p,bx
    mov bl,Inst5nk
    mov dl,Nk5
    add bl,dl
@CheckPermUp_5:
    cmp PermUp_5,0
    je  @CheckPermDo_5
    inc nk5
    dec Dif5
    jnz @ueberlauf_5
    mov PermUp_5,0
    jmp @ueberlauf_5
@CheckPermDo_5:
    cmp PermDo_5,0
    je  @ueberlauf_5
    dec nk5
    dec Dif5
    jnz @ueberlauf_5
    mov PermDo_5,0
@ueberlauf_5:
    cmp bl,100
    jna @Inst5_weiter
    sub bl,100
    inc Inst5vk
    inc in5p
    jmp @ueberlauf_5
@Inst5_weiter:
    mov Inst5nk,bl

@Stimme_6:
    mov bx,in6l
    sub bx,in6p
    cmp bx,10
    ja  @Nochn_label6
    cmp ll6,10
    jae @Ton_St6_loop
    mov Vk6,0
    mov Nk6,0
@Nochn_label6:
    mov bx,i6.sgm
    mov es,bx
    mov bx,Inst6vk
    mov al,es:[bx]
    sub al,128
    mul Notvol6
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_6
@Ton_St6_loop:
    mov bx,ls6
    add bx,5
    mov in6p,bx
    mov Inst6vk,bx
    jmp @Nochn_label6
@Weiter_Stimme_6:
    mov bx,Vk6
    add Inst6vk,bx
    add in6p,bx
    mov bl,Inst6nk
    mov dl,Nk6
    add bl,dl
@CheckPermUp_6:
    cmp PermUp_6,0
    je  @CheckPermDo_6
    inc nk6
    dec Dif6
    jnz @ueberlauf_6
    mov PermUp_6,0
    jmp @ueberlauf_6
@CheckPermDo_6:
    cmp PermDo_6,0
    je  @ueberlauf_6
    dec nk6
    dec Dif6
    jnz @ueberlauf_6
    mov PermDo_6,0
@ueberlauf_6:
    cmp bl,100
    jna @Inst6_weiter
    sub bl,100
    inc Inst6vk
    inc in6p
    jmp @ueberlauf_6
@Inst6_weiter:
    mov Inst6nk,bl

@Stimme_7:
    mov bx,in7l
    sub bx,in7p
    cmp bx,10
    ja  @Nochn_label7
    cmp ll7,10
    jae @Ton_St7_loop
    mov Vk7,0
    mov Nk7,0
@Nochn_label7:
    mov bx,i7.sgm
    mov es,bx
    mov bx,Inst7vk
    mov al,es:[bx]
    sub al,128
    mul Notvol7
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_7
@Ton_St7_loop:
    mov bx,ls7
    add bx,5
    mov in7p,bx
    mov Inst7vk,bx
    jmp @Nochn_label7
@Weiter_Stimme_7:
    mov bx,Vk7
    add Inst7vk,bx
    add in7p,bx
    mov bl,Inst7nk
    mov dl,Nk7
    add bl,dl
@CheckPermUp_7:
    cmp PermUp_7,0
    je  @CheckPermDo_7
    inc nk7
    dec Dif7
    jnz @ueberlauf_7
    mov PermUp_7,0
    jmp @ueberlauf_7
@CheckPermDo_7:
    cmp PermDo_7,0
    je  @ueberlauf_7
    dec nk7
    dec Dif7
    jnz @ueberlauf_7
    mov PermDo_7,0
@ueberlauf_7:
    cmp bl,100
    jna @Inst7_weiter
    sub bl,100
    inc Inst7vk
    inc in7p
    jmp @ueberlauf_7
@Inst7_weiter:
    mov Inst7nk,bl

@Stimme_8:
    mov bx,in8l
    sub bx,in8p
    cmp bx,10
    ja  @Nochn_label8
    cmp ll8,10
    jae @Ton_St8_loop
    mov Vk8,0
    mov Nk8,0
@Nochn_label8:
    mov bx,i8.sgm
    mov es,bx
    mov bx,Inst8vk
    mov al,es:[bx]
    sub al,128
    mul Notvol8
    shr ax,6
    add Output,ax
    jmp @Weiter_Stimme_8
@Ton_St8_loop:
    mov bx,ls8
    add bx,5
    mov in8p,bx
    mov Inst8vk,bx
    jmp @Nochn_label8
@Weiter_Stimme_8:
    mov bx,Vk8
    add Inst8vk,bx
    add in8p,bx
    mov bl,Inst8nk
    mov dl,Nk8
    add bl,dl
@CheckPermUp_8:
    cmp PermUp_8,0
    je  @CheckPermDo_8
    inc nk8
    dec Dif8
    jnz @ueberlauf_8
    mov PermUp_8,0
    jmp @ueberlauf_8
@CheckPermDo_8:
    cmp PermDo_8,0
    je  @ueberlauf_8
    dec nk8
    dec Dif8
    jnz @ueberlauf_8
    mov PermDo_8,0
@ueberlauf_8:
    cmp bl,100
    jna @Inst8_weiter
    sub bl,100
    inc Inst8vk
    inc in8p
    jmp @ueberlauf_8
@Inst8_weiter:
    mov Inst8nk,bl
@Weiter_Ziel:
    cmp playeffect,1
 { Effekt abspielen ? }
    jne @effekt_ende
    mov bx,Effekt.sgm
    mov es,bx
    mov bx,Effistvk
    mov ah,0
    mov al,es:[bx]
    cmp converteff,1
    jne @PC_Format { FÅr PC/AMIGA Format }
    sub al,128
@PC_Format:
    mul effectvolume
    shr ax,6
 { LautstÑrke berechnen }
    add Output,ax
    add Output,ax
    add Output,ax
    add Output,ax
    add Output,ax
    add Output,ax
    add Output,ax
    add Output,ax
    shr Output,4
    mov bx,effektgroesse
    sub bx,effektposi
    cmp bx,5
    ja   @Sound_moves
    jmp  @Sound_raus
@Sound_moves:
    mov bx,Effvk
    add Effistvk,bx
    add Effektposi,bx
    mov bl,Effistnk
    mov dl,Effnk
    add bl,dl
@ueberlauf_E:
    cmp bl,100 { Nachkomma - Behandlung }
    jna @Effekt_weiter
    sub bl,100
    inc Effistvk
    inc Effektposi
    jmp @ueberlauf_E
@effekt_weiter:
    mov Effistnk,bl
    mov bx,effektgroesse
    sub bx,effektposi
    cmp bx,0
    ja  @Sound_raus
    mov playeffect,0
    jmp @Sound_raus
@effekt_Ende:
    shr Output,4
@Sound_raus:
    mov bx,ziel.sgm
    mov es,bx
    mov bx,ziel.ofs
    mov ax,Output
    mov es:[bx],al
 {Byte ins Ziel schreiben}
    inc ziel.ofs
    pop cx
    dec cx
    cmp cx,0
    ja  @Die_Schleife
end;

{$F+}
procedure vermische_start_4;
{
 Initialisiert benîtigte Variablen
}
var rdiff : real;
    dummy : byte;
begin;
asm
  mov ax,i1.ofs
  add ax,in1p
  mov Inst1vk,ax
  mov Inst1nk,0
  mov ax,i2.ofs
  add ax,in2p
  mov Inst2vk,ax
  mov Inst2nk,0
  mov ax,i3.ofs
  add ax,in3p
  mov Inst3vk,ax
  mov Inst3nk,0
  mov ax,i4.ofs
  add ax,in4p
  mov Inst4vk,ax
  mov Inst4nk,0
end;
 if note1 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,1,1] and $0F)
    *256+Rm_Song[mli,1,2];
   get_pctune(tonhoehe,vk1,nk1,difb1);
 end;
 dif1 := difb1 * Rm_Song[mli,1,4];
 rdiff := dif1 / 4;
 dif1 := trunc(rdiff);
 Pnk1 := Pnk1 + round((rdiff-dif1)*100);
 if Pnk1 > 100 then begin;
   inc(dif1);
   dec(Pnk1,100);
 end;
 if note2 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,2,1] and $0F)
    *256+Rm_Song[mli,2,2];
   get_pctune(tonhoehe,vk2,nk2,difb2);
 end;
 dif2 := difb2 * Rm_Song[mli,2,4];
 rdiff := dif2 / 4;
 dif2 := trunc(rdiff);
 Pnk2 := Pnk2 + round((rdiff-dif2)*100);
 if Pnk2 > 100 then begin;
   inc(dif2);
   dec(Pnk2,100);
 end;
 if note3 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,3,1] and $0F)
    *256+Rm_Song[mli,3,2];
   get_pctune(tonhoehe,vk3,nk3,difb3);
 end;
 dif3 := difb3 * Rm_Song[mli,3,4];
 rdiff := dif3 / 4;
 dif3 := trunc(rdiff);
 Pnk3 := Pnk3 + round((rdiff-dif3)*100);
 if Pnk3 > 100 then begin;
   inc(dif3);
   dec(Pnk3,100);
 end;
 if note4 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,4,1] and $0F)
    *256+Rm_Song[mli,4,2];
   get_pctune(tonhoehe,vk4,nk4,difb4);
 end;
 dif4 := difb4 * Rm_Song[mli,4,4];
 rdiff := dif4 / 4;
 dif4 := trunc(rdiff);
 Pnk4 := Pnk4 + round((rdiff-dif4)*100);
 if Pnk4 > 100 then begin;
   inc(dif4);
   dec(Pnk4,100);
 end;
 ls1 := loop_s[In_st1];
 ll1 := loop_l[In_st1];
 ls2 := loop_s[In_st2];
 ll2 := loop_l[In_st2];
 ls3 := loop_s[In_st3];
 ll3 := loop_l[In_st3];
 ls4 := loop_s[In_st4];
 ll4 := loop_l[In_st4];
 if ll1 > 30 then in1l := ll1+ls1;
 if ll2 > 30 then in2l := ll2+ls2;
 if ll3 > 30 then in3l := ll3+ls3;
 if ll4 > 30 then in4l := ll4+ls4;
end;
{$F-}

{$F+}
procedure vermische_start_8;
{
 Initialisiert benîtigte Variablen
}
var rdiff : real;
begin;
asm
  mov ax,i1.ofs
  add ax,in1p
  mov Inst1vk,ax
  mov Inst1nk,0
  mov ax,i2.ofs
  add ax,in2p
  mov Inst2vk,ax
  mov Inst2nk,0
  mov ax,i3.ofs
  add ax,in3p
  mov Inst3vk,ax
  mov Inst3nk,0
  mov ax,i4.ofs
  add ax,in4p
  mov Inst4vk,ax
  mov Inst4nk,0
  mov ax,i5.ofs
  add ax,in5p
  mov Inst5vk,ax
  mov Inst5nk,0
  mov ax,i6.ofs
  add ax,in6p
  mov Inst6vk,ax
  mov Inst6nk,0
  mov ax,i7.ofs
  add ax,in7p
  mov Inst7vk,ax
  mov Inst7nk,0
  mov ax,i8.ofs
  add ax,in8p
  mov Inst8vk,ax
  mov Inst8nk,0
end;
 if note1 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,1,1] and $0F)
    *256+Rm_Song[mli,1,2];
   get_pctune(tonhoehe,vk1,nk1,difb1);
 end;
 dif1 := difb1 * Rm_Song[mli,1,4];
 rdiff := dif1 / 4;
 dif1 := trunc(rdiff);
 Pnk1 := Pnk1 + round((rdiff-dif1)*100);
 if Pnk1 > 100 then begin;
   inc(dif1);
   dec(Pnk1,100);
 end;
 if note2 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,2,1] and $0F)
    *256+Rm_Song[mli,2,2];
   get_pctune(tonhoehe,vk2,nk2,difb2);
 end;
 dif2 := difb2 * Rm_Song[mli,2,4];
 rdiff := dif2 / 4;
 dif2 := trunc(rdiff);
 Pnk2 := Pnk2 + round((rdiff-dif2)*100);
 if Pnk2 > 100 then begin;
   inc(dif2);
   dec(Pnk2,100);
 end;
 if note3 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,3,1] and $0F)
    *256+Rm_Song[mli,3,2];
   get_pctune(tonhoehe,vk3,nk3,difb3);
 end;
 dif3 := difb3 * Rm_Song[mli,3,4];
 rdiff := dif3 / 4;
 dif3 := trunc(rdiff);
 Pnk3 := Pnk3 + round((rdiff-dif3)*100);
 if Pnk3 > 100 then begin;
   inc(dif3);
   dec(Pnk3,100);
 end;
 if note4 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,4,1] and $0F)
    *256+Rm_Song[mli,4,2];
   get_pctune(tonhoehe,vk4,nk4,difb4);
 end;
 dif4 := difb4 * Rm_Song[mli,4,4];
 rdiff := dif4 / 4;
 dif4 := trunc(rdiff);
 Pnk4 := Pnk4 + round((rdiff-dif4)*100);
 if Pnk4 > 100 then begin;
   inc(dif4);
   dec(Pnk4,100);
 end;
 if note5 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,5,1] and $0F)
    *256+Rm_Song[mli,5,2];
   get_pctune(tonhoehe,vk5,nk5,difb5);
 end;
 dif5 := difb5 * Rm_Song[mli,1,4];
 rdiff := dif5 / 4;
 dif5 := trunc(rdiff);
 Pnk5 := Pnk5 + round((rdiff-dif5)*100);
 if Pnk5 > 100 then begin;
   inc(dif5);
   dec(Pnk5,100);
 end;
 if note6 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,6,1] and $0F)
    *256+Rm_Song[mli,6,2];
   get_pctune(tonhoehe,vk6,nk6,difb6);
 end;
 dif6 := difb6 * Rm_Song[mli,6,4];
 rdiff := dif6 / 4;
 dif6 := trunc(rdiff);
 Pnk6 := Pnk6 + round((rdiff-dif6)*100);
 if Pnk6 > 100 then begin;
   inc(dif6);
   dec(Pnk6,100);
 end;
 if note7 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,7,1] and $0F)
    *256+Rm_Song[mli,7,2];
   get_pctune(tonhoehe,vk7,nk7,difb7);
 end;
 dif7 := difb7 * Rm_Song[mli,7,4];
 rdiff := dif7 / 4;
 dif7 := trunc(rdiff);
 Pnk7 := Pnk7 + round((rdiff-dif7)*100);
 if Pnk7 > 100 then begin;
   inc(dif7);
   dec(Pnk7,100);
 end;
 if note8 <> 0 then begin;
   tonhoehe := (Rm_Song[mli,8,1] and $0F)
    *256+Rm_Song[mli,8,2];
   get_pctune(tonhoehe,vk8,nk8,difb8);
 end;
 dif8 := difb8 * Rm_Song[mli,8,4];
 rdiff := dif8 / 4;
 dif8 := trunc(rdiff);
 Pnk8 := Pnk8 + round((rdiff-dif8)*100);
 if Pnk8 > 100 then begin;
   inc(dif8);
   dec(Pnk8,100);
 end;
 ls1 := loop_s[In_st1];
 ll1 := loop_l[In_st1];
 ls2 := loop_s[In_st2];
 ll2 := loop_l[In_st2];
 ls3 := loop_s[In_st3];
 ll3 := loop_l[In_st3];
 ls4 := loop_s[In_st4];
 ll4 := loop_l[In_st4];
 ls5 := loop_s[In_st5];
 ll5 := loop_l[In_st5];
 ls6 := loop_s[In_st6];
 ll6 := loop_l[In_st6];
 ls7 := loop_s[In_st7];
 ll7 := loop_l[In_st7];
 ls8 := loop_s[In_st8];
 ll8 := loop_l[In_st8];
 if ll1 > 30 then in1l := ll1+ls1;
 if ll2 > 30 then in2l := ll2+ls2;
 if ll3 > 30 then in3l := ll3+ls3;
 if ll4 > 30 then in4l := ll4+ls4;
 if ll5 > 30 then in5l := ll5+ls5;
 if ll6 > 30 then in6l := ll6+ls6;
 if ll7 > 30 then in7l := ll7+ls7;
 if ll8 > 30 then in8l := ll8+ls8;
end;
{$F-}

function Notenvolumen(Stm : byte) : byte;
begin;
 Notenvolumen := Rm_Song[mli,Stm,4];
end;

procedure nmw_all_4;
var idx : byte;
begin;
   inc(mli);
   if mli > 64 then mli := 1;
   if mli = 1 then begin;
     inc(mlj);
     if mlj > Liedlaenge then begin;
       if mloop then begin;
         mlj := 1;
         Modp := Addr(Rm_Song);
         memmovew(pt(rm[lied[mlj]]),
         pt(Modp),1024);
       end else begin;
         asm
           call [periodisch_anhalten]
         end;
         music_aus := true;
       end;
     end else begin;
         Modp := Addr(Rm_Song);
         memmovew(pt(rm[lied[mlj]]),
         pt(Modp),1024);
     end;
   end;
  note1 := (Rm_Song[mli,1,1] AND $F0)+
   ((Rm_Song[mli,1,3] AND $F0) shr 4);
  note2 := (Rm_Song[mli,2,1] AND $F0)+
   ((Rm_Song[mli,2,3] AND $F0) shr 4);
  note3 := (Rm_Song[mli,3,1] AND $F0)+
   ((Rm_Song[mli,3,3] AND $F0) shr 4);
  note4 := (Rm_Song[mli,4,1] AND $F0)+
   ((Rm_Song[mli,4,3] AND $F0) shr 4);
  if note1 <> 0 then
   begin;
    Noten_Anschlag[1] := 500;
    In_St1  := note1;
    inst1  := Ptr(pt(Samp[In_St1]).sgm,
    pt(Samp[In_St1]).ofs);
    i1     := pt(inst1);
    in1l   := Sam_l[In_St1];
    in1p   := 0;
    notvol1 := Sam_vol[In_St1];
    Pnk1   := 0;
  end;
  if note2 <> 0 then
   begin;
    Noten_Anschlag[2] := 500;
    In_St2  := note2;
    inst2  := Ptr(pt(Samp[In_St2]).sgm,
    pt(Samp[In_St2]).ofs);
    i2     := pt(inst2);
    in2l   := Sam_l[In_St2];
    in2p   := 0;
    notvol2 := Sam_vol[In_St2];
    Pnk2   := 0;
  end;
  if note3 <> 0 then
   begin;
    Noten_Anschlag[3] := 500;
    In_St3  := note3;
    inst3  := Ptr(pt(Samp[In_St3]).sgm,
    pt(Samp[In_St3]).ofs);
    i3     := pt(inst3);
    in3l   := Sam_l[In_St3];
    in3p   := 0;
    notvol3 := Sam_vol[In_St3];
    Pnk3   := 0;
  end;
  if note4 <> 0 then
   begin;
    Noten_Anschlag[4] := 500;
    In_St4  := note4;
    inst4  := Ptr(pt(Samp[In_St4]).sgm,
    pt(Samp[In_St4]).ofs);
    i4     := pt(inst4);
    in4l   := Sam_l[In_St4];
    in4p   := 0;
    notvol4 := Sam_vol[In_St4];
    Pnk4   := 0;
  end;
 if Rm_Song[mli,1,3] and $0F <= 15
 then begin;
   case (Rm_Song[mli,1,3] and $0F) of
      01 : begin;
             PermUp_1 := 1;
           end;
      02 : begin;
             PermDo_1 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,1,4];
			     end;
      12 : begin;
             notvol1 := Notenvolumen(1);
           end;
      15 : begin;
             idx := Rm_Song[mli,1,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
  if Rm_Song[mli,2,3] and $0F <= 15
  then begin;
   case (Rm_Song[mli,2,3] and $0F) of
      01 : begin;
             PermUp_2 := 1;
           end;
      02 : begin;
             PermDo_2 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,2,4];
			     end;
      12 : begin;
             notvol2 := Notenvolumen(2);
           end;
      15 : begin;
             idx := Rm_Song[mli,2,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
  if Rm_Song[mli,3,3] and $0F <= 15
  then begin;
   case (Rm_Song[mli,3,3] and $0F) of
      01 : begin;
             PermUp_3 := 1;
           end;
      02 : begin;
             PermDo_3 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,3,4];
			     end;
      12 : begin;
             notvol3 := Notenvolumen(3);
           end;
      15 : begin;
             idx := Rm_Song[mli,3,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
  if Rm_Song[mli,4,3] and $0F <= 15
  then begin;
   case (Rm_Song[mli,4,3] and $0F) of
      01 : begin;
             PermUp_4 := 1;
           end;
      02 : begin;
             PermDo_4 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,4,4];
			     end;
      12 : begin;
             notvol4 := Notenvolumen(4);
           end;
      15 : begin;
             idx := Rm_Song[mli,4,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
end;

procedure nmw_all_8;
var idx : byte;
begin;
   inc(mli);
   if mli > 64 then mli := 1;
   if mli = 1 then begin;
     inc(mlj);
     if mlj > Liedlaenge then begin;
       if mloop then begin;
         mlj := 1;
         Modp := Addr(Rm_Song);
         memmovew(pt(rm[lied[mlj]]),
         pt(Modp),1024);
       end else begin;
         asm
           call [periodisch_anhalten]
         end;
         music_aus := true;
       end;
     end else begin;
         Modp := Addr(Rm_Song);
         memmovew(pt(rm[lied[mlj]]),
         pt(Modp),1024);
     end;
   end;
  note1 := (Rm_Song[mli,1,1] AND $F0)+
   ((Rm_Song[mli,1,3] AND $F0) shr 4);
  note2 := (Rm_Song[mli,2,1] AND $F0)+
   ((Rm_Song[mli,2,3] AND $F0) shr 4);
  note3 := (Rm_Song[mli,3,1] AND $F0)+
   ((Rm_Song[mli,3,3] AND $F0) shr 4);
  note4 := (Rm_Song[mli,4,1] AND $F0)+
   ((Rm_Song[mli,4,3] AND $F0) shr 4);
  note5 := (Rm_Song[mli,5,1] AND $F0)+
   ((Rm_Song[mli,5,3] AND $F0) shr 4);
  note6 := (Rm_Song[mli,6,1] AND $F0)+
   ((Rm_Song[mli,6,3] AND $F0) shr 4);
  note7 := (Rm_Song[mli,7,1] AND $F0)+
   ((Rm_Song[mli,7,3] AND $F0) shr 4);
  note8 := (Rm_Song[mli,8,1] AND $F0)+
   ((Rm_Song[mli,8,3] AND $F0) shr 4);
  if note1 <> 0 then
   begin;
    Noten_Anschlag[1] := 500;
    In_St1  := note1;
    inst1  := Ptr(pt(Samp[In_St1]).sgm,
    pt(Samp[In_St1]).ofs);
    i1     := pt(inst1);
    in1l   := Sam_l[In_St1];
    in1p   := 0;
    notvol1 := Sam_vol[In_St1];
    Pnk1   := 0;
  end;
  if note2 <> 0 then
   begin;
    Noten_Anschlag[2] := 500;
    In_St2  := note2;
    inst2  := Ptr(pt(Samp[In_St2]).sgm,
    pt(Samp[In_St2]).ofs);
    i2     := pt(inst2);
    in2l   := Sam_l[In_St2];
    in2p   := 0;
    notvol2 := Sam_vol[In_St2];
    Pnk2  := 0;
  end;
  if note3 <> 0 then
   begin;
    Noten_Anschlag[3] := 500;
    In_St3  := note3;
    inst3  := Ptr(pt(Samp[In_St3]).sgm,
    pt(Samp[In_St3]).ofs);
    i3     := pt(inst3);
    in3l   := Sam_l[In_St3]-500;
    in3p   := 0;
    notvol3 := Sam_vol[In_St3];
    Pnk3   := 0;
  end;
  if note4 <> 0 then
   begin;
    Noten_Anschlag[4] := 500;
    In_St4  := note4;
    inst4  := Ptr(pt(Samp[In_St4]).sgm,
    pt(Samp[In_St4]).ofs);
    i4     := pt(inst4);
    in4l   := Sam_l[In_St4];
    in4p   := 0;
    notvol4 := Sam_vol[In_St4];
    Pnk4   := 0;
  end;
  if note5 <> 0 then
   begin;
    Noten_Anschlag[5] := 500;
    In_St5  := note5;
    inst5  := Ptr(pt(Samp[In_St5]).sgm,
    pt(Samp[In_St5]).ofs);
    i5     := pt(inst5);
    in5l   := Sam_l[In_St5];
    in5p   := 0;
    notvol5 := Sam_vol[In_St5];
    Pnk5   := 0;
  end;
  if note6 <> 0 then
   begin;
    Noten_Anschlag[6] := 500;
    In_St6  := note6;
    inst6  := Ptr(pt(Samp[In_St6]).sgm,
    pt(Samp[In_St6]).ofs);
    i6     := pt(inst6);
    in6l   := Sam_l[In_St6];
    in6p   := 0;
    notvol6 := Sam_vol[In_St6];
    Pnk6   := 0;
  end;
  if note7 <> 0 then
   begin;
    Noten_Anschlag[7] := 500;
    In_St7  := note7;
    inst7  := Ptr(pt(Samp[In_St7]).sgm,
    pt(Samp[In_St7]).ofs);
    i7     := pt(inst7);
    in7l   := Sam_l[In_St7];
    in7p   := 0;
    notvol7 := Sam_vol[In_St7];
    Pnk7   := 0;
  end;
  if note8 <> 0 then
   begin;
    Noten_Anschlag[8] := 500;
    In_St8  := note8;
    inst8  := Ptr(pt(Samp[In_St8]).sgm,
    pt(Samp[In_St8]).ofs);
    i8     := pt(inst8);
    in8l   := Sam_l[In_St8];
    in8p   := 0;
    notvol8 := Sam_vol[In_St8];
    Pnk8   := 0;
  end;
 if Rm_Song[mli,1,3] and $0F <= 15
 then begin;
   case (Rm_Song[mli,1,3] and $0F) of
      01 : begin;
             PermUp_1 := 1;
           end;
      02 : begin;
             PermDo_1 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,1,4];
			     end;
      12 : begin;
             notvol1 := Notenvolumen(1);
           end;
      15 : begin;
             idx := Rm_Song[mli,1,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
  if Rm_Song[mli,2,3] and $0F <= 15
  then begin;
   case (Rm_Song[mli,2,3] and $0F) of
      01 : begin;
             PermUp_2 := 1;
           end;
      02 : begin;
             PermDo_2 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,2,4];
			     end;
      12 : begin;
             notvol2 := Notenvolumen(2);
           end;
      15 : begin;
             idx := Rm_Song[mli,2,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
  if Rm_Song[mli,3,3] and $0F <= 15 then begin;
   case (Rm_Song[mli,3,3] and $0F) of
      01 : begin;
             PermUp_3 := 1;
           end;
      02 : begin;
             PermDo_3 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,3,4];
			     end;
      12 : begin;
             notvol3 := Notenvolumen(3);
           end;
      15 : begin;
             idx := Rm_Song[mli,3,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
  if Rm_Song[mli,4,3] and $0F <= 15
  then begin;
   case (Rm_Song[mli,4,3] and $0F) of
      01 : begin;
             PermUp_4 := 1;
           end;
      02 : begin;
             PermDo_4 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,4,4];
			     end;
      12 : begin;
             notvol4 := Notenvolumen(4);
           end;
      15 : begin;
             idx := Rm_Song[mli,4,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
 if Rm_Song[mli,5,3] and $0F <= 15
 then begin;
   case (Rm_Song[mli,5,3] and $0F) of
      01 : begin;
             PermUp_5 := 1;
           end;
      02 : begin;
             PermDo_5 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,5,4];
			     end;
      12 : begin;
             notvol5 := Notenvolumen(5);
           end;
      15 : begin;
             idx := Rm_Song[mli,5,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
  if Rm_Song[mli,6,3] and $0F <= 15
  then begin;
   case (Rm_Song[mli,6,3] and $0F) of
      01 : begin;
             PermUp_6 := 1;
           end;
      02 : begin;
             PermDo_6 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,6,4];
			     end;
      12 : begin;
             notvol6 := Notenvolumen(6);
           end;
      15 : begin;
             idx := Rm_Song[mli,6,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
  if Rm_Song[mli,7,3] and $0F <= 15
  then begin;
   case (Rm_Song[mli,7,3] and $0F) of
      01 : begin;
             PermUp_7 := 1;
           end;
      02 : begin;
             PermDo_7 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,7,4];
			     end;
      12 : begin;
             notvol7 := Notenvolumen(7);
           end;
      15 : begin;
             idx := Rm_Song[mli,7,4];
             if idx < 32 then begin;
               Aktspeed := idx;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
  if Rm_Song[mli,8,3] and $0F <= 15
  then begin;
   case (Rm_Song[mli,8,3] and $0F) of
      01 : begin;
             PermUp_8 := 1;
           end;
      02 : begin;
             PermDo_8 := 1;
           end;
      13 : begin;
			       mli := 64;
			     end;
      11 : begin;
			       mli := 64;
						 mlj := Rm_Song[mli,8,4];
			     end;
      12 : begin;
             notvol8 := Notenvolumen(8);
           end;
      15 : begin;
             idx := Rm_Song[mli,8,4];
             if idx < 32 then begin;
               modmultiply  :=
                ModPara[idx].mult;
               Speed        :=
                ModPara[idx].Speed;
               blockgroesse :=
                ModPara[idx].bgr;
               Dma_abbruch  :=
                ModPara[idx].Ab;
             end;
			     end;
    end;
  end;
end;

procedure initialisiere_vermischen;
begin;
  ziel := pt(blk);
  asm
    call [vermische_proc]
  end;
end;

FUNCTION ConvertString(Source : Pointer; Size : BYTE):String;
VAR
   WorkStr : String;
BEGIN
   Move(Source^,WorkStr[1],Size);
   WorkStr[0] := CHR(Size);
   ConvertString := WorkStr;
END;

function init_Song : boolean;
var rmod      : file;
    sgr       : word;
    { Grî·e eines Sampels }
    inststart : longint;
    { Position in Datei, wo Sampledaten
      starten }
    datgr     : longint;
    { Die Grî·e der MOD - Datei }
    Mkg       : array[1..4] of char;
    { fÅr Modtyp - Erkennung  }
    hilfsp    : ^byte;
    strptr    : pointer;
begin;
 In_St1 := 0;
 In_St2 := 0;
 In_St3 := 0;
 In_St4 := 0;
 In_St5 := 0;
 In_St6 := 0;
 In_St7 := 0;
 In_St8 := 0;
 getmem(blk,8000);
 { Speicher fÅr Datenpuffer reservieren }
 for mlj := 0 to 128 do
   Lied[mlj] := 0;
 {$I-}
 assign(rmod,Mod_Name);
 reset(rmod,1);
 {$I+}
 if IOresult <> 0 then begin;
   init_song := false;
   exit;
 end;
 datgr := filesize(rmod);
 inststart := datgr;
 for mlj := 1 to 31 do begin;
  seek(rmod,42+(mlj-1)*30);
  blockread(rmod,sgr,2);
  sgr := swap(sgr) * 2;
  if sgr <> 0 then inststart :=
   inststart - sgr;
  Sam_l[mlj] := sgr;
  seek(rmod,45+(mlj-1)*30);
  blockread(rmod,Sam_vol[mlj],1);
  blockread(rmod,loop_s[mlj],2);
  blockread(rmod,loop_l[mlj],2);
  loop_s[mlj] := swap(loop_s[mlj])*2;
  loop_l[mlj] := swap(loop_l[mlj])*2;
 end;
 seek(rmod,1080);
 blockread(rmod,Mkg,4);
 if ((Mkg[1] = '8') AND (Mkg[2] = 'C'))
 AND ((Mkg[3] = 'H') AND (Mkg[4] = 'N'))
 then begin     { 8- Stimmige MOD-Datei }
   Pattgroesse    := 2048;
   Stimmen        := 8;
   Vermische_Proc := @vermische_start_8;
   nmw_Proc       := @nmw_all_8;
   innen_proc     := @innen_schleife_8n;
 end else begin;{ 4-Stimmige MOD-Datei }
   Pattgroesse    := 1024;
   Stimmen        := 4;
   Vermische_Proc := @vermische_start_4;
   nmw_Proc       := @nmw_all_4;
   innen_proc     := @innen_schleife_4;
 end;
 seek(rmod,inststart);
 for mlj := 1 to 31 do begin;
   getmem(Samp[mlj],Sam_l[mlj]);
   blockread(rmod,Samp[mlj]^,sam_l[mlj]);
 end;

 datgr := inststart - 1083;
 pat_anz := datgr div Pattgroesse;
 for mlj := 0 to pat_anz-1 do begin;
   getmem(rm[mlj],2048);
   fillchar(rm[mlj]^,2048,0);
   seek(rmod,1084+mlj*Pattgroesse);
   hilfsp := ptr(seg(rm[mlj]^),
   ofs(rm[mlj]^));
   for mli := 0 to 63 do begin;
     hilfsp := ptr(seg(rm[mlj]^),
     ofs(rm[mlj]^)+mli*32);
  	 blockread(rmod,hilfsp^,Pattgroesse
     div 64);
   end;
 end;
 seek(rmod,952);
 blockread(rmod,Lied,128);
 getmem(strptr,25);
 for i := 0 to 30 do begin;
   seek(rmod,20+i*30);
   blockread(rmod,strptr^,22);
   instnamen[i+1] :=
   convertstring(strptr,22);
 end;
 seek(rmod,0);
 blockread(rmod,strptr^,20);
 songname := convertstring(strptr,20);
 seek(rmod,950);
 blockread(rmod,Liedlaenge,1);
 freemem(strptr,25);
 mlj := 0;
 mli := 0;
 close(rmod);
 init_song := true;
end;

procedure exit_song;
begin;
 Port[dsp_adr+$C] := $D3;
 halt(0);
end;

procedure Free_Soundmem;
begin;
 if music_played then begin;
   freemem(blk,8000);
   for mlj := 0 to pat_anz-1 do begin;
     freemem(rm[mlj],2048);
   end;
 end;
end;

procedure init_sbperiod(p : pointer);
begin;
  periodisch_anhalten := p;
end;

procedure mod_SetLoopflag(loopen
: boolean);
begin;
 mloop := loopen;
end;

procedure mod_SetMultiply(msm : word);
begin;
 modmultiply := msm;
end;

procedure mod_SetLoop(msl : word);
begin;
 Sound_Schleifen := msl;
 loop3 := msl;
end;

procedure mod_SetSpeed(msp : word);
begin;
 speed := msp;
 Speed3 := msp;
end;

procedure mod_transpose(transposerwert
: integer);
begin;
  tpw := transposerwert;
end;

procedure init_data;
begin;
 m_played := false;
 In_St1 := 0;
 In_St2 := 0;
 In_St3 := 0;
 In_St4 := 0;
 In_St5 := 0;
 In_St6 := 0;
 In_St7 := 0;
 In_St8 := 0;
end;

procedure init_Paramtable;
var ls : byte;
    h : real;
begin;
  for ls := 1 to 31 do begin;
    ModPara[ls].mult := 125{90+((ls)*2)};
    ModPara[ls].Speed := ls*ModPara[ls].
     mult div 10;
    ModPara[ls].bgr := ModPara[ls].Speed
     *Sound_Schleifen;
    h := Sampling_Frequenz / ModPara[ls].
     bgr;
    ModPara[ls].Ab :=
     round((timer_per_second/h) * 0.9);
   end;
end;

procedure mod_Samplefreq(Rate : integer);
var h : real;
begin;
  Speed := 66;
  case Rate of
     08 : begin;
            Sampling_Rate := 131;
            set_timeconst_sb16(131);
            mod_transpose(1);
            mod_SetLoop(15);
            blockgroesse := Speed *
             Sound_Schleifen;
            Sampling_Frequenz := 8000;
            h := Sampling_Frequenz /
             blockgroesse;
            Dma_abbruch := round((
             timer_per_second/h) * 0.9);
            init_Paramtable;
          end;
     10 : begin;
            Sampling_Rate := 156;
            set_timeconst_sb16(156);
            mod_transpose(5);
            mod_SetLoop(19);
            blockgroesse := Speed *
             Sound_Schleifen;
            Sampling_Frequenz := 10000;
            h := Sampling_Frequenz /
             blockgroesse;
            Dma_abbruch := round((
             timer_per_second/h) * 0.9);
            init_Paramtable;
          end;
     13 : begin;
            Sampling_Rate := 181;
            set_timeconst_sb16(181);
            mod_transpose(10);
            mod_SetLoop(25);
            blockgroesse := Speed *
             Sound_Schleifen;
            Sampling_Frequenz := 13333;
            h := Sampling_Frequenz /
             blockgroesse;
            Dma_abbruch := round((
             timer_per_second/h) * 0.9);
            init_Paramtable;
          end;
     16 : begin;
            Sampling_Rate := 196;
            set_timeconst_sb16(196);
            mod_transpose(14);
            mod_SetLoop(32);
            blockgroesse := Speed *
             Sound_Schleifen;
            Sampling_Frequenz := 16666;
            h := Sampling_Frequenz /
             blockgroesse;
            Dma_abbruch := round((
             timer_per_second/h) * 0.9);
            init_Paramtable;
          end;
     22 : begin;
            Sampling_Rate := 211;
            set_timeconst_sb16(211);
            mod_transpose(19);
            mod_SetLoop(42);
            blockgroesse := Speed *
             Sound_Schleifen;
            Sampling_Frequenz := 22222;
            h := Sampling_Frequenz /
             blockgroesse;
            Dma_abbruch := round((
             timer_per_second/h) * 0.9);
            init_Paramtable;
          end;
   end;
end;

procedure gsreg; assembler;
asm
 mov gax,ax
 mov gbx,bx
 mov gcx,cx
 mov gdx,dx
 mov gsi,si
 mov gdi,di
 mov ax,es
 mov ges,ax
 mov ax,ds
 mov gds,ax
end;

procedure grreg; assembler;
asm
 mov bx,gbx
 mov cx,gcx
 mov dx,gdx
 mov si,gsi
 mov di,gdi
 mov ax,ges
 mov es,ax
 mov ax,gds
 mov ds,ax
 mov ax,gax
end;

{$F+}
procedure Sound_handler;
begin;
 if mycli <> 0 then exit;
 mycli := 1;
 inc(Loop_pos);
 if (Loop_pos > Speed) then begin;
   if dma_Zaehler >= dma_abbruch
   then begin;
     dma_Zaehler := 0;
     if phase_1 then begin;
        dsp_block_sb16;
        phase_1 := false;
        phase_2 := true;
        Loop_pos := 0;
     end;
   end;
   if phase_2 then begin;
     asm
       call [nmw_proc]
     end;
     Initialisiere_Vermischen;
     phase_2 := false;
     phase_1 := true;
   end;
 end else begin;
 if Noten_Anschlag[1] > 1 then
   dec(Noten_Anschlag[1]);
 if Noten_Anschlag[2] > 1 then
   dec(Noten_Anschlag[2]);
 if Noten_Anschlag[3] > 1 then
   dec(Noten_Anschlag[3]);
 if Noten_Anschlag[4] > 1 then
   dec(Noten_Anschlag[4]);
 if Noten_Anschlag[5] > 1 then
   dec(Noten_Anschlag[5]);
 if Noten_Anschlag[6] > 1 then
   dec(Noten_Anschlag[6]);
 if Noten_Anschlag[7] > 1 then
   dec(Noten_Anschlag[7]);
 if Noten_Anschlag[8] > 1 then
   dec(Noten_Anschlag[8]);
   asm
     call [innen_proc]
   end;
 end;
 mycli := 0;
end;
{$F-}

{$F+}
procedure calculate_music; assembler;
asm
 cmp mycli,0
 jne  @ende_stop
 cmp  music_aus,0
 jne   @ende_stop
 call gsreg
 call Sound_handler
 call grreg
 @ende_stop:
end;
{$F-}

procedure mod_waitretrace;
var dl : integer;
begin;
 dl := 1;
 while (dl <= 30) or (waitret_flag < frames) do begin;
   calculate_music;
   inc(dl);
 end;
 in_retrace := true;
 waitret_flag := 0;
asm
  push dx
@l1:
  mov dx,3dah
  in al,dx
  and al,8h
  jnz @l1
@l2:
  mov dx,3dah
  in al,dx
  and al,8h
  jz @l2
  pop dx
End;
 in_retrace := false;
end;

procedure StelleTimerEin(Proc : pointer;
 Freq : word);
{
 Der Timer wird so umprogrammiert, da· er
 mit der Åbergebenen Frequenz die in Proc
 Åbergebene Procedur aufruft. Der alte
 Timerinterrupt wird auf INT $71 verbogen
}
var izaehler : word;
    oldv : pointer;
begin;
 asm cli end;
 izaehler := 1193180 DIV Freq;
 Port[$43] := $36;
 Port[$40] := Lo(IZaehler);
 Port[$40] := Hi(IZaehler);
 Getintvec(8,OldV);
 setintvec(OldTimerInt,OldV);
 SetIntVec(8,Proc);
 old_tZaehler := 1;
 dma_zaehler := 0;
 seczaehler  := 0;
 Timerzaehler := timer_per_second div 18;
 asm sti end;
end;

procedure StelleTimerAus;
{
 Stellt den Urzustand des Timers her
}
var oldv : pointer;
begin;
  asm cli end;
  port[$43] := $36;
  Port[$40] := 0;
  Port[$40] := 0;
  GetIntVec(OldTimerInt,OldV);
  SetIntVec(8,OldV);
  asm sti end;
end;

procedure NeuerTimer; interrupt;
{
 Unser neuer Timer-Interrupt
}
var dummyreg : registers;
begin;
 syreg;
 inc(waitret_flag);
 inc(Dma_Zaehler);
 inc(Seczaehler);
 dec(Timerzaehler);
 if Seczaehler = timer_per_second
 then begin;
   Seczaehler := 0;
   inc(Laufsec);
   if Laufsec = 60 then begin;
     inc(Laufmin);
     Laufsec := 0;
   end;
 end;
 if Timerzaehler = 0 then begin;
   Timerzaehler := timer_per_second
   div 18;
   intr(OldTimerInt,dummyreg);
 end;
 if not in_retrace then calculate_Music;
 Port[$20] := $20;
 ryreg;
end;

procedure init_sb;
begin;
  init_sb16;
end;

function Lade_Soundeffekt(s : string;
var ef : effect_type) : integer;
var efi : file;
begin;
  assign(efi,s);
  reset(efi,1);
  {$I+}
  if IOResult <> 0 then begin;
    {$I-}
    Lade_Soundeffekt := -1;
    exit;
  end;
  {$I-}
  ef.l := filesize(efi);
  getmem(ef.p,ef.l);
  blockread(efi,ef.p^,ef.l);
  close(efi);
  Playeffect := false;
  Lade_Soundeffekt := 0;
end;

procedure dispose_Soundeffekt(ef
: effect_type);
begin;
  freemem(ef.p,ef.l);
end;

procedure Starte_Soundeffekt(ef:
effect_type;frequenz,Vol,styp : word);
{
 Startet den Soundeffekt
}
var realwert : real;
begin;
  effektgroesse := ef.l;
  realwert := frequenz/Sampling_frequenz;
  Effvk    := trunc(realwert);
  Effnk    := round((realwert-Effvk)*100);
  Effekt   := pt(ef.p);
  Effistvk := Effekt.ofs;
  Effistnk := 0;
  Effektposi := 0;
  effectvolume := vol;
  converteff   := styp;
  Playeffect := true;
end;

function lade_moddatei(modname : string;
 ispeed,iloop : integer) : integer;
{
 LÑd die Moddatei. Returnwerte:
  -2 Wenn Datei nicht gefunden
  -1 Wenn Initialisierung fehlerhaft
   0 Wenn alles O.K.
}
var df : file;
    fgr : longint;
begin;
 wr_dsp_sb16($D0);
 Mod_Name := modname;
 assign(df,Mod_name);
 reset(df,1);
 {$I+}
 if IOResult <> 0 then begin;
   {$I-}
   close(df);
   lade_moddatei := -2;
   exit;
 end;
 {$I-}
 fgr := filesize(df);
 close(df);
 music_played := true;
 music_aus := false;
 if ispeed <> AUTO then Speed3 := ispeed;
 if iloop <> AUTO then Loop3  := iloop;
 init_data;
 if init_song then begin;
   phase_1 := false;
   phase_2 := true;
   mycli := 0;
   asm call [nmw_proc] end;
{   Speed := Speed3;
   Sound_Schleifen := loop3;}
   set_timeconst_sb16(Sampling_Rate);
   Initialisiere_Vermischen;
   Laufsec := 0;
   Laufmin := 0;
   wr_dsp_sb16($D1);
   Lade_Moddatei := 0;
 end else begin;
   Lade_Moddatei := -1;
 end;
end;

procedure ende_mod;
{
 Beendet MOD-Ausgabe
}
var mlj : integer;
begin;
Free_Soundmem;
 for mlj := 1 to 31 do begin;
   freemem(Samp[mlj],Sam_l[mlj]);
 end;
mod_terminated := true;
end;

Procedure periodisch_on;
{
 Schaltet das Abspielen der MOD-Datei
 ein.
}
Begin
  init_sbperiod(@periodisch_off);
  music_played := true;
  dma_zaehler := 0;
  StelleTimerEin(@NeuerTimer,
  timer_per_second);
End;

Procedure periodisch_off;
{
 Schaltet das Abspielen der MOD-Datei
 wieder aus
}
Begin
  StelleTimerAus;
End;

{$F+}
procedure MODExitProc;
var mlj : byte;
begin
 ExitProc := SaveExitProc;
 if music_played then periodisch_off;
 if not mod_terminated and music_played
 then ende_mod;
 Exit_Sb16;
end;
{$F-}

begin;
 SaveExitProc := ExitProc;
 ExitProc := @MODExitProc;
 dsp_rdy_sb16 := true;
 dma_zaehler := 0;
 mod_terminated := false;
 music_played := false;
 mloop := true;
 songname := '                    ';
 liedlaenge := 1;
 for mli := 1 to 31 do begin;
   instnamen[mlj] := '                      ';
   Sam_l[mli] := 0;
   Loop_s[mlj] := 0;
   Loop_l[mlj] := 0;
 end;
 for mli := 1 to 31 do Sam_vol[mli] := 64;
 mli := 0;
 mlj := 0;
 tpw := 5;
 In_St1 := 0;
 In_St2 := 0;
 In_St3 := 0;
 In_St4 := 0;
 In_St5 := 0;
 In_St6 := 0;
 In_St7 := 0;
 In_St8 := 0;
 loop_pos := 0;
 modmultiply := 20;
 Sound_Schleifen := 10;
 Noten_Anschlag[1] := 0;
 Noten_Anschlag[2] := 0;
 Noten_Anschlag[3] := 0;
 Noten_Anschlag[4] := 0;
 Noten_Anschlag[5] := 0;
 Noten_Anschlag[6] := 0;
 Noten_Anschlag[7] := 0;
 Noten_Anschlag[8] := 0;
end.


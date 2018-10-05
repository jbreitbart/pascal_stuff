UNIT SBAPI;

INTERFACE

USES SBDRV,DOS;

TYPE SoundRec = RECORD
		 SoundData : Pointer;
		 SndLen    : Word;
		 IsPlaying : ^Integer;
		 Frequency : Integer;
		END;
   
VAR SBAvailable : BOOLEAN;

PROCEDURE PlaySound(VAR TheSound : SoundRec);
FUNCTION SoundPlaying : BOOLEAN ;
FUNCTION AudioPendingStatus : INTEGER;
PROCEDURE MassageAudio(VAR TheSound : SoundRec);
PROCEDURE PlayMassagedAudio(VAR TheSound : SoundRec);
PROCEDURE StopSound;
PROCEDURE PostSound(VAR TheSound : SoundRec; VAR Result : INTEGER);
FUNCTION DetectBlaster(VAR PortBase,IRQ : Word)  : BOOLEAN;
procedure playsnd(Datei : String;Fre : Word);

IMPLEMENTATION

{ Save vector for INT 66h If SoundBlaster driver load fails }
CONST DummyISR : Word = $CF; {IRET}
      

VAR 
  TIrq,ThePort : Word;
      SaveExit : Pointer;
    Orig66Vec  : Pointer;

{$F+}
Procedure SBApiExitProc;  
  BEGIN
    If SBAvailable THEN 
       UnLoadSoundDriver
    ELSE
      SetIntVec($66,Orig66Vec);
    EXITPROC := SaveExit;
  END;
{$F-}




{$L SBDETECT.OBJ}
FUNCTION DetectBlaster(VAR PortBase,IRQ : Word) : Boolean; external;


{Function #1: DigPlay, Play an 8 bit digitized sound.

	INPUT:  AX = 688h    Command number.
		DS:SI        Point to a sound structure that
			     describes the sound effect to be played.}


PROCEDURE PlaySound(VAR TheSound : SoundRec); assembler;

   Asm
     PUSH DS
     PUSH SI
     LDS SI, TheSound
     MOV AX, $688
     INT $66
     POP SI
     POP DS
  End;


{       INPUT:  AX = 689h
	OUTPUT: AX = 0       No sound is playing.
		   = 1       Sound effect currently playing.
		DX = 0       No sound is looping.
		   = 1       A sound effect is looping.
		BX = version Starting with version 3.1, the BX register
			     of the SoundStatus call will return the
			     version number.  The version number is in
			     decimal, and multiplied times 100.  Meaning
			     a return of 310, is equal to version 3.10.
			     Versions before 3.1, did not set the BX
			     register to anything, so you should zero
			     out the BX register before you check the
			     version number.  If the BX register is still
			     zero, then the DigPak driver loaded is less
			     than 3.1. }


FUNCTION SoundPlaying : BOOLEAN ; assembler;

  Asm
    MOV AX,$0689
    INT $66
  End;


{ Function #3: MassageAudio, Preformat audio data into output hardware format.

	INPUT:  AX = 68Ah
		DS:SI        Point to address of sound structure. }

PROCEDURE MassageAudio(VAR TheSound : SoundRec); assembler;
								  
  Asm
   PUSH DS
   PUSH SI
   LDS SI , TheSound
   MOV AX, $068A
   INT $66
   POP SI
   POP DS
  End;

{ Function #4: DigPlay2, Play preformatted audio data.

	INPUT:  AX = 68Bh
		DS:SI        Point to address of sound structure.}

PROCEDURE PlayMassagedAudio(VAR TheSound : SoundRec); assembler;

  Asm
   PUSH DS
   PUSH SI
   LDS SI , TheSound
   MOV AX, $068B
   INT $66
   POP SI
   POP DS
  End;

{Function #8: StopSound, stop currently playing sound.

	INPUT: AX = 68Fh
	OUTPUT: None.

	      Will cause any currently playing sound effect to be
	      terminated. }

PROCEDURE StopSound; assembler;

  Asm
   MOV AX, $68F
   INT $66
  End;

{FUNCTION #14: PostAudioPending

	INPUT: AX = 695h
	       DS:SI -> sound structure, preformated data.

	OUTPUT: AX = 0  Sound was started playing.
		AX = 1  Sound was posted as pending to play.
		AX = 2  Already a sound effect pending, this one not posted.}


PROCEDURE PostSound(VAR TheSound : SoundRec; VAR Result : INTEGER); assembler;

   Asm
    PUSH DS
    PUSH SI
    PUSH ES
    PUSH DI
    MOV AX, $0695
    LDS SI, TheSound
    INT $66
    LES DI,Result
    STOSW           { Pass the outcome in the AX register back to Result}
    POP DI
    POP ES
    POP SI
    POP DS
   End;


{FUNCTION #15: AudioPendingStatus

	INPUT:  AX = 696h

	OUTPUT: AX = 0 No sound is playing.
		AX = 1 Sound playing, sound pending.
		AX = 2 Sound playing, no sound pending. }

FUNCTION AudioPendingStatus : INTEGER; assembler;

  Asm
   MOV AX, $0696
   INT $66
  End;

procedure playsnd(Datei : String;Fre : Word);

VAR ASound : SoundRec;
         F : File;
    PSound : Pointer;
    AnInt  : Integer;
    Result1,Result2,More   : integer;
  
BEGIN
 IF SBAvailable THEN BEGIN
  Assign(F,Datei);
  {$I-}
  Reset(F,1);
  {$I+}
  If IOResult<>0 THEN BEGIN
   WriteLn('Error Opening :',Datei);
   Halt;
  END;
  ASound.Frequency := 0;
  If Fre < 100 THEN ASound.Frequency := Fre * 1000;
  If (Fre > 100) and (Fre < 1000) THEN asound.Frequency := Fre * 100;
  if asound.frequency=0 then asound.frequency:=fre;
  if fre=0 then asound.frequency:=23000;
  If FileSize(F) > 65535 THEN BEGIN
  END
  else begin
   GetMem(PSound,FileSize(F));
   BlockRead(F,PSound^,FileSize(F));
   With ASound DO BEGIN
    SoundData := PSound;
    SndLen := FileSize(F);
    IsPlaying := @AnInt;
   END;
   PlaySound(ASound);
   dispose(psound);
  end;
 END;
END;


BEGIN
  { Preserve original int 66H vector }
  GetIntVec($66,Orig66Vec);
  SaveExit := EXITPROC;
  EXITPROC := @SBApiExitProc;

  { If SoundBlaster Detected }
  If DetectBlaster(ThePort,TIrq) THEN
     BEGIN
      { Load the detected Port address and IRQ to the driver code }
       PokeBlaster(ThePort,TIrq);
       SBAvailable := LoadSoundDriver(ReportSB);
     END
  ELSE
    BEGIN
     SBAvailable := FALSE;

     { Set 66h interrupt vector to an IRET so that procedures can be }
     { called with out locking the computer }
     SetIntVec($66,@DummyISR);
    END;

END.

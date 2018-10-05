UNIT SBDRV;

INTERFACE


PROCEDURE PokeBlaster(PortBase,IRQ : Word); 
FUNCTION LoadSoundDriver(DrvAddr : Pointer) : BOOLEAN; 
FUNCTION ReportSB : Pointer;
PROCEDURE UnloadSoundDriver;

IMPLEMENTATION

{$L SBDRIVER.OBJ}
{$L DRVINST.OBJ}

FUNCTION ReportSB : Pointer; external;
PROCEDURE PokeBlaster(PortBase,IRQ : Word); external;
FUNCTION LoadSoundDriver(DrvAddr : Pointer) : BOOLEAN; external;
PROCEDURE UnloadSoundDriver; external;


END.

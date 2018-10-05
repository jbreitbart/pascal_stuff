unit BGI256;

interface

const LineMode   = $00;
		FillMode   = $40;
		TextMode   = $80;
		ImageMode  = $C0;
		BackColor  = 24;

		Mode200    = 0;  {320x200x256}
		Mode400    = 1;  {640x400x256}
		Mode480    = 2;  {640x480x256}
		Mode600    = 3;  {800x600x256}
		Mode768    = 4;  {1024x768x256}
		Mode1024   = 5;  {2048x1024x256}

		driver: integer = 0;
		mode: integer = 0;
		result: integer = 0;

implementation

uses Graph;

procedure BGI256DriverProc; external;
{$L BGI256.OBJ }

function BGI256Detect: integer;
begin
  BGI256Detect := 0;  {Autodetect the mode}
end;

begin
	driver:=InstallUserDriver('BGI256',nil);
        mode:=0;
	InitGraph(driver, mode, '');
	result:=GraphResult;
	if result<>grOK then
	begin
		writeln(GraphErrorMsg(result));
		halt(1)
	end;
	setGraphMode(getMaxMode);
end.

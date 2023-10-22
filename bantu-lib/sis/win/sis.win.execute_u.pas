unit sis.win.execute_u;

interface

uses sis.win.execute, sis.sis.executavel_u, ShellApi, windows,
  sis.ui.io.output;

type
  TWinExecute = class(TExecutavel, IWinExecute)
  private
    SEInfo: TShellExecuteInfo;
    FExecuteFile, FParams, FStartIn: string;
    FExecuteAoCriar: boolean;
    FShowMode: integer;

  public
    function Executando:boolean;
    function Execute: boolean; override;
    constructor Create(
      pExecuteFile, pParams, pStartIn: string;
      pExecuteAoCriar: boolean;
      pShowMode: integer;
      pOutput: IOutput=nil
      );
  end;

implementation

uses Vcl.Forms;

{ TWinExecute }

constructor TWinExecute.Create(pExecuteFile, pParams, pStartIn: string;
  pExecuteAoCriar: boolean; pShowMode: integer; pOutput: IOutput);
var
  pApplicationHandle: HWnd;
begin
  inherited Create(pOutput);

  pApplicationHandle:=Application.Handle;
  FExecuteAoCriar := pExecuteAoCriar;

  FExecuteFile := pExecuteFile;
  FParams      := pParams;
  FStartIn     := pStartIn;
  FShowMode    := pShowMode;

  FillChar(SEInfo, SizeOf(SEInfo), 0) ;
  SEInfo.cbSize := SizeOf(TShellExecuteInfo) ;
  with SEInfo do
  begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := pApplicationHandle;
    lpFile := PChar(FExecuteFile) ;
    //lpVerb := PChar('runas') ;
    if FParams<>'' then
      lpParameters := PChar(FParams) ;
    if FStartIn<>'' then
      lpDirectory := PChar(FStartIn) ;
    nShow := pShowMode;
  end;

  if FExecuteAoCriar then
    Execute;
end;

function TWinExecute.Executando: boolean;
var
  ExitCode: DWORD;
begin
  GetExitCodeProcess(SEInfo.hProcess, ExitCode) ;
  Result:=ExitCode=STILL_ACTIVE;
end;

function TWinExecute.Execute: boolean;
begin
  result := ShellExecuteEx(@SEInfo);
end;

end.
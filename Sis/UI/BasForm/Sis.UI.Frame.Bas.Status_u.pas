unit Sis.UI.Frame.Bas.Status_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TStatusFrame = class(TBasFrame)
    TitLabel: TLabel;
    StatusLabel: TLabel;
  private
    { Private declarations }
  protected
  public
    { Public declarations }

//    procedure Terminate; virtual;
//    function PodeFechar: boolean; virtual;
    constructor Create(AOwner: TComponent); override;
  end;

//var
//  StatusFrame: TStatusFrame;

implementation

{$R *.dfm}

uses Sis.UI.IO.Output.ProcessLog.Factory, Sis.UI.IO.Factory;

{ TStatusFrame }

constructor TStatusFrame.Create(AOwner: TComponent);
begin
  inherited;
end;
//
//function TStatusFrame.PodeFechar: boolean;
//begin
//  Result := True;
//end;
//
//procedure TStatusFrame.Terminate;
//begin
//end;

end.
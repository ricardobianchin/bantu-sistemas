unit ShopApp.DB.Import.Form.PLUBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.DB.Import.Form_u, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, App.AppObj, System.Actions, Vcl.ActnList, Vcl.Buttons,
  Sis.UI.IO.Output, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.Controls.Files.FileSelectLabeledEdit.Frame;

type
  TShopDBImportFormPLUBase = class(TDBImportForm)
    MoldeFileSelectPanel: TPanel;
    procedure ExecuteAction_AppDBImportExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FNomeArq: string;
    FFileSelectFrame: TFileSelectLabeledEditFrame;
    FLinhasSL: TStringList;
  protected
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pProcessLog: IProcessLog = nil);
  end;

var
  ShopDBImportFormPLUBase: TShopDBImportFormPLUBase;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TShopDBImportFormPLUBase }

constructor TShopDBImportFormPLUBase.Create(AOwner: TComponent;
  pAppObj: IAppObj; pProcessLog: IProcessLog = nil);
begin
  inherited;
  FFileSelectFrame := TFileSelectLabeledEditFrame.Create(TopoPanel);
  FFileSelectFrame.EditCaption := 'Arquivo PLUBASE.TXT';
  PegueFormatoDe(FFileSelectFrame, MoldeFileSelectPanel);
end;

procedure TShopDBImportFormPLUBase.ExecuteAction_AppDBImportExecute
  (Sender: TObject);
var
  bResultado: boolean;
begin
  inherited;
  StatusOutput.Exibir('Inicio');
  try
    FNomeArq := FFileSelectFrame.NomeArq;

    bResultado := FNomeArq <> '';
    if not bResultado then
    begin
      StatusOutput.ExibirPausa('Erro: Nome do Arquivo e� obrigatorio', TMsgDlgType.mtError);
      Exit;
    end;

    bResultado := FileExists(FNomeArq);
    if not bResultado then
    begin
      StatusOutput.ExibirPausa('Erro: Arquivo nao existe: [' + FNomeArq + ']',
        TMsgDlgType.mtError);
      Exit;
    end;

    FLinhasSL := TStringList.Create;
    try
      FLinhasSL.LoadFromFile(FNomeArq);
      FLinhasSL.Delete(0);
      StatusOutput.Exibir('Qtd linhas: ' + FLinhasSL.Count.ToString);
    finally
      FLinhasSL.Free;
    end;

  finally
    StatusOutput.Exibir('Fim');
    StatusOutput.Exibir('');
  end;
end;

procedure TShopDBImportFormPLUBase.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
{$IFDEF DEBUG}
  FFileSelectFrame.NomeArq := 'X:\Doc\Bantu\Clientes\Daros\PLUBASE.TXT';
  ExecuteAction_AppDBImport.Execute;
{$ENDIF}
end;

end.

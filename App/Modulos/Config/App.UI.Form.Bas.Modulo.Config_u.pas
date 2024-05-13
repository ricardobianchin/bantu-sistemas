unit App.UI.Form.Bas.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus,
  Sis.DB.DBTypes, App.DB.Utils, Sis.DB.Factory, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, Sis.ModuloSistema, App.Sessao.Eventos,
  App.Constants, Sis.Usuario, App.AppObj, Sis.UI.Controls.Utils,
  App.DB.Import.Form_u;

type
  TConfigModuloBasForm = class(TModuloBasForm)
    TopoPanel: TPanel;
    MenuPageControl: TPageControl;
    ImportTabSheet: TTabSheet;
    DBImportOrigemComboBox: TComboBox;
    ImportOrigemTitLabel: TLabel;
    DBImportButton: TButton;
    ConfigActionList: TActionList;
    DBImportAction: TAction;
    procedure DBImportActionExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DBImportPrep; virtual;
    function DBImportFormCreate(pItemIndex: integer): TDBImportForm; virtual; abstract;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pSessaoEventos: ISessaoEventos; pSessaoIndex: TSessaoIndex;
      pUsuario: IUsuario; pAppObj: IAppObj);
  end;

var
  ConfigModuloBasForm: TConfigModuloBasForm;

implementation

{$R *.dfm}
{ TConfigModuloBasForm }

constructor TConfigModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos;
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj);
begin
  inherited Create(AOwner, pModuloSistema, pSessaoEventos, pSessaoIndex,
    pUsuario, pAppObj);
  DBImportPrep;
end;

procedure TConfigModuloBasForm.DBImportActionExecute(Sender: TObject);
var
  iItemIndex: integer;
  iSelectedImportIndex: integer;
  oDBImportForm: TDBImportForm;
begin
  inherited;
  oDBImportForm := DBImportFormCreate(DBImportOrigemComboBox.ItemIndex);
  oDBImportForm.ShowModal;
end;

procedure TConfigModuloBasForm.DBImportPrep;
begin
  DBImportOrigemComboBox.Text := '';
  DBImportOrigemComboBox.Clear;
end;

procedure TConfigModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);

end;

end.

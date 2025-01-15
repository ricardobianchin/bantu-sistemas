unit ShopApp.UI.Form.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo.PDV_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.ModuloSistema,
  App.Sessao.EventosDeSessao, App.Constants, Sis.Usuario, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj, Sis.Entities.Types,
  Sis.Entities.Terminal, App.PDV.Factory_u, App.UI.Form.Menu_u, System.UITypes,
  App.UI.PDV.VendaBasFrame_u, ShopApp.PDV.Venda, ShopApp.PDV.DBI, App.PDV.Venda,
  Sis.DBI, App.UI.PDV.PagFrame_u, App.PDV.DBI;

type
  TShopPDVModuloForm = class(TPDVModuloBasForm)
    procedure PrecoBuscaAction_PDVModuloBasFormExecute(Sender: TObject);
  private
    { Private declarations }
    FShopPDVVenda: IShopPDVVenda;
    FShopAppPDVDBI: IShopAppPDVDBI;
  protected
    function AppMenuFormCreate: TAppMenuForm; override;
    function PDVVendaCreate: IPDVVenda; override;
    function PDVDBICreate: IAppPDVDBI; override;

    function VendaFrameCreate: TVendaBasPDVFrame; override;
    function PagFrameCreate: TPagPDVFrame; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj;
      pTerminalId: TTerminalId); override;
  end;

var
  ShopPDVModuloForm: TShopPDVModuloForm;

implementation

{$R *.dfm}

uses Sis.DB.Factory, Sis.Sis.Constants, Sis.Sis.Atualizavel //

    , App.PDV.Preco.PrecoBusca.Factory_u //
    , AppShop.PDV.Preco.PrecoBusca.Factory_u //
    , ShopApp.PDV.Factory_u //
    ;

function TShopPDVModuloForm.AppMenuFormCreate: TAppMenuForm;
begin
  Result := inherited;

end;

constructor TShopPDVModuloForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pEventosDeSessao: IEventosDeSessao;
  pSessaoIndex: TSessaoIndex; pLogUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
begin
  inherited;
  // AppMenuForm := AppMenuFormCreate;
end;

function TShopPDVModuloForm.PagFrameCreate: TPagPDVFrame;
begin
  Result := ShopPagPDVFrameCreate(Self, PDVVenda, PDVDBI, Self);
  Result.Visible := False;
end;

function TShopPDVModuloForm.PDVDBICreate: IAppPDVDBI;
begin
  FShopAppPDVDBI := ShopAppPDVDBICreate(TermDBConnection, AppObj, Terminal,
    FShopPDVVenda);

  Result := FShopAppPDVDBI;
end;

function TShopPDVModuloForm.PDVVendaCreate: IPDVVenda;
begin
  FShopPDVVenda := ShopPDVVendaCreate(AppObj.Loja //
    , TerminalId //
    , DATA_ZERADA //
    , DATA_ZERADA //
    , CaixaSessaoDM.CaixaSessao //
    );

  Result := FShopPDVVenda;
end;

procedure TShopPDVModuloForm.PrecoBuscaAction_PDVModuloBasFormExecute
  (Sender: TObject);
var
  rDBConnectionParams: TDBConnectionParams;
  ODBConnection: IDBConnection;
  DBI: IDBI;
begin
  inherited;
  rDBConnectionParams.Server := Terminal.IdentStr;
  rDBConnectionParams.Arq := Terminal.LocalArqDados;
  rDBConnectionParams.Database := Terminal.Database;

  ODBConnection := DBConnectionCreate('App.Preco.Busca.Conn', AppObj.SisConfig,
    rDBConnectionParams, nil, nil);

  DBI := ShopPrecoBuscaDBICreate(ODBConnection, AppObj);

  App.PDV.Preco.PrecoBusca.Factory_u.BuscaPrecoPerg(DBI);
end;

function TShopPDVModuloForm.VendaFrameCreate: TVendaBasPDVFrame;
begin
  Result := ShopVendaPDVFrameCreate(Self, PDVVenda, PDVDBI, Self);
  Result.Visible := False;
end;

end.
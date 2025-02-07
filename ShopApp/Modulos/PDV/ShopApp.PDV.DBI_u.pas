unit ShopApp.PDV.DBI_u;

interface

uses ShopApp.PDV.DBI, App.PDV.DBI_u, ShopApp.PDV.Venda, ShopApp.PDV.VendaItem,
  Sis.DB.DBTypes, App.AppObj, Sis.Terminal, Sis.Types.Floats, Data.DB,
  ShopApp.PDV.Factory_u, App.Est.Venda.Caixa.CaixaSessao,
  ShopApp.PDV.DBI_u_EstMovAdicionador, App.PDV.Obj;

type
  TShopAppPDVDBI = class(TAppPDVDBI, IShopAppPDVDBI)
  private
    FShopPdvVenda: IShopPdvVenda;
    FEstMovAdicionador: TEstMovAdicionador;
    FPDVObj: IPDVObj;

    function RecordToItemCreate(q: TDataSet): IShopPDVVendaItem;
    procedure RecordPreencheVenda(q: TDataSet);

    function GetVendaPendenteSql: string;
    function GetVendaItemPendenteSql: string;
  protected
    procedure InsiraEstItens; override;
  public
    // LEU CODIGO, CRIA ITEM
    function ItemCreatePelaStrBusca(pStrBusca: string; out pEncontrou: Boolean;
      out pMensagem: string): IShopPDVVendaItem;

    // PDV ABRIU, HAVIA VENDA INTERROMPIDA
    procedure CarregueVendaPendente(out pCarregou: Boolean);

    procedure ItemCancelar(pShopPDVVendaItem: IShopPDVVendaItem;
      out pExecutouOk: Boolean; out pMensagem: string);

    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pPDVObj: IPDVObj; pTerminal: ITerminal; pShopPdvVenda: IShopPdvVenda);
    destructor Destroy; override;

  end;

implementation

uses Sis.Win.Utils_u, System.SysUtils, Sis.Entities.Types,
  App.Est.Prod, App.Est.Factory_u, Sis.Sis.Constants, App.Est.Types_u,
  Sis.DB.Factory;

{ TShopAppPDVDBI }

procedure TShopAppPDVDBI.CarregueVendaPendente(out pCarregou: Boolean);
var
  sSql: string;
  q: TDataSet;
begin
  DBConnection.Abrir;
  try

    sSql := GetVendaPendenteSql;

    DBConnection.QueryDataSet(sSql, q);

    pCarregou := Assigned(q);
    if not pCarregou then
      exit;

    pCarregou := not q.IsEmpty;
    if not pCarregou then
      exit;

    pCarregou := q.Fields[0 { HAVIA_PENDENTE } ].AsBoolean;
    if not pCarregou then
      exit;

    try
      RecordPreencheVenda(q);
    finally
      q.Free;
    end;

    InsiraEstItens;
    InsiraPagItens;
  finally
    DBConnection.Fechar;
  end;
end;

constructor TShopAppPDVDBI.Create(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pPDVObj: IPDVObj; pTerminal: ITerminal;
  pShopPdvVenda: IShopPdvVenda);
begin
  inherited Create(pDBConnection, pAppObj, pTerminal, pShopPdvVenda);
  FShopPdvVenda := pShopPdvVenda;
  FPDVObj := pPDVObj;
  FEstMovAdicionador := TEstMovAdicionador.Create(AppObj, pPDVObj, Terminal,
    FShopPdvVenda, DBConnection);
end;

destructor TShopAppPDVDBI.Destroy;
begin
  FEstMovAdicionador.Free;
  inherited;
end;

function TShopAppPDVDBI.GetVendaItemPendenteSql: string;
begin
  Result := //
    'SELECT'#13#10 //

    + '  P.PROD_ID'#13#10 // 0
    + ', P.DESCR_RED'#13#10 // 1
    + ', P.FABR_NOME'#13#10 // 2
    + ', P.UNID_SIGLA'#13#10 // 3
    + ', P.BALANCA_EXIGE'#13#10 // 4
    + ', P.CUSTO'#13#10 // 5
    + ', P.PRECO'#13#10 // 6

    + ', E.ORDEM'#13#10 // 7

    + ', E.QTD'#13#10 // 8

    + ', E.CANCELADO'#13#10 // 9

    + ', E.CRIADO_EM'#13#10 // 10
    + ', E.ALTERADO_EM'#13#10 // 11
    + ', E.CANCELADO_EM'#13#10 // 12

    + ', V.CUSTO_UNIT'#13#10 // 13
    + ', V.CUSTO'#13#10 // 14

    + ', V.PRECO_UNIT_ORIGINAL'#13#10 // 15
    + ', V.PRECO_UNIT_PROMO'#13#10 // 16
    + ', V.PRECO_UNIT'#13#10 // 17
    + ', V.PRECO_BRUTO'#13#10 // 18

    + ', V.DESCONTO'#13#10 // 19
    + ', V.PRECO'#13#10 // 20

    + 'FROM PROD P'#13#10 //

    + 'JOIN EST_MOV_ITEM E ON'#13#10 //
    + 'P.PROD_ID = E.PROD_ID'#13#10 //

    + 'JOIN VENDA_ITEM V ON'#13#10 //
    + 'E.LOJA_ID = V.LOJA_ID'#13#10 //
    + 'AND E.TERMINAL_ID = V.TERMINAL_ID'#13#10 //
    + 'AND E.EST_MOV_ID = V.EST_MOV_ID'#13#10 //
    + 'AND E.ORDEM = V.ORDEM'#13#10 //

    + 'WHERE E.LOJA_ID = ' + FShopPdvVenda.Loja.Id.ToString + #13#10 //
    + 'AND E.TERMINAL_ID = ' + FShopPdvVenda.TerminalId.ToString + #13#10 //
    + 'AND E.EST_MOV_ID = ' + FShopPdvVenda.EstMovId.ToString + #13#10 //

    + 'ORDER BY E.ORDEM;'#13#10 //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

function TShopAppPDVDBI.GetVendaPendenteSql: string;
var
  c: ICaixaSessao;
begin
  c := FShopPdvVenda.CaixaSessao;
  Result := //
    'SELECT'#13#10 //

    + 'HAVIA_PENDENTE'#13#10 // 0

    + ', TERMINAL_ID'#13#10 // 1
    + ', EST_MOV_ID'#13#10 // 2

    + ', EST_MOV_TIPO_ID'#13#10 // 3
    + ', DTH_DOC'#13#10 // 4

    + ', FINALIZADO'#13#10 // 5
    + ', CANCELADO'#13#10 // 6

    + ', CRIADO_EM'#13#10 // 7
    + ', EST_MOV_ALTERADO_EM'#13#10 // 8
    + ', FINALIZADO_EM'#13#10 // 9
    + ', CANCELADO_EM'#13#10 // 10

    + ', VENDA_ID'#13#10 // 11
    + ', C'#13#10 // 12

    + ', CLIENTE_LOJA_ID'#13#10 // 13
    + ', CLIENTE_TERMINAL_ID'#13#10 // 14
    + ', CLIENTE_ID'#13#10 // 15

    + ', ENDERECO_LOJA_ID'#13#10 // 16
    + ', ENDERECO_TERMINAL_ID'#13#10 // 17
    + ', ENDERECO_ID'#13#10 // 18

    + ', DESCONTO_TOTAL'#13#10 // 19
    + ', CUSTO_TOTAL'#13#10 // 20
    + ', TOTAL_LIQUIDO'#13#10 // 21

    + ', ENTREGA_TEM'#13#10 // 22
    + ', ENTREGADOR_PESSOA_ID'#13#10 // 23
    + ', ENTREGA_EM'#13#10 // 24
    + ', VENDA_ALTERADO_EM'#13#10 // 25

    + 'FROM VENDA_PDV_INS_PA.PENDENTE_GET'#13#10 //
    + '('#13#10 //
    + '  ' + c.LojaId.ToString + ' -- SESS_LOJA_ID'#13#10 //
    + '  , ' + c.TerminalId.ToString + ' -- SESS_TERMINAL_ID'#13#10 //
    + '  , ' + c.Id.ToString + ' -- SESS_ID ID_DOM'#13#10 //
    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
end;

procedure TShopAppPDVDBI.InsiraEstItens;
var
  sSql: string;
  q: TDataSet;
  oItem: IShopPDVVendaItem;
  v: IShopPdvVenda;
begin
  v := FShopPdvVenda;

  v.Items.Clear;

  sSql := GetVendaItemPendenteSql;

  DBConnection.QueryDataSet(sSql, q);

  if not Assigned(q) then
    exit;

  try
    while not q.Eof do
    begin
      oItem := RecordToItemCreate(q);
      v.Items.Add(oItem);
      q.Next;
    end;
  finally
    q.Free;
  end;
end;

procedure TShopAppPDVDBI.ItemCancelar(pShopPDVVendaItem: IShopPDVVendaItem;
  out pExecutouOk: Boolean; out pMensagem: string);
var
  sSql: string;
  v: IShopPdvVenda;
  dCanceladoEm: TDateTime;
begin
  v := FShopPdvVenda;

  try
    sSql := //
      'SELECT CANCELADO_EM_RET'#13#10 //
      + 'FROM VENDA_PDV_INS_PA.CANCELAR_EST_MOV_ITEM'#13#10 //
      + '('#13#10 //
      + '  ' + v.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
      + '  , ' + v.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
      + '  , ' + v.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
      + '  , ' + pShopPDVVendaItem.Ordem.ToString + ' -- ORDEM'#13#10 //
      + ');';

    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}

    pExecutouOk := DBConnection.Abrir;
    try
      dCanceladoEm := DBConnection.GetValueDateTime(sSql);

      pShopPDVVendaItem.Cancelado := True;
      pShopPDVVendaItem.CanceladoEm := dCanceladoEm;
      pShopPDVVendaItem.AlteradoEm := dCanceladoEm;
      FShopPdvVenda.AlteradoEm := dCanceladoEm;
      FShopPdvVenda.VendaAlteradoEm := dCanceladoEm;
    finally
      DBConnection.Fechar;
      pExecutouOk := True;
    end;
  except
    on e: Exception do
    begin
      pExecutouOk := False;
      pMensagem := 'Erro ao tentar cancelar item. ' + e.ClassName + ', ' +
        e.Message;
    end;
  end;
end;

function TShopAppPDVDBI.ItemCreatePelaStrBusca(pStrBusca: string;
  out pEncontrou: Boolean; out pMensagem: string): IShopPDVVendaItem;
begin
  Result := FEstMovAdicionador.BuscaProdAddEstMov(pStrBusca, pEncontrou,
    pMensagem);
end;

procedure TShopAppPDVDBI.RecordPreencheVenda(q: TDataSet);
var
  v: IShopPdvVenda;
begin
  v := FShopPdvVenda;

  v.TerminalId := q.Fields[1 { TERMINAL_ID } ].AsInteger;
  v.EstMovId := q.Fields[2 { EST_MOV_ID } ].AsInteger;

  v.EstMovTipo.SetFromString(q.Fields[3 { EST_MOV_TIPO_ID } ].AsString);
  v.DtHDoc := q.Fields[4 { DTH_DOC } ].AsDateTime;

  v.Finalizado := q.Fields[5 { FINALIZADO } ].AsBoolean;
  v.Cancelado := q.Fields[6 { CANCELADO } ].AsBoolean;

  v.CriadoEm := q.Fields[7 { CRIADO_EM } ].AsDateTime;
  v.AlteradoEm := q.Fields[8 { EST_MOV_ALTERADO_EM } ].AsDateTime;
  v.FinalizadoEm := q.Fields[9 { FINALIZADO_EM } ].AsDateTime;
  v.CanceladoEm := q.Fields[10 { CANCELADO_EM } ].AsDateTime;

  v.VendaId := q.Fields[11 { VENDA_ID } ].AsInteger;

  v.c := q.Fields[12 { C } ].AsString;

  v.Cli.PegarCods( //
    q.Fields[13 { CLIENTE_LOJA_ID } ].AsInteger //
    , q.Fields[14 { CLIENTE_TERMINAL_ID } ].AsInteger //
    , q.Fields[15 { CLIENTE_ID } ].AsInteger //
    );

  v.Ender.PegarCods( //
    q.Fields[16 { ENDERECO_LOJA_ID } ].AsInteger //
    , q.Fields[17 { ENDERECO_TERMINAL_ID } ].AsInteger //
    , q.Fields[18 { ENDERECO_ID } ].AsInteger //
    );

  v.DescontoTotal := q.Fields[19 { DESCONTO_TOTAL } ].AsCurrency;
  v.CustoTotal := q.Fields[20 { CUSTO_TOTAL } ].AsCurrency;
  v.TotalLiquido := q.Fields[21 { TOTAL_LIQUIDO } ].AsCurrency;

  v.EntregaTem := q.Fields[22 { ENTREGA_TEM } ].AsBoolean;
  v.EntregadorId := q.Fields[23 { ENTREGADOR_PESSOA_ID } ].AsInteger;
  v.EntregaEm := q.Fields[24 { ENTREGA_EM } ].AsDateTime;
  v.VendaAlteradoEm := q.Fields[25 { VENDA_ALTERADO_EM } ].AsDateTime;
end;

function TShopAppPDVDBI.RecordToItemCreate(q: TDataSet): IShopPDVVendaItem;
var
  oProd: IProd;
begin
  oProd := ProdCreate( //
    q.Fields[0 { PROD_ID } ].AsInteger //
    , q.Fields[1 { DESCR_RED } ].AsString //
    , q.Fields[2 { FABR_NOME } ].AsString //
    , q.Fields[3 { UNID_SIGLA } ].AsString //
    );

  Result := ShopPDVVendaItemCreate( //
    q.Fields[7 { ORDEM_RET } ].AsInteger, oProd //
    , q.Fields[8 { QTD } ].AsCurrency //

    , q.Fields[4 { BALANCA_EXIGE } ].AsBoolean //

    , q.Fields[13 { CUSTO_UNIT } ].AsCurrency //
    , q.Fields[14 { CUSTO } ].AsCurrency //

    , q.Fields[15 { PRECO_UNIT_ORIGINAL } ].AsCurrency //
    , q.Fields[16 { PRECO_UNIT_PROMO } ].AsCurrency //
    , q.Fields[17 { PRECO_UNIT } ].AsCurrency //
    , q.Fields[18 { PRECO_BRUTO } ].AsCurrency //

    , q.Fields[19 { DESCONTO } ].AsCurrency //
    , q.Fields[20 { PRECO_BRUTO } ].AsCurrency //

    , q.Fields[9 { CANCELADO } ].AsBoolean //
    , q.Fields[10 { CRIADO_EM } ].AsDateTime //
    , q.Fields[11 { ALTERADO_EM } ].AsDateTime //
    , q.Fields[12 { CANCELADO_EM } ].AsDateTime //
    );
end;

end.

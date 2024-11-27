unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent_u;

interface

uses Sis.Types.Utils_u, App.Ent.Ed_u, Sis.Entities.Types,
  App.Est.Venda.Caixa.CaixaSessao, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent;

type
  TCxOperacaoEnt = class(TEntEd, ICxOperacaoEnt)
  private
    FLojaId: TLojaId;
    FTerminalId: TTerminalId;
    FCaixaSessao: ICaixaSessao;
    FOperOrdem: SmallInt;
    FCxOperacaoTipo: ICxOperacaoTipo;
    FLogId: Int64;
    FOperTipoOrdem: SmallInt;
    FValor: Currency;
    FObs: string;
    FCancelado: Boolean;

    function GetLojaId: TLojaId;
    procedure SetLojaId(Value: TLojaId);

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);

    function GetCaixaSessao: ICaixaSessao;
    function GetOperOrdem: SmallInt;
    function GetCxOperacaoTipo: ICxOperacaoTipo;

    function GetLogId: Int64;
    procedure SetLogId(Value: Int64);

    function GetOperTipoOrdem: SmallInt;
    procedure SetOperTipoOrdem(Value: SmallInt);

    function GetValor: Currency;
    procedure SetValor(Value: Currency);

    function GetObs: string;
    procedure SetObs(Value: string);

    function GetCancelado: Boolean;
    procedure SetCancelado(Value: Boolean);

  protected
    procedure LimparEnt;
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

  public
    property CaixaSessao: ICaixaSessao read GetCaixaSessao;
    property OperOrdem: SmallInt read GetOperOrdem;
    property CxOperacaoTipo: ICxOperacaoTipo read GetCxOperacaoTipo;
    property LogId: Int64 read GetLogId write SetLogId;
    property OperTipoOrdem: SmallInt read GetOperTipoOrdem;
    property Valor: Currency read GetValor write SetValor;
    property Obs: string read GetObs write SetObs;
    property Cancelado: Boolean read GetCancelado write SetCancelado;

    constructor Create(pCaixaSessao: ICaixaSessao;
      pCxOperacaoTipo: ICxOperacaoTipo);
  end;

implementation

{ TCxOperacaoEnt }

constructor TCxOperacaoEnt.Create(pCaixaSessao: ICaixaSessao;
  pCxOperacaoTipo: ICxOperacaoTipo);
begin
  FCaixaSessao := pCaixaSessao;
  FCxOperacaoTipo := pCxOperacaoTipo;
end;

function TCxOperacaoEnt.GetCaixaSessao: ICaixaSessao;
begin
  Result := FCaixaSessao;
end;

function TCxOperacaoEnt.GetCancelado: Boolean;
begin
  Result := FCancelado;
end;

function TCxOperacaoEnt.GetCxOperacaoTipo: ICxOperacaoTipo;
begin
  Result := FCxOperacaoTipo;
end;

function TCxOperacaoEnt.GetLogId: Int64;
begin
  Result := FLogId;
end;

function TCxOperacaoEnt.GetLojaId: TLojaId;
begin
  Result := FLojaId;
end;

function TCxOperacaoEnt.GetNomeEnt: string;
begin
  Result := 'Opera��o de Caixa '+ FCxOperacaoTipo.Caption;
end;

function TCxOperacaoEnt.GetNomeEntAbrev: string;
begin
  Result := FCxOperacaoTipo.Abrev;
end;

function TCxOperacaoEnt.GetObs: string;
begin
  Result := FObs;
end;

function TCxOperacaoEnt.GetOperOrdem: SmallInt;
begin
  Result := FOperOrdem;
end;

function TCxOperacaoEnt.GetOperTipoOrdem: SmallInt;
begin
  Result := FOperTipoOrdem;
end;

function TCxOperacaoEnt.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

function TCxOperacaoEnt.GetTitulo: string;
begin
  Result := 'Opera�oes de Caixa';
end;

function TCxOperacaoEnt.GetValor: Currency;
begin
  Result := FValor;
end;

procedure TCxOperacaoEnt.LimparEnt;
begin
  FOperOrdem := 0;
  FLogId := 0;
  FOperTipoOrdem := 0;
  FValor := ZERO_CURRENCY;
  FObs := '';
  FCancelado := False;
end;

procedure TCxOperacaoEnt.SetCancelado(Value: Boolean);
begin
  FCancelado := Value;
end;

procedure TCxOperacaoEnt.SetLogId(Value: Int64);
begin
  FLogId := Value;
end;

procedure TCxOperacaoEnt.SetLojaId(Value: TLojaId);
begin
  FLojaId := Value;
end;

procedure TCxOperacaoEnt.SetObs(Value: string);
begin
  FObs := Value;
end;

procedure TCxOperacaoEnt.SetOperTipoOrdem(Value: SmallInt);
begin
  FOperTipoOrdem := Value;
end;

procedure TCxOperacaoEnt.SetTerminalId(Value: TTerminalId);
begin
  FTerminalId := Value;
end;

procedure TCxOperacaoEnt.SetValor(Value: Currency);
begin
  FValor := Value;
end;

end.
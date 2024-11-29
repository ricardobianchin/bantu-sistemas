unit App.Est.Venda.CaixaSessao.DBI_u;

interface

uses Sis.DBI_u, App.Est.Venda.CaixaSessao.DBI, Sis.DB.DBTypes, Sis.Usuario,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.Est.Venda.CaixaSessaoRecord_u, Sis.Entities.Terminal, Sis.Entidade,
  Sis.Entities.Types, Data.DB;

type
  TCaixaSessaoDBI = class(TDBI, ICaixaSessaoDBI)
  private
    FLojaId: TLojaId;
    FTerminalId: TTerminalId;
    FMachineIdentId: smallint;
    FLogUsuario: IUsuario;
    FMensagem: string;
    function GetMensagem: string;
  public
    constructor Create(pDBConnection: IDBConnection; pLogUsuario: IUsuario;
      pLojaId: TLojaId; pTerminalId: TTerminalId; pMachineIdentId: smallint);
      reintroduce;
    function CaixaSessaoAbertoGet(pCaixaSessaoRec: TCaixaSessaoRec): Boolean;
    property Mensagem: string read GetMensagem;

  end;

implementation

uses Sis.Win.Utils_u;

{ TCaixaSessaoDBI }

function TCaixaSessaoDBI.CaixaSessaoAbertoGet(pCaixaSessaoRec
  : TCaixaSessaoRec): Boolean;
var
  sSql: string;
  q: TDataSet;
begin
  pCaixaSessaoRec.Zerar;

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    sSql :=
      'SELECT'#13#10
      +'SESS_ID'#13#10
      +', PESSOA_ID'#13#10
      +', APELIDO'#13#10
      +'FROM CAIXA_SESSAO_MANUT_PA.ABERTO_GET'#13#10
      ;
//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
    DBConnection.QueryDataSet(sSql, q);

    Result := Assigned(q);
    if not Result then
      exit;

    if q.IsEmpty then
      exit;

    pCaixaSessaoRec.SessId := q.Fields[0].AsInteger;
    pCaixaSessaoRec.PessoaId := q.Fields[1].AsInteger;
    pCaixaSessaoRec.Apelido := q.Fields[2].AsString;
    pCaixaSessaoRec.Aberto := True;
  finally
    DBConnection.Fechar;
  end;
  {
    LojaId: TLojaId;
    TerminalId: TTerminalId;
    SessId: integer;
    LogId: Int64;
    PessoaId: integer;
    Apelido: string;
    Conferido: Boolean;

  }
end;

constructor TCaixaSessaoDBI.Create(pDBConnection: IDBConnection; pLogUsuario: IUsuario;
      pLojaId: TLojaId; pTerminalId: TTerminalId; pMachineIdentId: smallint);
begin
  inherited Create(pDBConnection);
  FLogUsuario := pLogUsuario;
  FLojaId := pLojaId;
  FTerminalId := pTerminalId;
  FMachineIdentId := pMachineIdentId;
end;

function TCaixaSessaoDBI.GetMensagem: string;
begin
  Result := FMensagem;
end;

end.

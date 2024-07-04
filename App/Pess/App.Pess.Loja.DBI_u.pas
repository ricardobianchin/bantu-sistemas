unit App.Pess.Loja.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Pess.Loja.DBI,
  App.Pess.Loja.Ent, App.Pess.Geral.Factory_u, App.Pess.DBI_u;

type
  TPessLojaDBI = class(TPessDBI, IPessLojaDBI)
  private
    FPessLojaEnt: IPessLojaEnt;
    FAtivoFieldIndex: integer;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    procedure RegAtualToEnt(Q: TDataSet); override;
    function GetFieldNames: string; override;
  public
    constructor Create(pDBConnection: IDBConnection; pPessLojaEnt: IPessLojaEnt);
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TPessLojaDBI }

constructor TPessLojaDBI.Create(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt);
begin
  inherited Create(pDBConnection, pPessLojaEnt);
  FAtivoFieldIndex := 31;
  FPessLojaEnt := pPessLojaEnt;
end;

procedure TPessLojaDBI.RegAtualToEnt(Q: TDataSet);
begin
  inherited;
  FPessLojaEnt.Ativo := q.Fields[FAtivoFieldIndex {ATIVO}].AsBoolean;
end;

function TPessLojaDBI.GetFieldNames: string;
begin
  Result := inherited
    +', ATIVO'#13#10//31
    ;
end;

function TPessLojaDBI.GetSqlPreencherDataSet(pValues: variant): string;
var
  iLojaId: integer;
begin
  iLojaId := pValues[0];

  Result := 'SELECT'#13#10
    + GetFieldNames
    + 'FROM LOJA_MANUT_PA.LISTA_GET(' //
    + iLojaId.ToString //
    + ');'#13#10 //
    ;
end;

end.

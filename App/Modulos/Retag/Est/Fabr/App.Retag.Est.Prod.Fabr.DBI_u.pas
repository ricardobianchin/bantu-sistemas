unit App.Retag.Est.Prod.Fabr.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Retag.Est.Prod.Fabr.Ent;

type
  TProdFabrDBI = class(TEntDBI)
  private
    FProdFabrEnt: IProdFabrEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pIds: variant); override;
    function GetPackageName: string; override;
  public
    constructor Create(pDBConnection: IDBConnection; pEntEd: IProdFabrEnt);
  end;

implementation

uses System.SysUtils, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  Sis.Types.strings_u, App.Retag.Est.Factory;

{ TProdFabrDBI }

constructor TProdFabrDBI.Create(pDBConnection: IDBConnection;
  pEntEd: IProdFabrEnt);
begin
  inherited Create(pDBConnection);
  FProdFabrEnt := EntEdCastToProdFabrEnt(pEntEd);
end;

function TProdFabrDBI.GetPackageName: string;
begin
  Result := 'FABR_PA';
end;

function TProdFabrDBI.GetSqlGarantirRegId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT ID_GRAVADO FROM FABR_PA.GARANTIR(%d,''%s'');';
  Result := Format(sFormat, [FProdFabrEnt.Id, FProdFabrEnt.Descr]);
end;

function TProdFabrDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  sDescr: string;
begin
  sFormat := 'SELECT FABR_ID FROM FABR_PA.BYNOME_GET(''%s'');';
  sDescr := VarToString(pValues);
  Result := Format(sFormat, [sDescr]);
end;

function TProdFabrDBI.GetSqlPreencherDataSet(pValues: variant): string;
var
  sFormat: string;
  sBusca: string;
begin
  sFormat := 'select FABR_ID, NOME from FABR_PA.LISTA_GET(''%s'');';
  sBusca := VarToString(pValues);
  Result := Format(sFormat, [sBusca]);
end;

procedure TProdFabrDBI.SetNovaId(pIds: variant);
begin
  inherited;
  FProdFabrEnt.Id := VarToInteger(pIds);
end;

end.
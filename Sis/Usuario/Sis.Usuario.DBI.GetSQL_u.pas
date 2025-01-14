unit Sis.Usuario.DBI.GetSQL_u;

interface

uses Sis.ModuloSistema.Types;


function GetSQLUsuarioPeloNomeDeUsuario(pNomeUsu: string): string;

implementation

uses System.SysUtils;

function GetSQLUsuarioPeloNomeDeUsuario(pNomeUsu: string): string;
var
  sFormato: string;
begin
  sFormato := 'SELECT LOJA_ID, PESSOA_ID, NOME, APELIDO, SENHA_ZERADA' + //
    ' FROM USUARIO_PA.BY_NOME_DE_USUARIO_GET(''%s'');';
  Result := Format(sFormato, [pNomeUsu]);
end;

end.

unit btu.lib.db.dbms.config_u;

interface

uses btu.lib.db.dbms.config, btu.sis.ui.io.log, btu.sis.ui.io.output,
  btu.lib.config;

type
  TDBMSConfig = class(TInterfacedObject, IDBMSConfig)
  private
    FSisConfig: ISisConfig;
    FLog: iLog;
    FOutput: IOutput;
    FPausaAntesExec: boolean;

    function GetPausaAntesExec: boolean;
    procedure SetPausaAntesExec(Value: boolean);
  protected
    function Ler: boolean; virtual;
    procedure Gravar; virtual;
    procedure Inicialize; virtual;
  public
    property PausaAntesExec: boolean read GetPausaAntesExec write SetPausaAntesExec;
    constructor Create(pSisConfig: ISisConfig; pLog: iLog; pOutput: IOutput);
  end;

implementation

uses Xml.XMLDoc, Xml.XMLIntf, System.SysUtils, btu.lib.types.bool.utils;

{ TDBMSConfig }

constructor TDBMSConfig.Create(pSisConfig: ISisConfig; pLog: iLog;
  pOutput: IOutput);
begin
  FSisConfig := pSisConfig;
  FLog := pLog;
  FOutput := pOutput;

  Inicialize;

  if not Ler then
    Gravar;
end;

function TDBMSConfig.GetPausaAntesExec: boolean;
begin
  Result := FPausaAntesExec;
end;

procedure TDBMSConfig.Gravar;
var
  XMLDocument1: IXMLDocument;
  RootNode
  , DebugNode
  , PausaAntesExecNode
    :IXMLNODE;
  sPasta, sNomeArq, sArqXML: string;
begin
  sPasta := FSisConfig.PastaProduto;
  sNomeArq := 'DBMS.Firebird.Config.xml';
  sArqXML := sPasta + sNomeArq;

  XMLDocument1:=NewXMLDocument;
  XMLDocument1.Encoding := 'utf-8';
  XMLDocument1.Options := [doNodeAutoIndent]; // looks better in Editor ;)
  RootNode := XMLDocument1.AddChild('dbms');
  DebugNode := RootNode.AddChild('debug');
  PausaAntesExecNode := DebugNode.AddChild('pausa_antes_exec');

  PausaAntesExecNode.Text := BooleanToStr(FPausaAntesExec);
  XMLDocument1.SaveToFile(sArqXML);
end;

procedure TDBMSConfig.Inicialize;
begin
  FPausaAntesExec := false;
end;

function TDBMSConfig.Ler: boolean;
var
  XMLDocument1: IXMLDocument;
  RootNode
  , DebugNode
  , PausaAntesExecNode
    :IXMLNODE;
  sPasta, sNomeArq, sArqXML: string;
  s: string;
begin
  sPasta := FSisConfig.PastaProduto;
  sNomeArq := 'DBMS.Firebird.Config.xml';
  sArqXML := sPasta + sNomeArq;

  Result := FileExists(sArqXML);
  if not Result then
    exit;

  XMLDocument1 := LoadXMLDocument(sArqXML);
  RootNode := XMLDocument1.DocumentElement;

  DebugNode := RootNode.ChildNodes['debug'];
  PausaAntesExecNode := DebugNode.ChildNodes['pausa_antes_exec'];
  s := PausaAntesExecNode.Text;

  if s = '' then
    s:= 'N';

  FPausaAntesExec := StrToBool(s);
end;

procedure TDBMSConfig.SetPausaAntesExec(Value: boolean);
begin
  FPausaAntesExec := Value;
end;

end.

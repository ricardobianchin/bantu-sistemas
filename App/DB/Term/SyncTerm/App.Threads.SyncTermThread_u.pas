unit App.Threads.SyncTermThread_u;

interface

uses App.Threads.TermThread_u, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  System.Classes, Sis.Threads.ThreadBas_u, App.AppObj, Sis.Entities.Terminal,
  Sis.Threads.SafeBool, Sis.DB.Factory, Sis.DB.DBTypes, App.DB.Utils,
  Sis.Sis.Constants, App.Threads.SyncTermThread_ProcLog,
  System.Generics.Collections, FireDAC.Comp.Client, Sis.DB.FDExecScript_u;

type
  TAppSyncTermThread = class(TTermThread)
  private
    FServDBConnectionParams: TDBConnectionParams;
    FTermDBConnectionParams: TDBConnectionParams;

    FServFDConnection: TFDConnection;
    FTermFDConnection: TFDConnection;
    FFDExecScript: TFDExecScript;

    FServCon, FTermCon: IDBConnection;
    FLogIdIni, FLogIdFin: Int64;
    FDBExecScript: IDBExecScript;
    FProcLogList: TList<ISyncTermProcLog>;

    function Conectou: boolean;
    procedure FecharConexoes;
    procedure Sync(pAtualIni, pAtualFIn: Int64);
    procedure AtualizeMachine;
  protected
    procedure RegistreProcLog(pAppObj: IAppObj; pTerminal: ITerminal;
      pServCon, pTermCon: IDBConnection; pSql: TStrings); virtual;

    /// ////
    // EXECUTE
    /// ////
    procedure Execute; override;

    procedure PegarFaixa(out FLogIdIni, FLogIdFin: Int64); virtual;

    property ProcLogList: TList<ISyncTermProcLog> read FProcLogList;
    property DBExecScript: IDBExecScript read FDBExecScript;
  public
    constructor Create(pServDBConnectionParams: TDBConnectionParams;
      pTermDBConnectionParams: TDBConnectionParams; pTerminal: ITerminal;
      pAppObj: IAppObj; pExecutando: ISafeBool; pTitOutput: IOutput;
      pStatusOutput: IOutput; pProcessLog: IProcessLog;
      pOnTerminate: TNotifyEvent; pThreadTitulo: string);
    destructor Destroy; override;

  end;

implementation

uses System.SysUtils, Sis.Config.SisConfig, System.Math, App.Constants,
  App.Threads.SyncTermThread_u_PegarFaixa, App.Threads.SyncTermThread.Factory_u,
  Data.DB, Sis.Types.Integers;

{ TAppSyncTermThread }

procedure TAppSyncTermThread.AtualizeMachine;
var
  iMaxTerm: integer;
  s: string;
  oFDQuery: TFDQuery;
  q: TFDQuery;
  iRowsAfected: LongInt;
begin
  s := 'select max(machine_id) from machine;';
  iMaxTerm := VarToInteger(FTermFDConnection.ExecSQLScalar(s));
  // StatusOutput.Exibir(iMaxTerm.ToString);

  s := 'SELECT MACHINE_ID, NOME_NA_REDE, trim(IP) colip' + ' FROM MACHINE' +
    ' WHERE MACHINE_ID > ' + IntToStr(iMaxTerm) + ' ORDER BY MACHINE_ID';
  oFDQuery := TFDQuery.Create(nil);
  oFDQuery.Connection := FServFDConnection;
  oFDQuery.Sql.Text := s;
//  AppObj.CriticalSections.DB.Acquire;
  oFDQuery.Open;
  oFDQuery.Close;
//  AppObj.CriticalSections.DB.Release;
  FreeAndNil(oFDQuery);
  sleep(100+Random(2000));
  exit;
  try
    oFDQuery.Connection := FServFDConnection;
    oFDQuery.Sql.Text := s;

    AppObj.CriticalSections.DB.Acquire;
    try
      oFDQuery.Open;
    finally
      AppObj.CriticalSections.DB.Release;
    end;

    try
      exit;
      Terminal.CriticalSections.DB.Acquire;
      try
        q := oFDQuery;
        while not q.Eof do
        begin
          s := 'INSERT INTO MACHINE' + '(MACHINE_ID, NOME_NA_REDE, IP)' //
            + ' VALUES (' + q.Fields[0].AsInteger.ToString //
            + ', ' + QuotedStr(q.Fields[1].AsString) //
            + ', ' + QuotedStr(q.Fields[2].AsString.Trim) //
            + ');';
          FTermFDConnection.ExecSQL(s);
          q.Next;
        end;
      finally
        Terminal.CriticalSections.DB.Release;
      end;
    finally
      oFDQuery.Close;
    end;
  finally
    oFDQuery.Free;
  end;
end;

function TAppSyncTermThread.Conectou: boolean;
var
  s: ISisConfig;
  rDBConnectionParams: TDBConnectionParams;
  sDriver: string;
begin
  s := AppObj.SisConfig;

  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FServFDConnection := TFDConnection.Create(nil);
  FServFDConnection.LoginPrompt := false;
  sDriver := 'FB';

  FServFDConnection.Params.Text := //
    'DriverID=' + sDriver + #13#10 //
    + 'Server=' + rDBConnectionParams.Server + #13#10 //
    + 'Database=' + rDBConnectionParams.Arq + #13#10 +
    'Password=masterkey'#13#10 + 'User_Name=sysdba'#13#10 + 'Protocol=TCPIP';

  rDBConnectionParams.Server := Terminal.NomeNaRede;
  rDBConnectionParams.Arq := Terminal.LocalArqDados;
  rDBConnectionParams.Database := Terminal.Database;

  FTermFDConnection := TFDConnection.Create(nil);
  FTermFDConnection.LoginPrompt := false;
  sDriver := 'FB';

  FTermFDConnection.Params.Text := //
    'DriverID=' + sDriver + #13#10 //
    + 'Server=' + rDBConnectionParams.Server + #13#10 //
    + 'Database=' + rDBConnectionParams.Arq + #13#10 +
    'Password=masterkey'#13#10 + 'User_Name=sysdba'#13#10 + 'Protocol=TCPIP';

  // StatusOutput.Exibir('Conectando servidor...');
  FServFDConnection.Open;
  // StatusOutput.Exibir('Conectando terminal...');
  FTermFDConnection.Open;

  FFDExecScript := TFDExecScript.Create('TAppSyncTermThread.execscript',
    FTermFDConnection, Terminal.CriticalSections.DB);

  Result := True;

end;

constructor TAppSyncTermThread.Create(pServDBConnectionParams
  : TDBConnectionParams; pTermDBConnectionParams: TDBConnectionParams;
  pTerminal: ITerminal; pAppObj: IAppObj; pExecutando: ISafeBool;
  pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
  pOnTerminate: TNotifyEvent; pThreadTitulo: string);
var
  sThreadTitulo: string;
begin
  sThreadTitulo := 'Sincronização ' + pTerminal.AsText;
  inherited Create(pTerminal, pAppObj, pExecutando, pTitOutput, pStatusOutput,
    pProcessLog, pOnTerminate, pThreadTitulo);
  FProcLogList := TList<ISyncTermProcLog>.Create;
end;

destructor TAppSyncTermThread.Destroy;
begin
  FreeAndNil(FProcLogList);
  inherited;
end;

procedure TAppSyncTermThread.Execute;
var
  i, m: integer;
  iAtualIni, iAtualFIn: Int64;
  bTerminated: boolean;
begin
  exit;
  // inherited;
  if Terminated then
    exit;
  if not Conectou then
    exit;
  try
    if Terminated then
      exit;

    AtualizeMachine;
    exit;

    // RegistreProcLog(AppObj, Terminal, FServCon, FTermCon, FDBExecScript.Sql);
    //
    // PegarFaixa(FLogIdIni, FLogIdFin);
    //
    // if FLogIdIni = FLogIdFin then
    // exit;
    //
    // iAtualIni := FLogIdIni;
    //
    // while iAtualIni <= FLogIdFin do
    // begin
    // if Terminated then
    // exit;
    //
    // iAtualFIn := Min(FLogIdFin, iAtualIni + TERMINAL_SYNC_PASSO - 1);
    //
    // Sync(iAtualIni, iAtualFIn);
    //
    // Inc(iAtualIni, TERMINAL_SYNC_PASSO);
    // end;
  finally
    FecharConexoes;
  end;
end;

{
  m := 5 + random(10);
  for i := 1 to m do
  begin
  OutputSafe(StatusOutput, i.ToString + '/' + m.ToString);
  if Terminated then
  break;
  Sleep(1000);
  end;
}

procedure TAppSyncTermThread.FecharConexoes;
begin
  exit;
  FServFDConnection.Close;
  FTermFDConnection.Close;

  FFDExecScript.Free;
  FServFDConnection.Free;
  FTermFDConnection.Free;
end;

procedure TAppSyncTermThread.PegarFaixa(out FLogIdIni, FLogIdFin: Int64);
begin
  App.Threads.SyncTermThread_u_PegarFaixa.PegarFaixa(AppObj, Terminal, FServCon,
    FTermCon, FLogIdIni, FLogIdFin);
end;

procedure TAppSyncTermThread.RegistreProcLog(pAppObj: IAppObj;
  pTerminal: ITerminal; pServCon, pTermCon: IDBConnection; pSql: TStrings);
begin
  // FProcLogList.Add(ProcLogLoja(pAppObj, pTerminal, pServCon, pTermCon,
  // FDBExecScript));
  // FProcLogList.Add(ProcLogTerminal(pAppObj, pTerminal, pServCon, pTermCon,
  // FDBExecScript));
  // FProcLogList.Add(ProcLogPagamentoForma(pAppObj, pTerminal, pServCon, pTermCon,
  // FDBExecScript));
  // FProcLogList.Add(ProcLogFuncUsu(pAppObj, pTerminal, pServCon, pTermCon,
  // FDBExecScript));
  // FProcLogList.Add(ProcLogUsuPode(pAppObj, pTerminal, pServCon, pTermCon,
  // FDBExecScript));
end;

procedure TAppSyncTermThread.Sync(pAtualIni, pAtualFIn: Int64);
var
  sFormat: string;
  sMens: string;
begin
  sFormat := 'Logs de %d a %d. Fin: %d';
  sMens := Format(sFormat, [pAtualIni, pAtualFIn, FLogIdFin]);
  // StatusOutput.Exibir(sMens);

  for var Adder in FProcLogList do
    Adder.Execute(pAtualIni, pAtualFIn);

  FDBExecScript.PegueComando
    ('EXECUTE PROCEDURE SYNC_DO_SERVIDOR_SIS_PA.ATUALIZAR(' +
    FLogIdFin.ToString + ');');

  FDBExecScript.Execute;
end;

end.

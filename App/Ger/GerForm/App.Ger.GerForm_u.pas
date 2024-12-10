unit App.Ger.GerForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.UI.Constants, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, Sis.UI.Frame.Status.Thread_u,
  System.Generics.Collections, App.Ger.GerForm.DBI, App.AppObj,
  Sis.Threads.Tarefa, Sis.Entities.Terminal, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client;

type
  TExecuteTeste = (etNenhum, etUm, etTodos);

const
{$IFDEF DEBUG}
   FRAME_EXECUTAR: TExecuteTeste = etTodos;
   //FRAME_EXECUTAR: TExecuteTeste = etNenhum;
  //FRAME_EXECUTAR: TExecuteTeste = etUm;

  NSECS_PAUSA = 3;
{$ELSE}
  FRAME_EXECUTAR: TExecuteTeste = etTodos;
  NSECS_PAUSA = 15;
{$ENDIF}

type
  TGerAppForm = class(TBasForm)
    TitleBarPanel: TPanel;
    TitleToolBar: TToolBar;
    TitActionList: TActionList;
    FecharAction_GerAppForm: TAction;
    BasePanel: TPanel;
    SempreVisivelCheckBox: TCheckBox;
    AutoOpenCheckBox: TCheckBox;
    StatusFrameScrollBox: TScrollBox;
    ExecuteTimer: TTimer;
    StatusLabel: TLabel;
    /// <summary>
    /// permite usuario arrastar a janela
    /// </summary>
    procedure TitleBarPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    /// <summary>
    /// se o sistema nao est� fechando, oculta a janela
    /// </summary>
    procedure FecharAction_GerAppFormExecute(Sender: TObject);

    /// <summary>
    /// config, sempre visivel
    /// </summary>
    procedure SempreVisivelCheckBoxClick(Sender: TObject);

    /// <summary>
    /// config, autoopen
    /// </summary>
    procedure AutoOpenCheckBoxClick(Sender: TObject);

    /// <summary>
    /// timer dispara execucao
    /// </summary>
    procedure ExecuteTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FSecPausa: Integer;
    FAutoOpen: Boolean;
    FSempreVisivel: Boolean;
    FProcessaControles: Boolean;
    FGerFormDBI: IGerFormDBI;
    FAppObj: IAppObj;
    FPodeExecutar: Boolean;

    FTarefaList: TList<ITarefa>;

    procedure CarregConfig;

    procedure SetSempreVisivel(Value: Boolean);
    procedure SetAutoOpen(Value: Boolean);

    procedure GerFormDBIInicialize;

  protected
    procedure AjusteControles; override;
    property AppObj: IAppObj read FAppObj;

    procedure PreenchaTarefaList; virtual;
    property TarefaList: TList<ITarefa> read FTarefaList;

    procedure ExecuteForAllTarefas(const Proc: TTarefaProcedure);
  public
    { Public declarations }
    property PodeExecutar: Boolean read FPodeExecutar write FPodeExecutar;

    property AutoOpen: Boolean read FAutoOpen write SetAutoOpen;
    property SempreVisivel: Boolean read FSempreVisivel write SetSempreVisivel;

    constructor Create(AOwner: TComponent; pAppObj: IAppObj); reintroduce;

    destructor Destroy; override;

    procedure Terminate;
    procedure EspereTerminar;
  end;

  // var
  // GerAppForm: TGerAppForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, System.DateUtils, Sis.Types.Bool_u, Sis.DB.DBTypes,
  App.DB.Utils, Sis.Sis.Constants, Sis.DB.DBConfig.Factory_u,
  Sis.DB.DBConfigDBI, Sis.DB.Factory, App.Ger.Factory, Sis.UI.Controls.Utils,
  Sis.Threads.Factory_u;

procedure TGerAppForm.AjusteControles;
begin
  inherited;
end;

procedure TGerAppForm.AutoOpenCheckBoxClick(Sender: TObject);
begin
  inherited;
  if not FProcessaControles then
    exit;

  AutoOpen := AutoOpenCheckBox.Checked;
end;

procedure TGerAppForm.CarregConfig;
begin
  FGerFormDBI.PegarConfigs(FSempreVisivel, FAutoOpen);

  if FSempreVisivel then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;

  SempreVisivelCheckBox.Checked := FSempreVisivel;
  AutoOpenCheckBox.Checked := FAutoOpen;
end;

procedure TGerAppForm.SempreVisivelCheckBoxClick(Sender: TObject);
begin
  inherited;
  if not FProcessaControles then
    exit;

  SempreVisivel := SempreVisivelCheckBox.Checked;
end;

constructor TGerAppForm.Create(AOwner: TComponent; pAppObj: IAppObj);
begin
  inherited Create(AOwner);
//  FDManager.ResourceOptions.CmdExecMode := TFDStanAsyncMode.amAsync;
  FSecPausa := 0;
  FProcessaControles := False;
  FAppObj := pAppObj;

  GerFormDBIInicialize;

  CarregConfig;
  FProcessaControles := True;
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  TitleToolBar.Color := COR_AZUL_TITLEBAR;

  FPodeExecutar := True;
  // ClearStyleElements(Self);

  FTarefaList := TList<ITarefa>.Create;
  PreenchaTarefaList;

end;

destructor TGerAppForm.Destroy;
begin
  FTarefaList.Free;
  inherited;
end;

procedure TGerAppForm.EspereTerminar;
var
  bTerminou: Boolean;
begin
  bTerminou := FTarefaList.Count = 0;
  if bTerminou then
    exit;

  ExecuteForAllTarefas(
    procedure(pTarefa: ITarefa)
    begin
      pTarefa.EspereTerminar;
    end);

end;

procedure TGerAppForm.ExecuteForAllTarefas(const Proc: TTarefaProcedure);
var
  oTarefa: ITarefa;
  i: Integer;
begin
  for i := 0 to FTarefaList.Count - 1 do
  begin
    oTarefa := FTarefaList[i];
    Proc(oTarefa);
  end;
end;

procedure TGerAppForm.ExecuteTimerTimer(Sender: TObject);
begin
  inherited;
  StatusLabel.Caption := 'Executando: ' + DateTimeToStr(Now);
  //ExecuteTimer.Enabled := False;
  if not PodeExecutar then
    exit;

  inc(FSecPausa);
  if FSecPausa = NSECS_PAUSA then
  begin
    FSecPausa := 0;
  end
  else
  begin
    exit;
  end;

  case FRAME_EXECUTAR of
    etNenhum:
      ExecuteTimer.Enabled := False; // exit;
    etUm:
      if FTarefaList.Count > 0 then
        FTarefaList[0].Execute;
  else // etTodos:
    ExecuteForAllTarefas(
      procedure(pTarefa: ITarefa)
      begin
        pTarefa.Execute;
      end);
  end;
end;

procedure TGerAppForm.Terminate;
begin
  FPodeExecutar := False;

  if FTarefaList.Count = 0 then
    exit;

  ExecuteForAllTarefas(
    procedure(pTarefa: ITarefa)
    begin
      pTarefa.Terminate;
    end);
end;

procedure TGerAppForm.FecharAction_GerAppFormExecute(Sender: TObject);
begin
  inherited;
  if not FPodeExecutar then
    exit;

  Hide;
end;

procedure TGerAppForm.GerFormDBIInicialize;
var
  rDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  oDBConfigDBI: IDBConfigDBI;
begin
  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, FAppObj);

  oDBConnection := DBConnectionCreate('App.GerForm.CarregConfig.conn',
    FAppObj.SisConfig, rDBConnectionParams, nil, nil);

  oDBConfigDBI := DBConfigDBICreate(oDBConnection);
  FGerFormDBI := GerFormDBICreate(oDBConnection, oDBConfigDBI);
end;

procedure TGerAppForm.PreenchaTarefaList;
begin

end;

procedure TGerAppForm.SetAutoOpen(Value: Boolean);
begin
  FAutoOpen := Value;
  FGerFormDBI.AutoOpenGravar(FAutoOpen);
end;

procedure TGerAppForm.SetSempreVisivel(Value: Boolean);
begin
  FSempreVisivel := Value;

  if FSempreVisivel then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
  FGerFormDBI.SempreVisivelGravar(FSempreVisivel);
end;

procedure TGerAppForm.TitleBarPanelMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  inherited;
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

end.

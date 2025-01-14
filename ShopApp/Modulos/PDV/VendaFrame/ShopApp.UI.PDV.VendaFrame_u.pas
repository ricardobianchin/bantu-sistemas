unit ShopApp.UI.PDV.VendaFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.PDV.VendaBasFrame_u, Vcl.ExtCtrls, Vcl.StdCtrls, System.Types,
  Vcl.Grids, App.PDV.Venda, ShopApp.PDV.Venda, ShopApp.PDV.VendaItem,
  App.PDV.DBI, ShopApp.PDV.DBI, ShopApp.UI.PDV.Venda.Frame.FitaDraw,
  Vcl.ComCtrls, Vcl.ToolWin, App.PDV.Controlador;

type
  TShopVendaPDVFrame = class(TVendaBasPDVFrame)
    InputPanel: TPanel;
    StrBuscaLabel: TLabel;
    CaretTimer: TTimer;
    CaretShape: TShape;
    FitaStringGrid: TStringGrid;
    ItemPanel: TPanel;
    ItemDescrLabel: TLabel;
    ItemTotalLabel: TLabel;
    TotalPanel: TPanel;
    TotalLiquidoLabel: TLabel;
    VolumesLabel: TLabel;
    BasePanel: TPanel;
    PDVToolBar: TToolBar;
    VoltouToolButton: TToolButton;
    ItemCanceleToolButton: TToolButton;
    PagSomenteDinheiroToolButton: TToolButton;
    PagamentoToolButton: TToolButton;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    procedure CaretTimerTimer(Sender: TObject);
    procedure FitaStringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FitaStringGridEnter(Sender: TObject);
    procedure ItemCanceleToolButtonClick(Sender: TObject);
    procedure PagSomenteDinheiroToolButtonClick(Sender: TObject);
    procedure PagamentoToolButtonClick(Sender: TObject);
  private
    { Private declarations }
    FColuna1Rect, FColuna2Rect: TRect;
    FStrBusca: string;
    FShopPDVVenda: IShopPDVVenda;
    FShopAppPDVDBI: IShopAppPDVDBI;
    FFitaDraw: IShopFitaDraw;

    procedure DimensioneItemPanel;
    procedure DimensioneInput;
    procedure DimensioneFitaStringGrid;

    procedure StrBuscaPegueChar(pChar: Char);
    procedure StrBuscaExec; // ADICIONA ITEM
    procedure StrBuscaMudou;

    procedure ItemZerar;
    procedure PreencherControles;

    procedure ExibaItemVendido(pDescr: string; pValor: Currency = 0);

    procedure ItemCancele;
    procedure ItemSelecione(pIndex: Integer = -1);
    function GetItemUltimoIndex: Integer;

  protected
    procedure SimuleKeyPress(pChar: Char);
    procedure ExibaControles; override;
  public
    { Public declarations }
    procedure ExibaErro(pMens: string); override;
    procedure ExibaMens(pMens: string); override;
    procedure DimensioneControles; override;

    // TECLADO KEYDOWN
    procedure ExecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); override;

    // TECLADO PRESS
    procedure ExecKeyPress(Sender: TObject; var Key: Char); override;

    procedure Iniciar; override;

    constructor Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
      pAppPDVDBI: IAppPDVDBI; pPDVControlador: IPDVControlador); reintroduce;
  end;

var
  ShopVendaPDVFrame: TShopVendaPDVFrame;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, Sis.UI.Controls.Utils, ShopApp.PDV.Factory_u,
  Sis.Types.Floats, Sis.Types.Bool_u, ShopApp.UI.PDV.ItemCancelarForm_u,
  Sis.UI.IO.Input.Perg;

{ TShopVendaPDVFrame }

procedure TShopVendaPDVFrame.CaretTimerTimer(Sender: TObject);
begin
  inherited;
  CaretShape.Visible := not CaretShape.Visible;
end;

constructor TShopVendaPDVFrame.Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
  pAppPDVDBI: IAppPDVDBI; pPDVControlador: IPDVControlador);
begin
  inherited Create(AOwner, pPDVVenda, pAppPDVDBI, pPDVControlador);
  FShopPDVVenda := VendaAppCastToShopApp(pPDVVenda);
  FShopAppPDVDBI := DBIAppCastToShopApp(pAppPDVDBI);

  FFitaDraw := FitaDrawCreate(VendaAppCastToShopApp(pPDVVenda), FitaStringGrid);

  FStrBusca := '';
  ItemDescrLabel.Caption := '';
  ItemTotalLabel.Caption := '';
end;

procedure TShopVendaPDVFrame.DimensioneControles;
var
  MargHor: Integer;
  MargVer: Integer;
begin
  inherited;
  MargHor := 5;
  MargVer := 3;

  FColuna1Rect.Left := MargHor;
  FColuna1Rect.Top := MargVer;
  FColuna1Rect.Width := (MeioPanel.Width - (3 * MargHor)) div 2;
  FColuna1Rect.Height := MeioPanel.Height - (2 * MargVer);

  FColuna2Rect.Left := FColuna1Rect.Width + MargHor * 2;
  FColuna2Rect.Top := FColuna1Rect.Top;
  FColuna2Rect.Width := FColuna1Rect.Width;
  FColuna2Rect.Height := FColuna1Rect.Height;

  DimensioneInput;
  DimensioneItemPanel;
  DimensioneFitaStringGrid;
  ControlAlignToCenter(PDVToolBar);
  PDVToolBar.StyleElements := [seFont, seClient, seBorder];
end;

procedure TShopVendaPDVFrame.DimensioneFitaStringGrid;
var
  l, t, w, h: Integer;
  iDir: Integer;
begin
  FitaStringGrid.Font.Name := 'Courier New';
  FitaStringGrid.Font.Size := 12;

  FitaStringGrid.Canvas.Font.Assign(FitaStringGrid.Font);

  h := (FColuna2Rect.Height * 56) div 80;
  t := FColuna2Rect.Top;
  // w := FColuna2Rect.Width;
  w := (FitaStringGrid.Canvas.TextWidth('W') * ((CUPOM_QTD_COLS * 2) +
    1)) div 2;

  iDir := ItemPanel.Left + ItemPanel.Width;
  l := iDir - w;

  FitaStringGrid.Left := l;
  FitaStringGrid.Top := t;
  FitaStringGrid.Width := w;
  FitaStringGrid.Height := h;

  FitaStringGrid.DefaultColWidth := FitaStringGrid.Width;

  FFitaDraw.Prepare;
end;

procedure TShopVendaPDVFrame.DimensioneInput;
var
  l, t, w, h: Integer;
begin
  l := FColuna2Rect.Left;
  h := FColuna2Rect.Height div 8;
  t := FColuna2Rect.Height - h;
  w := FColuna2Rect.Width;

  InputPanel.Left := l;
  InputPanel.Top := t;
  InputPanel.Width := w;
  InputPanel.Height := h;

  InputPanel.Color := Rgb(16, 21, 36);
  // InputPanel.BevelOuter := bvNone;
  InputPanel.Font.Color := Rgb(248, 237, 228);

  CaretShape.Brush.Color := InputPanel.Font.Color;
end;

procedure TShopVendaPDVFrame.DimensioneItemPanel;
var
  l, t, w, h: Integer;
begin
  l := FColuna1Rect.Left;
  h := InputPanel.Height;
  w := FColuna2Rect.Left + FColuna2Rect.Width - l;
  t := InputPanel.Top - 4 - h;

  ItemPanel.Left := l;
  ItemPanel.Top := t;
  ItemPanel.Width := w;
  ItemPanel.Height := h;

  ItemPanel.Color := Rgb(16, 21, 36);
  // ItemPanel.BevelOuter := bvNone;
  ItemPanel.Font.Color := Rgb(248, 237, 228);
end;

procedure TShopVendaPDVFrame.ExecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  {
    [14:17, 12/14/2024] Anderson Arag�o Daros: Page up- totalizar
    Page down- dinheiro
    Insert -cart�o
    Home- pix ou transfer�ncia
    End devolu��o
    [14:17, 12/14/2024] Anderson Arag�o Daros: Pause cancelamento de item
  }

  if (Key = VK_F4) and (ssAlt in Shift) then
  begin
    Key := 0;
    // FecharAction_ModuloBasForm.Execute;
    Exit;
  end;

  case Key of
    VK_UP:
      begin
        Key := 0;
        if FitaStringGrid.Row > 0 then
          FitaStringGrid.Row := FitaStringGrid.Row - 1;
      end;
    VK_DOWN:
      begin
        Key := 0;
        if FitaStringGrid.Row < FitaStringGrid.RowCount - 1 then
          FitaStringGrid.Row := FitaStringGrid.Row + 1;
      end;
    VK_DELETE:
      begin
        Key := 0;
        ItemCancele;
      end;
    VK_PRIOR:
      begin
        Key := 0;
        PDVControlador.VaParaPag;
      end;
    VK_NEXT:
      begin
        Key := 0;
        PDVControlador.PagSomenteDinheiro;
      end;
  end;
end;

procedure TShopVendaPDVFrame.ExecKeyPress(Sender: TObject; var Key: Char);
var
  dtCanceladoEm: TDateTime;
  bResultado: Boolean;
  sMens: string;
begin
  inherited;
  if Key = #27 then
  begin
    if PDVVenda.VendaId = 0 then
      Exit;

    Key := #0;

    bResultado := PergBool('Deseja cancelar a venda?');
    if not bResultado then
      Exit;

    PDVDBI.EstMovCancele(dtCanceladoEm, bResultado, sMens);

    PDVVenda.Cancelado := True;
    PDVControlador.VaParaFinaliza;
    exit;
  end;
  StrBuscaPegueChar(Key);
end;

procedure TShopVendaPDVFrame.ExibaControles;
begin
  PreencherControles;
  inherited;

end;

procedure TShopVendaPDVFrame.ExibaErro(pMens: string);
begin
  inherited;
  ExibaItemVendido(pMens);
end;

procedure TShopVendaPDVFrame.ExibaItemVendido(pDescr: string; pValor: Currency);
begin
  ItemDescrLabel.Caption := pDescr;
  ItemTotalLabel.Caption := Iif(pValor = 0, '', DinhToStr(pValor));
end;

procedure TShopVendaPDVFrame.ExibaMens(pMens: string);
begin
  ExibaItemVendido(pMens);
end;

procedure TShopVendaPDVFrame.FitaStringGridDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
  FFitaDraw.FitaStringGridDrawCell(Sender, ACol, ARow, Rect, State);
end;

procedure TShopVendaPDVFrame.FitaStringGridEnter(Sender: TObject);
begin
  inherited;
  TForm(Parent).ActiveControl := Nil;
  // InputPanel.SetFocus;
end;

function TShopVendaPDVFrame.GetItemUltimoIndex: Integer;
begin
  Result := FShopPDVVenda.Items.Count - 1;
end;

procedure TShopVendaPDVFrame.Iniciar;
var
  bCarregou: Boolean;
begin
  inherited;

  FShopAppPDVDBI.CarregueVendaPendente(bCarregou);
  PreencherControles;
  if FShopPDVVenda.Items.Count = 0 then
    ExibaItemVendido('');

  // SimuleKeyPress('3');
  // SimuleKeyPress('*');
  // SimuleKeyPress('2');

  // DigiteStr('2~', 0);
  // DigiteStr('3*2~', 0);
  // ExecKeyPress(
end;

procedure TShopVendaPDVFrame.ItemCancele;
var
  bResultado: Boolean;
begin
  if FitaStringGrid.RowCount = 0 then
  begin
    ShowMessage('Nenhum item a cancelar');
    Exit;
  end;

  ItemCancelarForm_ShopApp := TItemCancelarForm_ShopApp.Create(FitaStringGrid,
    FShopPDVVenda, FShopAppPDVDBI);
  try
    bResultado := ItemCancelarForm_ShopApp.Perg;

    if bResultado then
      PreencherControles;
  finally
    FreeAndNil(ItemCancelarForm_ShopApp);
  end;
end;

procedure TShopVendaPDVFrame.ItemSelecione(pIndex: Integer);
var
  iMax: Integer;
begin
  if FitaStringGrid.RowCount < 2 then
    Exit;

  iMax := GetItemUltimoIndex;

  if pIndex < 0 then
  begin
    pIndex := iMax;
  end
  else if pIndex > iMax then
  begin
    pIndex := iMax;
  end;

  FitaStringGrid.Row := pIndex + 1;
end;

procedure TShopVendaPDVFrame.PreencherControles;
var
  i: Integer;
  oItem: IShopPdvVendaItem;
  iQtdVolumes: Integer;
  uTotalLiquido: Currency;
  s: string;
begin
  FFitaDraw.Atualize;

  iQtdVolumes := 0;
  uTotalLiquido := 0;

  for i := 0 to FShopPDVVenda.Items.Count - 1 do
  begin
    oItem := FShopPDVVenda[i];
    if not oItem.Cancelado then
    begin
      Inc(iQtdVolumes, oItem.QtdVolumes);
      uTotalLiquido := uTotalLiquido + oItem.Preco;
    end;
  end;

  s := iQtdVolumes.ToString;

  VolumesLabel.Caption := 'Volumes: ' + s;

  s := DinhToStr(uTotalLiquido);

  TotalLiquidoLabel.Caption := 'Total: ' + s;

  ItemSelecione;
end;

procedure TShopVendaPDVFrame.SimuleKeyPress(pChar: Char);
begin
  ExecKeyPress(Self, pChar);
end;

procedure TShopVendaPDVFrame.StrBuscaExec;
var
  oItem: IShopPdvVendaItem;
  bEncontrou: Boolean;
  sMensagem: string;
begin
  oItem := FShopAppPDVDBI.ItemCreatePelaStrBusca(FStrBusca, bEncontrou,
    sMensagem);

  if not bEncontrou then
  begin
    ExibaErro(sMensagem);
    Exit;
  end;
  FShopPDVVenda.Items.Add(oItem);
  ExibaItemVendido(oItem.Prod.DescrRed, oItem.PrecoBruto);
  PreencherControles;
  FStrBusca := '';
  StrBuscaMudou;
end;

procedure TShopVendaPDVFrame.StrBuscaMudou;
begin
  if FStrBusca = '' then
    StrBuscaLabel.Caption := 'Quantidade * C�digo / C�digo'
  else
    StrBuscaLabel.Caption := FStrBusca;
end;

procedure TShopVendaPDVFrame.StrBuscaPegueChar(pChar: Char);
begin
  try
    if pChar = #8 then
    begin
      StrDeleteNoFim(FStrBusca, 1);
      Exit;
    end
    else if pChar = #13 then
    begin
      StrBuscaExec;
      Exit;
    end;
    CharSemAcento(pChar);
    FStrBusca := FStrBusca + pChar;
  finally
    StrBuscaMudou;
  end;
end;

procedure TShopVendaPDVFrame.PagamentoToolButtonClick(Sender: TObject);
begin
  inherited;
  PDVControlador.VaParaPag;
end;

procedure TShopVendaPDVFrame.PagSomenteDinheiroToolButtonClick(Sender: TObject);
begin
  inherited;
  PDVControlador.PagSomenteDinheiro;
end;

procedure TShopVendaPDVFrame.ItemCanceleToolButtonClick(Sender: TObject);
begin
  inherited;
  ItemCancele;
end;

procedure TShopVendaPDVFrame.ItemZerar;
begin

end;

end.

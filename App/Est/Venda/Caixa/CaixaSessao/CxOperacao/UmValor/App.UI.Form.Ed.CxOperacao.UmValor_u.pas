unit App.UI.Form.Ed.CxOperacao.UmValor_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Ed.CxOperacao_u, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  NumEditBtu, Vcl.ComCtrls, App.UI.Controls.NumerarioListFrame_u,
  App.Est.Venda.Caixa.CxValor.DBI, App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent;

type
  TCxOperUmValorEdForm = class(TCxOperacaoEdForm)
    TrabPageControl: TPageControl;
    ValorTabSheet: TTabSheet;
    ValorEdit: TEdit;
    NumerarioTabSheet: TTabSheet;
    ObsLabel: TLabel;
    procedure TrabPageControlChange(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FValorNumEdit: TNumEditBtu;
    FNumerarioListFrame: TNumerarioListFrame;
  protected
    procedure ControlesToEnt; override;
    procedure EntToControles; override;
    function ControlesOk: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI); reintroduce; virtual;
  end;

var
  CxOperUmValorEdForm: TCxOperUmValorEdForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, App.Est.Venda.CaixaSessao.Factory_u, , Sis.Types.Utils_u;

{ TCxOperUmValorEdForm }

function TCxOperUmValorEdForm.ControlesOk: boolean;
begin
  if TrabPageControl.ActivePage = ValorTabSheet then
  begin
    Result := FValorNumEdit.AsCurrency > ZERO_CURRENCY;
    if not Result then
    begin
      ErroOutput.Exibir('Valor � obrigat�rio');
      FValorNumEdit.SetFocus;
    end;
    exit;
  end;

end;

pagamento
CxVal

procedure TCxOperUmValorEdForm.ControlesToEnt;
begin
  inherited;
  if TrabPageControl.ActivePage = ValorTabSheet then
  begin
    CxOperacaoEnt.Valor := FValorNumEdit.AsCurrency;
    exit;
  end;
end;

constructor TCxOperUmValorEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);

  FValorNumEdit := TNumEditBtu.Create(Self);
  FValorNumEdit.Parent := ValorTabSheet;
  FValorNumEdit.Alignment := taRightJustify;
  FValorNumEdit.NCasas := 2;
  FValorNumEdit.NCasasEsq := 7;
  FValorNumEdit.Caption := 'Valor R$';
  FValorNumEdit.LabelPosition := lpLeft;
  FValorNumEdit.LabelSpacing := 4;
  FValorNumEdit.Font.Assign(ValorEdit.Font);
  FValorNumEdit.StyleElements := ValorEdit.StyleElements;

  PegueFormatoDe(FValorNumEdit, ValorEdit);

  FNumerarioListFrame := TNumerarioListFrame.Create(NumerarioTabSheet,
    pCxValorDBI, AppObj.AppInfo.PastaImg + 'App\Numerario\Indiv\');
end;

procedure TCxOperUmValorEdForm.EntToControles;
begin
  inherited;
  FValorNumEdit.Valor := CxOperacaoEnt.Valor;
end;

procedure TCxOperUmValorEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  TrabPageControl.ActivePage := ValorTabSheet;
  FValorNumEdit.valor := 18;
  ObsMemo.Lines.text := 'Abertra teste';
  OkAct_Diag.Execute;
//  TrabPageControl.ActivePage := NumerarioTabSheet;
end;

procedure TCxOperUmValorEdForm.TrabPageControlChange(Sender: TObject);
begin
  inherited;
  if TrabPageControl.ActivePage = ValorTabSheet then
    FValorNumEdit.SetFocus
  else if TrabPageControl.ActivePage = NumerarioTabSheet then
    FNumerarioListFrame.SelecionePrimeiro;
end;

end.
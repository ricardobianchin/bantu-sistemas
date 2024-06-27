unit App.UI.Form.Bas.Ed.Pess_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, App.Ent.DBI, App.AppInfo, App.Pess.Ent,
  App.Pess.DBI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, App.Pess.Ender.Frame_u,
  Vcl.ComCtrls;

type
  TPessEdBasForm = class(TEdBasForm)
    NomePessLabel: TLabel;
    NomePessEdit: TEdit;
    NomeFantaPessLabel: TLabel;
    NomeFantaPessEdit: TEdit;
    ApelidoPessLabel: TLabel;
    ApelidoPessEdit: TEdit;
    CPessLabel: TLabel;
    CPessEdit: TEdit;
    IPessLabel: TLabel;
    IPessEdit: TEdit;
    MPessLabel: TLabel;
    MPessEditEdit: TEdit;
    MUFPessLabel: TLabel;
    MUFPessEdit: TEdit;
    EMailPessEdit: TEdit;
    EMailPessLabel: TLabel;
    EnderecoPanel: TPanel;
    DtNascDateTimePicker: TDateTimePicker;
    DtNascPessLabel: TLabel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure NomePessEditKeyPress(Sender: TObject; var Key: Char);
    procedure NomeFantaPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure ApelidoPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure CPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure IPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure MPessEditEditKeyPress(Sender: TObject; var Key: Char);
    procedure MUFPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure EMailPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure DtNascDateTimePickerKeyPress(Sender: TObject; var Key: Char);
    procedure OkAct_DiagExecute(Sender: TObject);
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;

    FEnderFrame: TEnderFrame;

    procedure PreenchaControles;
  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PessEdBasForm: TPessEdBasForm;

implementation

{$R *.dfm}

uses App.Pess.Ent.Factory_u, Sis.UI.Controls.TLabeledEdit, Sis.Types.Dates;

procedure TPessEdBasForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sDes: string;
begin
  inherited;
  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sNom := FPessEnt.NomeEnt;
        sDes := FPessEnt.Nome;

        sFormat := 'Alterando %s: %s';
        sCaption := Format(sFormat, [sNom, sDes]);
      end;

    dsInsert:
      ;
  end;
  FEnderFrame.AjusteControles;
  NomePessEdit.SetFocus;
end;

procedure TPessEdBasForm.ApelidoPessEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

function TPessEdBasForm.ControlesOk: boolean;
begin
  Result := TesteEditVazio(NomePessEdit, 'Nome', ErroOutput);
  if not Result then
    exit;

end;

procedure TPessEdBasForm.ControlesToEnt;
begin
  inherited;
  FPessEnt.Nome := NomePessEdit.Text;
  FPessEnt.NomeFantasia := NomeFantaPessEdit.Text;
  FPessEnt.Apelido := ApelidoPessEdit.Text;
  FPessEnt.C := CPessEdit.Text;
  FPessEnt.I := IPessEdit.Text;
  FPessEnt.M := MPessEditEdit.Text;
  FPessEnt.MUF := MUFPessEdit.Text;
  FPessEnt.EMail := EMailPessEdit.Text;

  FPessEnt.DtNasc := DtNascDateTimePicker.Date;

  FEnderFrame.ControlesToEnt;
end;

procedure TPessEdBasForm.CPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

constructor TPessEdBasForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited;
  FPessEnt := EntEdCastToPessEnt(pEntEd);
  FPessDBI := EntDBICastToPessDBI(pEntDBI);

  FEnderFrame := TEnderFrame.Create(EnderecoPanel, FPessEnt, FPessDBI, pAppInfo,
    OkAct_DiagExecute);

  DtNascDateTimePicker.Time := 0;
  DtNascDateTimePicker.Date := Date;
end;

function TPessEdBasForm.DadosOk: boolean;
begin

end;

procedure TPessEdBasForm.DtNascDateTimePickerKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.EMailPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.EntToControles;
begin
  inherited;
  NomePessEdit.Text := FPessEnt.Nome;
  NomeFantaPessEdit.Text := FPessEnt.NomeFantasia;
  ApelidoPessEdit.Text := FPessEnt.Apelido;
  CPessEdit.Text := FPessEnt.C;
  IPessEdit.Text := FPessEnt.I;
  MPessEditEdit.Text := FPessEnt.M;
  MUFPessEdit.Text := FPessEnt.MUF;
  EMailPessEdit.Text := FPessEnt.EMail;
  DtNascDateTimePicker.Date := GetValidDate(FPessEnt.DtNasc);

  FEnderFrame.EntToControles;
end;

function TPessEdBasForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sId, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := EntEd.NomeEnt;
  if EntEd.State = dsInsert then
    sVal := ''
  else
    sVal := FPessEnt.CodAsString;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TPessEdBasForm.GravouOk: boolean;
begin

end;

procedure TPessEdBasForm.IPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.MPessEditEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.MUFPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.NomeFantaPessEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.NomePessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.OkAct_DiagExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TPessEdBasForm.PreenchaControles;
begin

end;

procedure TPessEdBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  NomePessEdit.SetFocus;
end;

end.

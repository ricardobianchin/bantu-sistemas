unit App.DB.Import.Prod.Ed.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TDBImportProdEdForm = class(TDiagBtnBasForm)
    SelCheckBox: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBImportProdEdForm: TDBImportProdEdForm;

implementation

{$R *.dfm}

end.

unit App.UI.Form.Bas.Modulo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.Modulo.Types,
  Sis.Modulo;

type
  TModuloBasForm = class(TBasForm)
  private
    { Private declarations }
    FModuloSistema: IModuloSistema;

  public
    { Public declarations }
  end;

  TModuloBasFormClass = class of TModuloBasForm;

var
  ModuloBasForm: TModuloBasForm;

implementation

{$R *.dfm}

{ TModuloBasForm }

//constructor TModuloBasForm.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//  FTipoModuloSistema := moduloNaoIndicado;;
//end;

end.

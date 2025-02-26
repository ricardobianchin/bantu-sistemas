unit App.PDV.UI.Balanca;

interface

type
  IBalanca = interface(IInterface)
    ['{D9333B1B-BE54-4134-B467-5CE082EBA73D}']
    procedure LePeso(out pPeso: Currency; out pDeuErro: Boolean; out pMensagem: string);

    function GetHabilitada: Boolean;
    property Habilitada: Boolean read GetHabilitada;
  end;

implementation

end.

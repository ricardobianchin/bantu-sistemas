unit Sis.Entidade;

interface

type
  IEntidade = interface(IInterface)
    ['{A5EA36DE-B06C-4876-96BB-B07E41FC834B}']
    function EhIgualA(pOutraEntidade: IEntidade): boolean;
    procedure PegueDe(pOutraEntidade: IEntidade);
    procedure Clear;
  end;


implementation

end.

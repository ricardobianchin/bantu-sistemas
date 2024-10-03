unit Sis.DB.Terminal;

interface

uses Sis.Entities.Types;

type
  ITerminal = interface(IInterface)
    ['{94645E77-89FD-4CB3-82DC-E2E659C19D8C}']
    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    function GetApelido: string;
    procedure SetApelido(Value: string);
    property Apelido: string read GetApelido write SetApelido;

    function GetNomeDaRede: string;
    procedure SetNomeDaRede(Value: string);
    property NomeDaRede: string read GetNomeDaRede write SetNomeDaRede;

    function GetNFSerie: smallint;
    procedure SetNFSerie(Value: smallint);
    property NFSerie: smallint read GetNFSerie write SetNFSerie;

    function GetLetraDoDrive: string;
    procedure SetLetraDoDrive(Value: string);
    property LetraDoDrive: string read GetLetraDoDrive write SetLetraDoDrive;

    function GetGavetaTem: Boolean;
    procedure SetGavetaTem(Value: Boolean);
    property GavetaTem: Boolean read GetGavetaTem write SetGavetaTem;

    function GetBalancaModoId: smallint;
    procedure SetBalancaModoId(Value: smallint);
    property BalancaModoId: smallint read GetBalancaModoId write SetBalancaModoId;

    function GetBalancaId: smallint;
    procedure SetBalancaId(Value: smallint);
    property BalancaId: smallint read GetBalancaId write SetBalancaId;

    function GetBarCodigoIni: smallint;
    procedure SetBarCodigoIni(Value: smallint);
    property BarCodigoIni: smallint read GetBarCodigoIni write SetBarCodigoIni;

    function GetBarCodigoTam: smallint;
    procedure SetBarCodigoTam(Value: smallint);
    property BarCodigoTam: smallint read GetBarCodigoTam write SetBarCodigoTam;

    function GetCupomNLinsFinal: smallint;
    procedure SetCupomNLinsFinal(Value: smallint);
    property CupomNLinsFinal: smallint read GetCupomNLinsFinal write SetCupomNLinsFinal;

    function GetSempreOffLine: Boolean;
    procedure SetSempreOffLine(Value: Boolean);
    property SempreOffLine: Boolean read GetSempreOffLine write SetSempreOffLine;
  end;

implementation

end.

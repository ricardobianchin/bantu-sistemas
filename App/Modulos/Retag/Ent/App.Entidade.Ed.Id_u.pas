unit App.Entidade.Ed.Id_u;

interface

uses App.Entidade.Ed.Id, Data.DB, App.Entidade.Ed_u, Sis.Entidade;

type
  TEntEdId = class(TEntEd, IEntEdId)
  private
    FId: integer;
  protected
    function GetId: integer; virtual;
    procedure SetId(Value: integer); virtual;

    function GetAsString: string; virtual;
  public
    property Id: integer read GetId write SetId;
    property AsString: string read GetAsString;

    constructor Create(pState: TDataSetState; pId: integer = 0);

    function EhIgualA(pOutraEntidade: IEntidade): boolean; override;
    procedure PegueDe(pOutraEntidade: IEntidade); override;

    procedure Clear; override;
  end;

implementation

uses System.SysUtils;

{ TEntEdId }

procedure TEntEdId.Clear;
begin
  inherited Clear;
  FId := 0;
end;

constructor TEntEdId.Create(pState: TDataSetState; pId: integer);
begin
  inherited Create(pState);
  FId := pId;
end;

function TEntEdId.EhIgualA(pOutraEntidade: IEntidade): boolean;
begin
  Result := Supports(Self, IEntEdId);
  if not Result then
    exit;

  Result := Supports(pOutraEntidade, IEntEdId);
  if not Result then
    exit;

  Result := State = dsInsert;
  if Result then
    exit;

  Result := FId = IEntEdId(pOutraEntidade).Id;
end;

function TEntEdId.GetAsString: string;
begin
  Result := IntToStr(FId);
end;

function TEntEdId.GetId: integer;
begin
  Result := FId;
end;

procedure TEntEdId.PegueDe(pOutraEntidade: IEntidade);
begin
  inherited;
  FId := TEntEdId(pOutraEntidade).Id;
end;

procedure TEntEdId.SetId(Value: integer);
begin
  FId := Value;
end;

end.


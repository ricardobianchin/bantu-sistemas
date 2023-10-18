unit btu.lib.db.exec_u;

interface

uses
  btu.lib.db.types
  , btu.lib.db.dbms
  , btu.sis.ui.io.output
  , btu.sis.ui.io.log
  , btu.lib.db.sqloperation_u
  , FireDAC.Stan.Param
  , System.Classes
  , Data.DB
  ;

type
  TDBExec = class(TDBSqlOperation, IDBExec)
  protected
  public
    procedure Execute; virtual; abstract;
  end;

implementation

end.
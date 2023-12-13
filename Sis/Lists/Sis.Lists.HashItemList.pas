unit Sis.Lists.HashItemList;

interface

uses Sis.Lists.HashItem, Sis.Lists.IdItemList;

type
  TFunctionHashItemCreateRef = reference to function(s:string=''; pCod:integer=0):IHashItem;

  IHashItemList = interface(IIdItemList)
    function PegarHash( pDescr:string=''; pCod:integer=0; pEvitaRepeditos:boolean=false):IHashItem;
    function DescrToHashItem(pDescr:string):IHashItem;
    function GarantaDescr(pDescr:string; pCreatProc:TFunctionHashItemCreateRef):IHashItem;
    function GetHashItemList(Index:integer):IHashItemList;
    property HashItemList[Index:integer]:IHashItemList read GetHashItemList;default;
  end;

implementation

end.

inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientWidth = 624
  ExplicitWidth = 636
  TextHeight = 15
  inherited TopoPanel: TPanel
    Width = 624
    ExplicitWidth = 620
    object MoldeFileSelectPanel: TPanel [0]
      Left = 1
      Top = 8
      Width = 530
      Height = 24
      Caption = 'MoldeFileSelectPanel'
      TabOrder = 0
    end
    inherited ExecuteBitBtn: TBitBtn
      TabOrder = 1
    end
    inherited ZerarBitBtn: TBitBtn
      TabOrder = 2
    end
  end
  inherited BasePanel: TPanel
    Top = 474
    Width = 624
  end
  inherited MeioPanel: TPanel
    Width = 624
    ExplicitWidth = 620
    inherited SplitterStatusMemo: TSplitter
      Width = 624
      ExplicitTop = 307
      ExplicitWidth = 624
    end
    inherited StatusMemo: TMemo
      Width = 624
      ExplicitWidth = 620
    end
    inherited GridsPanel: TPanel
      Width = 624
      ExplicitWidth = 620
      inherited ProdDBGrid: TDBGrid
        Width = 624
      end
    end
  end
  inherited StatusPanel: TPanel
    Top = 448
    Width = 624
    ExplicitTop = 448
    ExplicitWidth = 624
  end
  inherited ActionList_AppDBImport: TActionList
    inherited ExecuteAction_AppDBImport: TAction
      OnExecute = ExecuteAction_AppDBImportExecute
    end
    inherited AtualizarAction_AppDBImport: TAction
      OnExecute = AtualizarAction_AppDBImportExecute
    end
  end
end

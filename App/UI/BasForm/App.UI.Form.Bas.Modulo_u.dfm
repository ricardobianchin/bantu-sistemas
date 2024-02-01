inherited ModuloBasForm: TModuloBasForm
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'ModuloBasForm'
  ClientHeight = 476
  ClientWidth = 620
  KeyPreview = True
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  ExplicitWidth = 620
  ExplicitHeight = 476
  TextHeight = 15
  object TitleBarPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 620
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Caption = '   '
    Color = 3813420
    ParentBackground = False
    TabOrder = 0
    StyleElements = []
    DesignSize = (
      620
      30)
    object TitleBarTextCaptionLabel: TLabel
      Left = 105
      Top = 8
      Width = 130
      Height = 15
      Caption = 'TitleBarTextCaptionLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14597805
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object ToolBar1: TToolBar
      Left = 514
      Top = 3
      Width = 101
      Height = 23
      Align = alNone
      Anchors = [akTop, akRight]
      ButtonWidth = 47
      Caption = 'ToolBar1'
      Flat = False
      Images = SisImgDataModule.ImageList_40_24
      TabOrder = 0
      StyleElements = []
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = OcultarAction_ModuloBasForm
      end
      object FecharToolButton: TToolButton
        Left = 47
        Top = 0
        Action = FecharAction_ModuloBasForm
      end
    end
    object ToolBar2: TToolBar
      Left = 0
      Top = 3
      Width = 103
      Height = 22
      Align = alNone
      ButtonWidth = 47
      Caption = 'ToolBar1'
      Flat = False
      Images = SisImgDataModule.ImageList_40_24
      TabOrder = 1
      StyleElements = []
      object MenuToolButton: TToolButton
        Left = 0
        Top = 0
        Action = MenuAction_ModuloBasForm
      end
      object ToolButton3: TToolButton
        Left = 47
        Top = 0
        Action = TrocarAction_ModuloBasForm
      end
    end
  end
  object TitleBarActionList_ModuloBasForm: TActionList
    Images = SisImgDataModule.ImageList_40_24
    Left = 368
    Top = 88
    object FecharAction_ModuloBasForm: TAction
      Caption = 'Fechar'
      ImageIndex = 0
      OnExecute = FecharAction_ModuloBasFormExecute
    end
    object OcultarAction_ModuloBasForm: TAction
      Caption = 'OcultarAction_ModuloBasForm'
      Hint = 'Ocultar'
      ImageIndex = 4
      OnExecute = OcultarAction_ModuloBasFormExecute
    end
    object MenuAction_ModuloBasForm: TAction
      Caption = 'Menu'
      Hint = 'Menu (F2)'
      ImageIndex = 5
      OnExecute = MenuAction_ModuloBasFormExecute
    end
    object TrocarAction_ModuloBasForm: TAction
      Caption = 'TrocarAction_ModuloBasForm'
      Hint = 'Trocar (F6)'
      ImageIndex = 6
      OnExecute = TrocarAction_ModuloBasFormExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 96
    object FecharActionModuloBasForm1: TMenuItem
      Action = FecharAction_ModuloBasForm
    end
  end
end

inherited TreeViewFrame: TTreeViewFrame
  object TitLabel: TLabel
    Left = 0
    Top = 0
    Width = 385
    Height = 20
    Align = alTop
    Caption = 'TitLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = []
    ExplicitWidth = 53
  end
  object CaminhoLabel: TLabel
    Left = 0
    Top = 20
    Width = 385
    Height = 13
    Align = alTop
    Caption = 'CaminhoLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = []
    ExplicitWidth = 73
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 33
    Width = 385
    Height = 143
    Align = alClient
    BorderStyle = bsNone
    Indent = 19
    TabOrder = 0
    OnChange = TreeView1Change
    OnKeyPress = TreeView1KeyPress
  end
end

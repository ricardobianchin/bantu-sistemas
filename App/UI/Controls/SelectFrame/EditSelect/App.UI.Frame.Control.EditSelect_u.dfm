inherited SelectEditFrame: TSelectEditFrame
  Width = 490
  Height = 42
  ExplicitWidth = 490
  ExplicitHeight = 42
  object FundoPanel: TPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 42
    Align = alClient
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 402
    ExplicitHeight = 45
    object TitLabel: TLabel
      Left = 3
      Top = 1
      Width = 41
      Height = 15
      Caption = 'TitLabel'
    end
    object BuscaLabeledEdit: TLabeledEdit
      Left = 153
      Top = 16
      Width = 103
      Height = 23
      EditLabel.Width = 31
      EditLabel.Height = 23
      EditLabel.Caption = 'Busca'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 0
      Text = ''
    end
    object ValorLabeledEdit: TLabeledEdit
      Left = 287
      Top = 16
      Width = 200
      Height = 23
      EditLabel.Width = 3
      EditLabel.Height = 15
      EditLabel.Caption = ' '
      ReadOnly = True
      TabOrder = 1
      Text = ''
      OnKeyPress = ValorLabeledEditKeyPress
    end
    object BuscaBitBtn: TBitBtn
      Left = 257
      Top = 15
      Width = 25
      Height = 25
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB08C
        5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFB08C5EB08C5EB08C5EFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB08C5EB08C5EB08C
        5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB08C5EB08C5EB08C5EB0
        8C5EFF00FFB08C5EB08C5EB08C5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFB08C5EFFFFFFFFFFFFFFFFFFFFFFFFB08C5EB08C5EB08C5EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFB08C5EFFFFFFFFFFFFC0C0C0C0C0C0FF
        FFFFFFFFFFB08C5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB08C5E
        FFFFFFFFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB08C5EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFB08C5EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFB08C5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB08C5E
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB08C5EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFB08C5EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFB08C5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        B08C5EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB08C5EFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB08C5EFFFFFFFFFFFFFFFFFFFF
        FFFFB08C5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFB08C5EB08C5EB08C5EB08C5EFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
    end
  end
end

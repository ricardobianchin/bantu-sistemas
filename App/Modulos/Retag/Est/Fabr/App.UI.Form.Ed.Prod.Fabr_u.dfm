inherited ProdFabrEdForm: TProdFabrEdForm
  Caption = 'ProdFabrEdForm'
  ClientWidth = 483
  ExplicitWidth = 499
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 225
    Width = 483
    ExplicitTop = 225
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 210
    Width = 483
    ExplicitTop = 210
  end
  object LabeledEdit1: TLabeledEdit [3]
    Left = 8
    Top = 48
    Width = 260
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    MaxLength = 20
    TabOrder = 1
    Text = ''
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
  inherited BasePanel: TPanel
    Width = 483
    ExplicitTop = 249
    ExplicitWidth = 483
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 68
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 181
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 261
    end
  end
end

inherited ProdUnidEdForm: TProdUnidEdForm
  Caption = 'ProdUnidEdForm'
  ClientWidth = 495
  ExplicitWidth = 507
  ExplicitHeight = 305
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 495
    ExplicitTop = 195
  end
  inherited ObjetivoLabel: TLabel
    Width = 9
    Caption = '   '
    ExplicitWidth = 9
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 495
    ExplicitTop = 215
  end
  object DescrLabeledEdit: TLabeledEdit [3]
    Left = 8
    Top = 48
    Width = 260
    Height = 23
    EditLabel.Width = 51
    EditLabel.Height = 15
    EditLabel.Caption = 'Descri'#231#227'o'
    MaxLength = 40
    TabOrder = 0
    Text = ''
    OnChange = DescrLabeledEditChange
    OnKeyPress = DescrLabeledEditKeyPress
  end
  object SiglaLabeledEdit: TLabeledEdit [4]
    Left = 273
    Top = 48
    Width = 80
    Height = 23
    EditLabel.Width = 25
    EditLabel.Height = 15
    EditLabel.Caption = 'Sigla'
    TabOrder = 1
    Text = ''
    OnChange = SiglaLabeledEditChange
    OnKeyPress = SiglaLabeledEditKeyPress
  end
  inherited BasePanel: TPanel
    Width = 495
    TabOrder = 2
    ExplicitTop = 231
    ExplicitWidth = 495
    DesignSize = (
      495
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 8
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 121
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 222
    end
  end
end

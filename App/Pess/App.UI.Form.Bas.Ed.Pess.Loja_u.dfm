inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  ClientWidth = 957
  ExplicitWidth = 973
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 957
    ExplicitTop = 465
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 957
    ExplicitTop = 485
  end
  inherited NomePessLabel: TLabel
    Width = 65
    Caption = 'Raz'#227'o Social'
    ExplicitWidth = 65
  end
  object AtivoCheckBox: TCheckBox [12]
    Left = 448
    Top = 122
    Width = 97
    Height = 17
    Caption = 'Ativo'
    TabOrder = 13
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  inherited BasePanel: TPanel
    Width = 957
    ExplicitTop = 501
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 561
      ExplicitLeft = 561
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 674
      ExplicitLeft = 674
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 754
      ExplicitLeft = 754
    end
  end
  inherited NomePessEdit: TEdit
    Left = 78
    OnKeyPress = nil
    ExplicitLeft = 78
  end
  inherited NomeFantaPessEdit: TEdit
    TabOrder = 9
  end
  inherited ApelidoPessEdit: TEdit
    TabOrder = 1
  end
  inherited CPessEdit: TEdit
    TabOrder = 2
  end
  inherited IPessEdit: TEdit
    TabOrder = 3
  end
  inherited MPessEditEdit: TEdit
    TabOrder = 4
  end
  inherited MUFPessEdit: TEdit
    TabOrder = 5
  end
  inherited EMailPessEdit: TEdit
    TabOrder = 6
  end
  inherited EnderecoPanel: TPanel
    TabOrder = 7
  end
end

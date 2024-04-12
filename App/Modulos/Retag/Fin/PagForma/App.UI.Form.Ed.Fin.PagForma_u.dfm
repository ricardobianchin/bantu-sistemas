inherited PagFormaEdForm: TPagFormaEdForm
  Caption = 'PagFormaEdForm'
  ClientHeight = 282
  ClientWidth = 590
  OnCreate = FormCreate
  ExplicitWidth = 602
  ExplicitHeight = 320
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 210
    Width = 590
    ExplicitTop = 211
  end
  object TipoTitLabel: TLabel [2]
    Left = 160
    Top = 75
    Width = 20
    Height = 15
    Caption = 'Uso'
  end
  object Label1: TLabel [3]
    Left = 274
    Top = 75
    Width = 70
    Height = 15
    Caption = 'Recebimento'
  end
  object Label2: TLabel [4]
    Left = 3
    Top = 75
    Width = 23
    Height = 15
    Caption = 'Tipo'
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 230
    Width = 590
    ExplicitTop = 231
  end
  object DescrErroLabel: TLabel [6]
    Left = 2
    Top = 49
    Width = 78
    Height = 15
    Caption = 'DescrErroLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = []
  end
  object DescrRedErroLabel: TLabel [7]
    Left = 393
    Top = 49
    Width = 98
    Height = 15
    Caption = 'DescrRedErroLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = []
  end
  inherited BasePanel: TPanel
    Top = 245
    Width = 590
    ExplicitTop = 244
    ExplicitWidth = 620
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 191
      ExplicitLeft = 221
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 304
      ExplicitLeft = 334
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 384
      ExplicitLeft = 414
    end
  end
  object UsoComboBox: TComboBox [9]
    Left = 184
    Top = 71
    Width = 81
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 1
    Text = 'COMPRA'
    Items.Strings = (
      'VENDA'
      'COMPRA')
  end
  object AtivoCheckBox: TCheckBox [10]
    Left = 438
    Top = 74
    Width = 49
    Height = 17
    Caption = 'Ativa'
    TabOrder = 2
  end
  object DescrLabeledEdit: TLabeledEdit [11]
    Left = 58
    Top = 27
    Width = 329
    Height = 23
    EditLabel.Width = 51
    EditLabel.Height = 23
    EditLabel.Caption = 'Descri'#231#227'o'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 8
    Text = ''
  end
  object AdminstradoraGroupBox: TGroupBox [12]
    Left = 3
    Top = 108
    Width = 273
    Height = 45
    Caption = 'Administradora'
    TabOrder = 7
    object MoldeTaxaAdmLabeledEdit: TLabeledEdit
      Left = 55
      Top = 17
      Width = 53
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 44
      EditLabel.Height = 23
      EditLabel.Caption = 'Taxa (%)'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 0
      Text = '123,45'
    end
    object MoldeReembolsoDiasLabeledEdit: TLabeledEdit
      Left = 213
      Top = 17
      Width = 53
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 92
      EditLabel.Height = 23
      EditLabel.Caption = 'Reembolso (Dias)'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 1
      Text = '123,45'
    end
  end
  object DescrRedLabeledEdit: TLabeledEdit [13]
    Left = 499
    Top = 27
    Width = 82
    Height = 23
    EditLabel.Width = 102
    EditLabel.Height = 23
    EditLabel.Caption = 'Descri'#231#227'o Reduzida'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 9
    Text = ''
  end
  object VendaExigeGroupBox: TGroupBox [14]
    Left = 3
    Top = 163
    Width = 408
    Height = 45
    Caption = 'Na Venda, Exige'
    TabOrder = 5
    object AutorizExigeCheckBox: TCheckBox
      Left = 82
      Top = 19
      Width = 87
      Height = 17
      Caption = 'Autoriza'#231#227'o'
      TabOrder = 1
    end
    object CliExigeCheckBox: TCheckBox
      Left = 8
      Top = 19
      Width = 65
      Height = 17
      Caption = 'Cliente'
      TabOrder = 0
    end
    object MoldeValorMinimoLabeledEdit: TLabeledEdit
      Left = 328
      Top = 17
      Width = 75
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 95
      EditLabel.Height = 23
      EditLabel.Caption = 'Valor M'#237'nimo (R$)'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 3
      Text = '123,45'
    end
    object TefExigeCheckBox: TCheckBox
      Left = 178
      Top = 19
      Width = 44
      Height = 17
      Caption = 'TEF'
      TabOrder = 2
    end
  end
  object ComissGroupBox: TGroupBox [15]
    Left = 283
    Top = 108
    Width = 204
    Height = 45
    Caption = 'Comiss'#227'o'
    TabOrder = 6
    object ComissPermiteCheckBox: TCheckBox
      Left = 8
      Top = 19
      Width = 63
      Height = 17
      Caption = 'Permite'
      TabOrder = 0
    end
    object MoldeComissAbaterLabeledEdit: TLabeledEdit
      Left = 146
      Top = 17
      Width = 53
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 56
      EditLabel.Height = 23
      EditLabel.Caption = 'Abater (%)'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 1
      Text = '123,45'
    end
  end
  object TipoComboBox: TComboBox [16]
    Left = 30
    Top = 71
    Width = 122
    Height = 23
    Style = csDropDownList
    ItemIndex = 3
    TabOrder = 4
    Text = 'TRANSFERENCIA'
    Items.Strings = (
      'DINHEIRO'
      'DEBITO'
      'CREDITO'
      'TRANSFERENCIA')
  end
  object PromoGroupBox: TGroupBox [17]
    Left = 493
    Top = 108
    Width = 86
    Height = 45
    Caption = 'Promo'#231#227'o'
    TabOrder = 10
    object PromoPermiteCheckBox: TCheckBox
      Left = 8
      Top = 19
      Width = 122
      Height = 17
      Caption = 'Permite'
      TabOrder = 0
    end
  end
  object RecebComboBox: TComboBox [18]
    Left = 347
    Top = 71
    Width = 81
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 3
    Text = 'A PRAZO'
    Items.Strings = (
      'A VISTA'
      'A PRAZO')
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 426
    Top = 155
  end
  inherited ActionList1_Diag: TActionList
    Left = 433
    Top = 164
  end
end

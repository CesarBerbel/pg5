object frmSuit: TfrmSuit
  Left = 819
  Top = 238
  Width = 432
  Height = 288
  BorderIcons = []
  Caption = 'Criar Nova Suit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 11
    Top = 10
    Width = 28
    Height = 13
    Caption = 'Nome'
  end
  object Label2: TLabel
    Left = 11
    Top = 58
    Width = 48
    Height = 13
    Caption = 'Descrição'
  end
  object btnCriar: TButton
    Left = 11
    Top = 208
    Width = 105
    Height = 31
    Caption = 'Criar Suit'
    TabOrder = 0
    OnClick = btnCriarClick
  end
  object btnCancelar: TButton
    Left = 130
    Top = 208
    Width = 105
    Height = 31
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 1
  end
  object txtNome: TDBEdit
    Left = 11
    Top = 28
    Width = 393
    Height = 21
    DataField = 'nmSuit'
    DataSource = frmPrincipal.dsSuits
    TabOrder = 2
  end
  object mmDescricao: TDBMemo
    Left = 11
    Top = 78
    Width = 393
    Height = 123
    DataField = 'dsSuit'
    DataSource = frmPrincipal.dsSuits
    TabOrder = 3
  end
end

object frmBuild: TfrmBuild
  Left = 436
  Top = 413
  Width = 430
  Height = 343
  BorderIcons = []
  Caption = 'Criar Novo build'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 18
    Top = 18
    Width = 32
    Height = 13
    Caption = 'BUILD'
  end
  object Label2: TLabel
    Left = 18
    Top = 122
    Width = 48
    Height = 13
    Caption = 'Descrição'
  end
  object Label3: TLabel
    Left = 18
    Top = 70
    Width = 32
    Height = 13
    Caption = 'Cliente'
  end
  object btCriar: TButton
    Left = 18
    Top = 264
    Width = 105
    Height = 31
    Caption = 'Criar Build'
    Default = True
    TabOrder = 0
    OnClick = btCriarClick
  end
  object btCancelar: TButton
    Left = 132
    Top = 264
    Width = 105
    Height = 31
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 1
  end
  object txtBuild: TDBEdit
    Left = 18
    Top = 36
    Width = 383
    Height = 21
    DataField = 'nmBuild'
    DataSource = frmPrincipal.dsBuild
    TabOrder = 2
  end
  object txtCliente: TDBEdit
    Left = 18
    Top = 88
    Width = 383
    Height = 21
    DataField = 'cdCliente'
    DataSource = frmPrincipal.dsBuild
    TabOrder = 3
  end
  object mmDescricao: TDBMemo
    Left = 18
    Top = 140
    Width = 383
    Height = 119
    DataField = 'dsBuild'
    DataSource = frmPrincipal.dsBuild
    TabOrder = 4
  end
end

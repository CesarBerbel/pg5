object fBuildNoturno: TfBuildNoturno
  Left = 308
  Top = 184
  Width = 299
  Height = 442
  Caption = 'Gerenciador Build Noturno'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cklTests: TCheckListBox
    Left = 0
    Top = 0
    Width = 283
    Height = 362
    Align = alClient
    ItemHeight = 13
    Items.Strings = (
      'a'
      'b'
      'c')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 362
    Width = 283
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btExecutar: TBitBtn
      Left = 17
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Executar'
      TabOrder = 0
      OnClick = btExecutarClick
    end
  end
end

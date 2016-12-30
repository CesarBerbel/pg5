object frmUsuario: TfrmUsuario
  Left = 404
  Top = 117
  Width = 387
  Height = 184
  Caption = 'Adicionar Usuário'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 36
    Height = 13
    Caption = 'Usuário'
  end
  object Label2: TLabel
    Left = 12
    Top = 62
    Width = 32
    Height = 13
    Caption = 'Cliente'
  end
  object txtNome: TDBEdit
    Left = 12
    Top = 29
    Width = 351
    Height = 21
    CharCase = ecUpperCase
    DataField = 'dsUsuario'
    DataSource = frmManipulaDados.dsUsuario
    TabOrder = 0
  end
  object txtCliente: TDBEdit
    Left = 12
    Top = 79
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    DataField = 'cdCliente'
    DataSource = frmManipulaDados.dsUsuario
    TabOrder = 1
  end
  object btnCriar: TButton
    Left = 12
    Top = 108
    Width = 105
    Height = 31
    Caption = 'Criar Usuário'
    Default = True
    TabOrder = 2
    OnClick = btnCriarClick
  end
  object btnCancelar: TButton
    Left = 126
    Top = 108
    Width = 105
    Height = 31
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object btnDeletar: TButton
    Left = 241
    Top = 108
    Width = 105
    Height = 31
    Caption = 'Deletar Usuário'
    Enabled = False
    TabOrder = 4
    OnClick = btnDeletarClick
  end
  object cmDeleta: TADOCommand
    CommandText = 
      'DELETE FROM ESAJUSUARIOLOGINTESTS WHERE DSUSUARIO= :NOME AND CDC' +
      'LIENTE = :CLIENTE'
    Connection = frmManipulaDados.conSQLite
    Parameters = <
      item
        Name = 'NOME'
        Attributes = [paNullable, paLong]
        DataType = ftFixedChar
        Size = 65536
        Value = Null
      end
      item
        Name = 'CLIENTE'
        Attributes = [paNullable, paLong]
        DataType = ftFixedChar
        Size = 65536
        Value = Null
      end>
    Left = 238
    Top = 70
  end
end

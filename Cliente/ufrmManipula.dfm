object frmManipulaDados: TfrmManipulaDados
  Left = 13
  Top = 41
  Width = 1936
  Height = 1066
  Caption = 'Manipulação dos Dados do Teste'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 5
    Top = 4
    Width = 165
    Height = 20
    Caption = 'Pesquisa de Coluna:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 359
    Top = 4
    Width = 62
    Height = 20
    Caption = 'Cliente:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 507
    Top = 4
    Width = 175
    Height = 20
    Caption = 'Pesquisa por Método:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grDados: TDBGrid
    Left = 8
    Top = 92
    Width = 1914
    Height = 928
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsPlanilha
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColExit = grDadosColExit
    OnKeyDown = grDadosKeyDown
  end
  object btnAddCampo: TButton
    Left = 892
    Top = 25
    Width = 154
    Height = 31
    Caption = 'Adicionar Campo'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnAddCampoClick
  end
  object btnCopiaLinha: TButton
    Left = 1075
    Top = 25
    Width = 130
    Height = 31
    Caption = 'Duplicar linha'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnCopiaLinhaClick
  end
  object txtProcuraCampo: TEdit
    Left = 5
    Top = 28
    Width = 336
    Height = 28
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnExit = txtProcuraCampoExit
    OnKeyDown = txtProcuraCampoKeyDown
  end
  object btnExcluiLinha: TButton
    Left = 1234
    Top = 25
    Width = 118
    Height = 31
    Caption = 'Excluir Linha'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnExcluiLinhaClick
  end
  object txtCliente: TEdit
    Left = 359
    Top = 28
    Width = 121
    Height = 28
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnChange = txtClienteChange
  end
  object btnExcluiCampo: TButton
    Left = 1439
    Top = 32
    Width = 129
    Height = 25
    Caption = 'Excluir Campo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btnExcluiCampoClick
  end
  object txtMetodo: TEdit
    Left = 507
    Top = 28
    Width = 367
    Height = 28
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnChange = txtMetodoChange
  end
  object pcAbas: TPageControl
    Left = 8
    Top = 60
    Width = 1439
    Height = 34
    ActivePage = TabSheet1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnChange = pcAbasChange
    object TabSheet1: TTabSheet
      Caption = 'DadosPrincipal'
    end
  end
  object gridTabelas: TDBGrid
    Left = 1548
    Top = 3
    Width = 372
    Height = 88
    DataSource = dsTabelas
    Options = [dgAlwaysShowSelection]
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    OnCellClick = gridTabelasCellClick
    OnDblClick = gridTabelasDblClick
    OnExit = gridTabelasExit
    Columns = <
      item
        Expanded = False
        FieldName = 'tabela'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Width = 500
        Visible = True
      end>
  end
  object btnUsar: TButton
    Left = 1360
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Usar Método'
    TabOrder = 10
    OnClick = btnUsarClick
  end
  object conSQLite: TADOConnection
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 108
    Top = 140
  end
  object qryPlanilha: TADOQuery
    Connection = conSQLite
    AfterOpen = qryPlanilhaAfterOpen
    AfterClose = qryPlanilhaAfterClose
    BeforePost = qryPlanilhaBeforePost
    Parameters = <>
    Left = 38
    Top = 138
  end
  object qryExecutor: TADOQuery
    Connection = conSQLite
    Parameters = <>
    Left = 30
    Top = 174
  end
  object qryCopiaLinha: TADOQuery
    Connection = conSQLite
    Parameters = <>
    Left = 32
    Top = 238
  end
  object dsCopiaLinha: TDataSource
    DataSet = qryCopiaLinha
    Left = 34
    Top = 276
  end
  object qryUsuario: TADOQuery
    Connection = conSQLite
    Parameters = <>
    SQL.Strings = (
      'select * from esajusuariologintests')
    Left = 240
    Top = 148
    object qryUsuariocdUsuario: TAutoIncField
      FieldName = 'cdUsuario'
    end
    object qryUsuariodsUsuario: TWideStringField
      FieldName = 'dsUsuario'
      Size = 100
    end
    object qryUsuariocdCliente: TWideStringField
      FieldName = 'cdCliente'
      Size = 10
    end
  end
  object dsUsuario: TDataSource
    DataSet = qryUsuario
    Left = 64
    Top = 174
  end
  object dsPlanilha: TDataSource
    Left = 72
    Top = 138
  end
  object cdsTabelas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 370
    Top = 316
    object cdsTabelastabela: TStringField
      FieldName = 'tabela'
      Size = 80
    end
  end
  object dsTabelas: TDataSource
    DataSet = cdsTabelas
    Left = 374
    Top = 354
  end
  object cdsAbas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 320
    object cdsAbasAba: TStringField
      FieldName = 'Aba'
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsAbas
    Left = 454
    Top = 368
  end
end

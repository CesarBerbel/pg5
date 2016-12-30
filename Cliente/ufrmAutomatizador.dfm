object frmPrincipal: TfrmPrincipal
  Left = 714
  Top = 0
  Anchors = [akLeft, akTop, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Automatizador'
  ClientHeight = 1011
  ClientWidth = 1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cbPreVisualizar: TCheckBox
    Left = 826
    Top = 6
    Width = 117
    Height = 17
    Caption = 'Pré-visualizar Árvore'
    TabOrder = 0
  end
  object btNovo: TButton
    Left = 0
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Novo Build'
    TabOrder = 1
    OnClick = btNovoClick
  end
  object btNovaSuit: TButton
    Left = 163
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Nova Suit'
    Enabled = False
    TabOrder = 2
    OnClick = btNovaSuitClick
  end
  object btRegistrar: TButton
    Left = 651
    Top = 0
    Width = 78
    Height = 25
    Caption = 'Registrar'
    TabOrder = 3
    OnClick = btRegistrarClick
  end
  object gridSuit: TDBCtrlGrid
    Left = 0
    Top = 106
    Width = 399
    Height = 100
    ColCount = 1
    DataSource = dsSuits
    PanelHeight = 100
    PanelWidth = 382
    TabOrder = 4
    RowCount = 1
    Visible = False
    object DBText1: TDBText
      Left = 6
      Top = 7
      Width = 369
      Height = 17
      DataField = 'nmSuit'
      DataSource = dsSuits
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 7
      Top = 29
      Width = 371
      Height = 68
      DataField = 'dsSuit'
      DataSource = dsSuits
      WordWrap = True
    end
  end
  object btnNovoTeste: TButton
    Left = 327
    Top = 0
    Width = 85
    Height = 25
    Caption = 'Novo Teste'
    Enabled = False
    TabOrder = 5
    OnClick = btnNovoTesteClick
  end
  object btnDados: TButton
    Left = 419
    Top = 0
    Width = 96
    Height = 25
    Caption = 'Ver Dados teste'
    Enabled = False
    TabOrder = 6
    OnClick = btnDadosClick
  end
  object gridTestes: TDBCtrlGrid
    Left = 400
    Top = 105
    Width = 503
    Height = 110
    ColCount = 1
    DataSource = dsTestes
    PanelHeight = 110
    PanelWidth = 486
    TabOrder = 7
    RowCount = 1
    Visible = False
    object Label1: TLabel
      Left = 10
      Top = 12
      Width = 73
      Height = 13
      Caption = 'Nome do Teste'
    end
    object Label3: TLabel
      Left = 400
      Top = 12
      Width = 54
      Height = 13
      Caption = 'Repetições'
    end
    object Label4: TLabel
      Left = 8
      Top = 64
      Width = 77
      Height = 13
      Caption = 'Método do teste'
    end
    object txtRepeticao: TDBEdit
      Left = 400
      Top = 27
      Width = 73
      Height = 21
      DataField = 'qtdRepeticao'
      DataSource = dsTestes
      TabOrder = 0
    end
    object cbNomeTeste: TDBLookupComboBox
      Left = 9
      Top = 27
      Width = 387
      Height = 21
      DataField = 'NomeTeste'
      DataSource = dsTestes
      DropDownRows = 50
      TabOrder = 1
      OnCloseUp = cbNomeTesteCloseUp
    end
    object txtMetodoTeste: TDBEdit
      Left = 8
      Top = 79
      Width = 469
      Height = 21
      DataField = 'dsNomeMetodo'
      DataSource = dsTestes
      Enabled = False
      TabOrder = 2
    end
  end
  object btnAbrir: TButton
    Left = 82
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Abrir Build'
    TabOrder = 8
    OnClick = btnAbrirClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 28
    Width = 955
    Height = 77
    Caption = 'Panel1'
    TabOrder = 9
    object txtBuild: TDBText
      Left = 10
      Top = 22
      Width = 65
      Height = 17
      DataField = 'nmBuild'
      DataSource = dsBuild
    end
    object TxtCliente: TDBText
      Left = 324
      Top = 22
      Width = 65
      Height = 17
      DataField = 'cdCliente'
      DataSource = dsBuild
    end
    object Label2: TLabel
      Left = 10
      Top = 6
      Width = 23
      Height = 13
      Caption = 'Build'
    end
    object Label5: TLabel
      Left = 324
      Top = 6
      Width = 32
      Height = 13
      Caption = 'Cliente'
    end
    object Label6: TLabel
      Left = 436
      Top = 6
      Width = 48
      Height = 13
      Caption = 'Descrição'
    end
    object mmDescricaoBuild: TDBMemo
      Left = 438
      Top = 22
      Width = 505
      Height = 51
      DataField = 'dsBuild'
      DataSource = dsBuild
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object btnEditar: TButton
    Left = 245
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Editar Suit'
    Enabled = False
    TabOrder = 10
    OnClick = btnEditarClick
  end
  object dsTestes: TDataSource
    DataSet = qryTestes
    Left = 984
    Top = 105
  end
  object dsSuits: TDataSource
    DataSet = qrySuits
    Left = 984
    Top = 77
  end
  object conSqlite: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source=SQLit' +
      'e3 Datasource;DataBase=D:\SQLite\PG5TESTE.db;'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    AfterDisconnect = conSqliteAfterDisconnect
    Left = 1012
    Top = 19
  end
  object qryTesteDisp: TADOQuery
    AutoCalcFields = False
    Connection = conSqlite
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from esajTestesDisponiveis')
    Left = 1012
    Top = 133
    object qryTesteDispidTeste: TAutoIncField
      FieldName = 'idTeste'
    end
    object qryTesteDispdsNomeTela: TWideStringField
      FieldName = 'dsNomeTela'
      Size = 100
    end
    object qryTesteDispdsNomeTeste: TWideStringField
      FieldName = 'dsNomeTeste'
      Size = 150
    end
    object qryTesteDispflAtivo: TBooleanField
      FieldName = 'flAtivo'
    end
  end
  object dsTesteDisp: TDataSource
    DataSet = qryTesteDisp
    Left = 984
    Top = 133
  end
  object qryTestes: TADOQuery
    Connection = conSqlite
    CursorType = ctStatic
    AfterOpen = qryTestesAfterOpen
    BeforePost = qryTestesBeforePost
    AfterScroll = qryTestesAfterScroll
    DataSource = dsSuits
    Parameters = <
      item
        Name = 'IDSUIT'
        Attributes = [paNullable, paLong]
        DataType = ftFixedChar
        Size = 65536
        Value = Null
      end>
    SQL.Strings = (
      'select * from esajTestesEmSuit where idSuit = :IDSUIT')
    Left = 1012
    Top = 105
    object qryTestesidSuit: TIntegerField
      FieldName = 'idSuit'
    end
    object qryTestesidTeste: TIntegerField
      FieldName = 'idTeste'
    end
    object qryTestesdtInsercao: TDateTimeField
      FieldName = 'dtInsercao'
    end
    object qryTestesqtdRepeticao: TIntegerField
      FieldName = 'qtdRepeticao'
    end
    object qryTestesdsNomeMetodo: TWideStringField
      FieldName = 'dsNomeMetodo'
      Size = 255
    end
    object qryTestesNomeTeste: TStringField
      FieldKind = fkLookup
      FieldName = 'NomeTeste'
      LookupDataSet = qryTesteDisp
      LookupKeyFields = 'idTeste'
      LookupResultField = 'dsNomeTeste'
      KeyFields = 'idTeste'
      LookupCache = True
      Size = 100
      Lookup = True
    end
  end
  object qrySuits: TADOQuery
    AutoCalcFields = False
    Connection = conSqlite
    CursorType = ctDynamic
    AfterOpen = qrySuitsAfterOpen
    AfterScroll = qrySuitsAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select * from esajSuitsTeste')
    Left = 1012
    Top = 77
    object qrySuitsidSuit: TAutoIncField
      FieldName = 'idSuit'
    end
    object qrySuitsnmSuit: TWideStringField
      FieldName = 'nmSuit'
      Size = 50
    end
    object qrySuitsdsSuit: TWideStringField
      FieldName = 'dsSuit'
      Size = 250
    end
    object qrySuitsdtCriacao: TDateTimeField
      FieldName = 'dtCriacao'
    end
  end
  object qryBuild: TADOQuery
    Connection = conSqlite
    CursorType = ctStatic
    AfterOpen = qryBuildAfterOpen
    AfterPost = qryBuildAfterPost
    Parameters = <>
    SQL.Strings = (
      'select * from esajBuild')
    Left = 1012
    Top = 48
    object qryBuildidBuild: TAutoIncField
      FieldName = 'idBuild'
    end
    object qryBuildnmBuild: TWideStringField
      FieldName = 'nmBuild'
      Size = 100
    end
    object qryBuilddsBuild: TWideStringField
      FieldName = 'dsBuild'
      Size = 350
    end
    object qryBuilddtCriacao: TDateTimeField
      FieldName = 'dtCriacao'
    end
    object qryBuildcdCliente: TWideStringField
      FieldName = 'cdCliente'
      Size = 10
    end
  end
  object qryExecutor: TADOQuery
    AutoCalcFields = False
    Connection = conSqlite
    Parameters = <>
    Left = 984
    Top = 19
  end
  object dsBuild: TDataSource
    DataSet = qryBuild
    Left = 984
    Top = 48
  end
  object dlgAbrir: TOpenDialog
    Left = 1012
    Top = 160
  end
  object dlgSalvar: TSaveDialog
    DefaultExt = 'db'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 984
    Top = 160
  end
end

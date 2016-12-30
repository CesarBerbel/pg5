unit ufrmAutomatizador;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, ADODB, Grids, DBGrids, inifiles, DBCtrls, Mask, dbcgrids, ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    conSqlite: TADOConnection;
    qryTestes: TADOQuery;
    qrySuits: TADOQuery;
    qryBuild: TADOQuery;
    dsTestes: TDataSource;
    dsSuits: TDataSource;
    cbPreVisualizar: TCheckBox;
    btNovo: TButton;
    btNovaSuit: TButton;
    btRegistrar: TButton;
    qryTesteDisp: TADOQuery;
    dsTesteDisp: TDataSource;
    qryTesteDispidTeste: TAutoIncField;
    qryTesteDispdsNomeTela: TWideStringField;
    qryTesteDispdsNomeTeste: TWideStringField;
    qryTesteDispflAtivo: TBooleanField;
    gridSuit: TDBCtrlGrid;
    qrySuitsidSuit: TAutoIncField;
    qrySuitsnmSuit: TWideStringField;
    qrySuitsdsSuit: TWideStringField;
    qrySuitsdtCriacao: TDateTimeField;
    qryTestesidSuit: TIntegerField;
    qryTestesidTeste: TIntegerField;
    qryTestesdtInsercao: TDateTimeField;
    qryBuildidBuild: TAutoIncField;
    qryBuildnmBuild: TWideStringField;
    qryBuilddsBuild: TWideStringField;
    qryBuilddtCriacao: TDateTimeField;
    qryTestesqtdRepeticao: TIntegerField;
    qryTestesdsNomeMetodo: TWideStringField;
    btnNovoTeste: TButton;
    qryTestesNomeTeste: TStringField;
    btnDados: TButton;
    qryExecutor: TADOQuery;
    gridTestes: TDBCtrlGrid;
    txtRepeticao: TDBEdit;
    cbNomeTeste: TDBLookupComboBox;
    txtMetodoTeste: TDBEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dsBuild: TDataSource;
    btnAbrir: TButton;
    dlgAbrir: TOpenDialog;
    Panel1: TPanel;
    txtBuild: TDBText;
    TxtCliente: TDBText;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    mmDescricaoBuild: TDBMemo;
    qryBuildcdCliente: TWideStringField;
    dlgSalvar: TSaveDialog;
    btnEditar: TButton;
    DBText1: TDBText;
    DBText2: TDBText;
    procedure Fact(Sender: TObject);
    procedure btNovaSuitClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btnNovoTesteClick(Sender: TObject);
    procedure qrySuitsAfterOpen(DataSet: TDataSet);
    procedure qryTestesBeforePost(DataSet: TDataSet);
    procedure btnDadosClick(Sender: TObject);
    procedure qryTestesAfterScroll(DataSet: TDataSet);
    procedure qryBuildAfterPost(DataSet: TDataSet);
    procedure btnAbrirClick(Sender: TObject);
    procedure conSqliteAfterDisconnect(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure qrySuitsAfterScroll(DataSet: TDataSet);
    procedure qryTestesAfterOpen(DataSet: TDataSet);
    procedure cbNomeTesteCloseUp(Sender: TObject);
    procedure qryBuildAfterOpen(DataSet: TDataSet);
    procedure btRegistrarClick(Sender: TObject);
    //    procedure cdsTestAfterScroll(DataSet: TDataSet);
  private
    procedure CriaNovoBuild;
    procedure FecharBD;
    function VerificarEstruturaBD: boolean;


    //estrutura antiga
    procedure AlterarIni(psTipoBuild: string);
    procedure btRegistrarm;
    procedure AjustarAlturaGridSuit;
    { Private declarations }
  public
    procedure CriarBuild(psNomeArquivo: string);
    procedure AbrirBD(psDataBase: string);
    function LerArquivoIni(psDataBase: string): string;
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  bComandoInt: boolean;
  FsBanco: string;

implementation

uses
  ufrmManipula, fpgGlobais, ufrmSuit, ufrmBuild, ufpgGUITestCase, ufpgTesteFactory, TestFramework;

{$R *.DFM}

procedure TfrmPrincipal.Fact(Sender: TObject);
begin
  //  cdsTest.Filtered := False;
  //  bComandoInt := True;
  //  cdsTest.Append;
  //  cdsTestNomeSuit.AsString := cdsSuitNomeSuit.AsString;
  //  cdsTestNome.AsString := lbTestesDisp.Items[lbTestesDisp.ItemIndex];
  //  cdsTestRepeticao.AsInteger := 1;
  //  //  cdsTestNomeTeste.AsString :=
  //  cdsTest.Post;
  //  lbTestesDisp.Visible := False;
  //  cdsTest.Filtered := True;
  //  gridTeste.Refresh;

end;

procedure TfrmPrincipal.AlterarIni(psTipoBuild: string);
var
  oArqIni: TIniFile;
begin
  oArqIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'spCFG.INI');
  try
    oArqIni.WriteString('DUNIT', 'BUILD', psTipoBuild);
  finally
    FreeAndNil(oArqIni);
  end;
end;

procedure TfrmPrincipal.btRegistrarm;
//var
//  oTeste: TfpgGuiTestCase;
begin

  //  if cdsSuit.IsEmpty or cdsTest.IsEmpty then
  //    exit;

  //  lbTestesDisp.Visible := False;
  //  cdsSuit.First;
  //  while not cdsSuit.EOF do
  //  begin
  //    cdsTest.First;
  //    while not cdsTest.EOF do
  //    begin
  //      oTeste := ogFacTeste.CriarTeste(cdsTestNome.AsString);

  //      //      oTeste.RelacionarDados(cdsTestDados.AsString);
  //      //      oTeste.Repeticoes(cdsTestRepeticao.AsInteger);
  //      //  oTeste.RelacionarDados('CadastroProcessoPenalDirecionada');
  //      //  oTeste.Repeticoes(1);
  //      RegisterTest(txtNomeBuild.Text + '\' + cdsSuitNomeSuit.AsString, oTeste);
  //      cdsTest.Next;
  //    end;
  //    cdsSuit.Next;
  //  end;

  //  if cbPreVisualizar.Checked then
  //    AlterarIni('DELPHI')
  //  else
  //    AlterarIni('NOTURNO');

end;


function TfrmPrincipal.LerArquivoIni(psDataBase: string): string;
var
  arq: TiniFile;
  sProvider, sPersistSecurityInfo, sDataSource: string;
begin
  arq := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'spCfg.ini');
  try
    sProvider := arq.ReadString('CONEXAOSQLITETESTE', 'Provider', '');
    sPersistSecurityInfo := arq.ReadString('CONEXAOSQLITETESTE', 'PersistSecurityInfo', '');
    sDataSource := arq.ReadString('CONEXAOSQLITETESTE', 'DataSource', '');
    psDataBase := 'DataBase=' + psDataBase;
  finally
    result := sProvider + sPersistSecurityInfo + sDataSource + psDataBase;
    FreeAndNil(arq);
  end;
end;

procedure TfrmPrincipal.btNovaSuitClick(Sender: TObject);
begin
  if not qrySuits.Active then
    qrySuits.Open;

  qrySuits.Append;

  if gridSuit.RowCount < 10 then
    gridSuit.RowCount := qrySuits.RecordCount + 1;

  frmSuit := TfrmSuit.Create(self);
  try
    frmSuit.ShowModal;

    if frmSuit.ModalResult = mrOk then
      qrySuits.Post
    else
      qrySuits.Cancel;

    AjustarAlturaGridSuit;
    qrySuits.Close;
    qrySuits.Open;
  finally
    FreeAndNil(frmSuit);
  end;

end;

procedure TfrmPrincipal.btNovoClick(Sender: TObject);
begin
  CriaNovoBuild;
end;

procedure TfrmPrincipal.btnNovoTesteClick(Sender: TObject);
begin
  if not qryTestes.Active then
    qryTestes.Open;

  if qrySuits.IsEmpty then
  begin
    ShowMessage('Nenhuma Suit para adicionar teste');
    exit;
  end;

  qryTestes.Insert;

end;

procedure TfrmPrincipal.AjustarAlturaGridSuit;
begin
  gridSuit.Visible := not qrySuits.IsEmpty;
  if gridSuit.RowCount < 10 then
    gridSuit.RowCount := qrySuits.RecordCount;
end;

procedure TfrmPrincipal.qrySuitsAfterOpen(DataSet: TDataSet);
begin
  AjustarAlturaGridSuit;
  if conSqlite.Connected then
  begin
    qryTestes.Open;
    btnNovoTeste.Enabled := not qrySuits.IsEmpty;
    btnDados.Enabled := not qrySuits.IsEmpty;
  end;
end;

procedure TfrmPrincipal.qryTestesBeforePost(DataSet: TDataSet);
begin
  if qryTestes.FieldByName('idTeste').OldValue <> qryTestes.FieldByName('idTeste').NewValue then
    qryTestes.FieldByName('dsNomeMetodo').AsString := '';

  qryTestesidSuit.AsInteger := qrySuitsidSuit.AsInteger;
  qryTestesdtInsercao.AsDateTime := now;
end;

procedure TfrmPrincipal.btnDadosClick(Sender: TObject);
begin
  if cbNomeTeste.Text = '' then
  begin
    ShowMessage('Nenhum teste selecionado');
    exit;
  end;

  if qryExecutor.Active then
    qryExecutor.Close;

  qryExecutor.SQL.Clear;
  qryExecutor.SQL.Text := 'select dsnometela from esajTestesDisponiveis where idteste=' +
    qryTestes.FieldByName('idteste').AsString;

  qryExecutor.Open;

  frmManipulaDados := TfrmManipulaDados.Create(self);
  try
    frmManipulaDados.conSQLite.ConnectionString := LerArquivoIni(FsBanco);
    frmManipulaDados.FsNomeTeste :=
      qryExecutor.FieldByName('dsNomeTela').AsString + '_DadosPrincipal';
    frmManipulaDados.FsCliente := qryBuild.FieldByName('cdcliente').AsString;

    frmManipulaDados.ShowModal;

    if gsMetodo <> '' then
    begin
      qryTestes.Edit;
      qryTestes.FieldByName('dsnomemetodo').AsString := gsMetodo;
      qryTestes.Post;
    end;

  finally
    FreeAndNil(frmManipulaDados);
  end;
end;

procedure TfrmPrincipal.qryTestesAfterScroll(DataSet: TDataSet);
begin
  gridTestes.Visible := not qryTestes.IsEmpty;
  if gridTestes.RowCount < 10 then
    gridTestes.RowCount := qryTestes.RecordCount;
end;

procedure TfrmPrincipal.qryBuildAfterPost(DataSet: TDataSet);
begin
  qryBuild.Close;
  qryBuild.Open;
end;

procedure TfrmPrincipal.CriaNovoBuild;
begin
  if not dlgSalvar.Execute then
    exit;

  if FileExists(dlgSalvar.FileName) then
    ShowMessage('N�o � poss�vel criar o BUILD. Escolha um nome de arquivo que n�o exista')
  else
  begin
    frmBuild := TfrmBuild.Create(self);
    try
      frmBuild.FsNomeArquivo := dlgSalvar.FileName;
      frmBuild.ShowModal;

      if frmBuild.ModalResult = mrOk then
      begin
        AbrirBD(dlgSalvar.FileName);
        qryBuild.Open;
        qrySuits.Open;
      end;
    finally
      FreeAndNil(frmBuild);
    end;
  end;
end;

procedure TfrmPrincipal.AbrirBD(psDataBase: string);
begin
  FecharBD;

  FsBanco := psDatabase;

  conSqlite.ConnectionString := LerArquivoIni(psDataBase);

  conSqlite.connected := True;
end;

procedure TfrmPrincipal.btnAbrirClick(Sender: TObject);
begin
  if not dlgAbrir.Execute then
    exit;

  if dlgAbrir.FileName <> '' then
  begin
    AbrirBD(dlgAbrir.FileName);
    if VerificarEstruturaBD then
    begin
      qryBuild.Open;
      qrySuits.Open;
    end;
  end;
end;

procedure TfrmPrincipal.FecharBD;
begin
  if conSqlite.connected then
    conSqlite.connected := False;
end;

function TfrmPrincipal.VerificarEstruturaBD: boolean;
var
  slTabelas: TStringList;
begin
  slTabelas := TStringList.Create;
  try
    conSqlite.GetTableNames(slTabelas);
    if slTabelas.indexOf('esajBuild') < 0 then
    begin
      ShowMessage('Estrutura do arquivo inv�lida');
      result := False;
    end
    else
      result := True;
  finally
    FreeAndNil(slTabelas);
  end;
end;

procedure TfrmPrincipal.CriarBuild(psNomeArquivo: string);
var
  sCaminho: string;
begin
  try
    sCaminho := ExtractFilePath(Application.ExeName) + 'criacao.cbl';

    AbrirBD(psNomeArquivo);

    if qryExecutor.Active then
      qryExecutor.Close;

    qryExecutor.SQL.Clear;
    qryExecutor.SQL.LoadFromFile(sCaminho);
    qryExecutor.ExecSQL;

    qryBuild.Open;
    qryBuild.Append;
  except
    on E: Exception do
      if pos('UNIQUE constraint', e.Message) > 0 then
        ShowMessage('J� existe um Build com esse nome para o mesmo Cliente');
  end;
end;

procedure TfrmPrincipal.conSqliteAfterDisconnect(Sender: TObject);
begin
  gridSuit.Visible := False;
end;

procedure TfrmPrincipal.btnEditarClick(Sender: TObject);
begin
  frmSuit := TfrmSuit.Create(self);
  try
    frmSuit.btnCriar.Caption := 'Salvar';
    frmSuit.ShowModal;

    qrySuits.Edit;

    if frmSuit.ModalResult = mrOk then
      qrySuits.Post
    else
      qrySuits.Cancel;

  finally
    FreeAndNil(frmSuit);
  end;
end;

procedure TfrmPrincipal.qrySuitsAfterScroll(DataSet: TDataSet);
begin
  btnEditar.Enabled := not qrySuits.IsEmpty;
end;

procedure TfrmPrincipal.qryTestesAfterOpen(DataSet: TDataSet);
begin
  qryTesteDisp.Open;
end;

procedure TfrmPrincipal.cbNomeTesteCloseUp(Sender: TObject);
begin
  txtRepeticao.Text := '1';
end;

procedure TfrmPrincipal.qryBuildAfterOpen(DataSet: TDataSet);
begin
  btNovaSuit.Enabled := not qryBuild.IsEmpty;
end;

procedure TfrmPrincipal.btRegistrarClick(Sender: TObject);
var
  oTeste: TfpgGUITestCase;
  ogFacTeste: TffpgTesteFactory;
begin

  ogFacTeste := TffpgTesteFactory.Create;

  try
    qrySuits.First;
    while not qrySuits.EOF do
    begin
      qryTestes.First;
      while not qryTestes.EOF do
      begin
        if qryTesteDisp.filtered then;
          qryTesteDisp.filtered := False;
        qryTesteDisp.filter := 'DSNOMETESTE=' + quotedStr(qryTestesNomeTeste.AsString);
        qryTesteDisp.filtered := True;
        oTeste := ogFacTeste.CriarTeste(qryTesteDispdsNomeTela.AsString);

        oTeste.spQtdeExecucao := qryTestesqtdRepeticao.AsInteger;
        oTeste.spMetodoTeste := qryTestesdsNomeMetodo.AsString;
        oTeste.spCarregarDadosSetUp := True;
        //  oTeste.RelacionarDados('CadastroProcessoPenalDirecionada');
        //  oTeste.Repeticoes(1);
        RegisterTest(qryBuildnmBuild.asString + '\' + qrySuitsnmSuit.AsString, oTeste);
        qryTestes.Next;
      end;
      qrySuits.Next;
    end;
  finally
    FreeAndNil(ogFacTeste);
  end;

end;

end.


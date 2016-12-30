unit ufrmManipula;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  ADODB, Grids, DBGrids, IniFiles, StdCtrls, DBCtrls, ComCtrls, DBClient, fpgGlobais;

type
  TfrmManipulaDados = class(TForm)
    conSQLite: TADOConnection;
    qryPlanilha: TADOQuery;
    grDados: TDBGrid;
    qryExecutor: TADOQuery;
    qryCopiaLinha: TADOQuery;
    dsCopiaLinha: TDataSource;
    btnAddCampo: TButton;
    btnCopiaLinha: TButton;
    txtProcuraCampo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnExcluiLinha: TButton;
    txtCliente: TEdit;
    btnExcluiCampo: TButton;
    txtMetodo: TEdit;
    Label3: TLabel;
    qryUsuario: TADOQuery;
    dsUsuario: TDataSource;
    qryUsuariocdUsuario: TAutoIncField;
    qryUsuariodsUsuario: TWideStringField;
    qryUsuariocdCliente: TWideStringField;
    dsPlanilha: TDataSource;
    pcAbas: TPageControl;
    TabSheet1: TTabSheet;
    cdsTabelas: TClientDataSet;
    cdsTabelastabela: TStringField;
    dsTabelas: TDataSource;
    gridTabelas: TDBGrid;
    cdsAbas: TClientDataSet;
    cdsAbasAba: TStringField;
    DataSource1: TDataSource;
    btnUsar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure qryPlanilhaAfterOpen(DataSet: TDataSet);
    procedure btnAddCampoClick(Sender: TObject);
    procedure btnCopiaLinhaClick(Sender: TObject);
    procedure grDadosKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure txtProcuraCampoKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnExcluiLinhaClick(Sender: TObject);
    procedure txtClienteChange(Sender: TObject);
    procedure txtProcuraCampoExit(Sender: TObject);
    procedure txtMetodoChange(Sender: TObject);
    procedure qryPlanilhaAfterClose(DataSet: TDataSet);
    procedure grDadosColExit(Sender: TObject);
    procedure qryPlanilhaBeforePost(DataSet: TDataSet);
    procedure gridTabelasDblClick(Sender: TObject);
    procedure gridTabelasCellClick(Column: TColumn);
    procedure pcAbasChange(Sender: TObject);
    procedure gridTabelasExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnUsarClick(Sender: TObject);
    procedure btnExcluiCampoClick(Sender: TObject);
  public
    FsNomeTeste: string;
    FsCliente: string;
    FsDatabase: string;
  private
    FsAba: string;
    procedure AbrirTabelaPlanilha;
    procedure AjustarLarguraTabela;
    procedure AtualizaTabelaPlanilha;
    procedure AdicionarCampoTabela;
    procedure DuplicarLinha;
    procedure AtualizarQueryLinhaCopia;
    procedure ProcurarColunaGrid(psColuna: string);
    procedure ExcluirlinhaGrid;
    procedure ExcluirCampo;
    procedure ProcuraMetodo(psMetodo: string);
    procedure FiltrarGridPlanilha;
    procedure PreencherTabelas;
    procedure HabilitarControles;
    procedure DesabilitarControles;
    procedure ConectarBanco;
    function LerStringConexao: string;
    function CampoTemInfo(psCampo: string): boolean;
    function ValidarInsercaoCampo(psCampo: string): boolean;
    function VerificaValorCampo(psCampo: string): boolean;
    function VerificaCampoBranco(psCampo: string): boolean;
    function VerificaSeTemNaTabela(psCampo: string): boolean;
    function VerificaCertezaNome(psCampo: string): boolean;
    procedure AdicionarAbas;
    function removerAcentuacao(psString: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmManipulaDados: TfrmManipulaDados;
  bAbaPrincipal: boolean;
  bInserindoTabelas: boolean;
  bDuplicando: boolean;

implementation

uses
  ufrmUsuario;

{$R *.DFM}

function TfrmManipulaDados.LerStringConexao: string;
var
  arq: TiniFile;
  sProvider: string;
  sPersistSecurityInfo: string;
  sDataSource: string;
begin
  arq := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'spCfg.ini');
  try
    sProvider := arq.ReadString('CONEXAOSQLITETESTE', 'Provider', '');
    sPersistSecurityInfo := arq.ReadString('CONEXAOSQLITETESTE', 'PersistSecurityInfo', '');
    sDataSource := arq.ReadString('CONEXAOSQLITETESTE', 'DataSource', '');
//    sDatabase := arq.ReadString('CONEXAOSQLITETESTE', 'Database', '');
//    FsCliente := arq.ReadString('DUNIT', 'SIGLACLIENTE', '');
  finally
    result := sProvider + sPersistSecurityInfo + sDataSource + FsDatabase;
    FreeAndNil(arq);
  end;
end;

procedure TfrmManipulaDados.FormCreate(Sender: TObject);
begin
//  ConectarBanco;

//  PreencherTabelas;

//  qryUsuario.Open;
//  AbrirTabelaPlanilha;
end;

procedure TfrmManipulaDados.AbrirTabelaPlanilha;
var
  sSQL, sNome: string;
  i: integer;
  oQuery: TADOQuery;
begin
//  FsNomeTeste := cdsTabelastabela.AsString + '_' + pcAbas.ActivePage.Caption;
  bAbaPrincipal := pos('DadosPrincipal', FsNomeTeste) > 0;

  if FsNomeTeste <> '' then
  begin
    if Assigned(grDados.DataSource.DataSet) then
      grDados.DataSource.DataSet.Destroy;

    oQuery := TADOQuery.Create(self);   // PC_OK


    oQuery.AfterOpen := qryPlanilhaAfterOpen;
    oQuery.AfterClose := qryPlanilhaAfterClose;
    oQuery.BeforePost := qryPlanilhaBeforePost;

    oQuery.Connection := conSQLite;


    if oQuery.active then
      oQuery.Close;

    //    for i := 0 to qryPlanilha.FieldDefs.Count - 1 do
    //      qryPlanilha.FieldDefs.delete[i];

    sSQL := 'SELECT * FROM ' + FsNomeTeste; //RetornaSelectPrincipal;

    oQuery.SQL.Clear;
    oQuery.SQL.Text := '';

    oQuery.SQL.Text := sSQL;

    //    qryPlanilha.Open;
    if bAbaPrincipal then
    begin
      if oQuery.FieldDefs.Updated then
        oQuery.FieldDefs.Updated := False;

      oQuery.FieldDefs.Update;

      for i := 0 to oQuery.FieldDefs.Count - 1 do
      begin
        if oQuery.FieldDefs[i].Name = 'spUsuario' then
        begin
          oQuery.FieldDefs[i].CreateField(oQuery).Visible := False;

          with TStringField.Create(oQuery) do
          begin
            FieldName := 'Usuario';
            FieldKind := fkLookup;
            DataSet := oQuery;
            sNome := Dataset.Name + FieldName;
            KeyFields := 'spUsuario'; //Campo Chave
            LookUpDataset := qryUsuario;
            LookUpKeyFields := 'cdUsuario'; //Campo Chave
            LookUpResultField := 'dsUsuario'; //Resultado da campo lookup criado
            //          qryPlanilha.FieldDefs.Add(sNome, ftString, 20, false);
          end;
        end
        else
          oQuery.FieldDefs[i].CreateField(oQuery);
      end;

    end;
    oQuery.Open;

    dsPlanilha.DataSet := oQuery;
    AjustarLarguraTabela;
    FiltrarGridPlanilha;
  end;
end;

procedure TfrmManipulaDados.AjustarLarguraTabela;
var
  nTamanhoNome, nTamanhoValor, i: integer;
begin
  for i := 0 to grDados.Columns.Count - 1 do
  begin
    nTamanhoNome := 0;
    nTamanhoValor := 0;

    nTamanhoNome := Length(grDados.Columns[i].FieldName);
    nTamanhoValor := Length(dsPlanilha.DataSet.FieldByName(grDados.Columns[i].FieldName).AsString);

    if nTamanhoNome > nTamanhoValor then
      grDados.Columns[i].Width := 10 * nTamanhoNome
    else
      grDados.Columns[i].Width := 12 * nTamanhoValor;
  end;
end;

procedure TfrmManipulaDados.AtualizaTabelaPlanilha;
begin
  dsPlanilha.DataSet.Close;
  dsPlanilha.DataSet.Open;
  AjustarLarguraTabela;
end;

procedure TfrmManipulaDados.qryPlanilhaAfterOpen(DataSet: TDataSet);
begin
  //  AjustarLarguraTabela(DataSet);
  HabilitarControles;
end;

procedure TfrmManipulaDados.AdicionarCampoTabela;
var
  sComando, sNomeColuna: string;
begin
  sNomeColuna := InputBox('Adcionar campo na tabela', 'Inserir nome do campo novo', '');

  if not ValidarInsercaoCampo(sNomeColuna) then
    exit;

  sNomeColuna := removerAcentuacao(sNomeColuna);

  sComando := 'Alter Table ' + FsNomeTeste + ' add column ' + sNomeColuna + ' varchar(200)';

  qryExecutor.SQL.Text := sComando;
  qryExecutor.ExecSQL;
//  AtualizaTabelaPlanilha;
  AbrirTabelaPlanilha;
  grDados.SelectedIndex := grDados.Columns.Count - 1;
  grDados.SetFocus;
end;

procedure TfrmManipulaDados.DuplicarLinha;
var
  i: integer;
  sMetodo: string;
  nCdValor: integer;
begin
  AtualizarQueryLinhaCopia;

  if bAbaPrincipal then
  begin
    sMetodo := InputBox('Digitar Nome do novo Método',
      'Digitar o nome do método(não pode haver repetido)', '');

    if sMetodo = '' then
      exit
    else
    if dsPlanilha.DataSet.locate('spMetodoTeste; cdcliente',
      varArrayOf([sMetodo, dsPlanilha.DataSet.FieldByName('cdcliente').AsString]), []) then
    begin
      ShowMessage('O método ' + sMetodo + ' já existe na planilha');
      exit;
    end;
  end;

  if qryExecutor.active then
    qryExecutor.Close;

  qryExecutor.SQL.Clear;
  qryExecutor.SQL.Text := 'SELECT max(cdvalor) TOTAL FROM ' + FsNomeTeste;
  qryExecutor.Open;
  nCdValor := qryExecutor.FieldByName('TOTAL').AsInteger + 1;
  qryExecutor.Close;

  bDuplicando := True;

  dsPlanilha.DataSet.Insert;
  for i := 0 to qryCopiaLinha.FieldCount - 1 do
    dsPlanilha.DataSet.FieldByName(qryCopiaLinha.Fields[i].FieldName).AsString :=
      qryCopiaLinha.Fields[i].AsString;

  dsPlanilha.DataSet.FieldByName('spMetodoTeste').AsString := sMetodo;
  dsPlanilha.DataSet.FieldByName('CDVALOR').AsInteger := nCdValor;

  dsPlanilha.DataSet.Post;
  bDuplicando := False;
  AtualizaTabelaPlanilha;

  if bAbaPrincipal then
    dsPlanilha.DataSet.locate('spMetodoTeste', sMetodo, []);
end;

procedure TfrmManipulaDados.btnAddCampoClick(Sender: TObject);
begin
  AdicionarCampoTabela;
end;

procedure TfrmManipulaDados.btnCopiaLinhaClick(Sender: TObject);
var
  nBotao: integer;
  sMsg: string;
begin
  if bAbaPrincipal then
    sMsg := 'Tem certeza que deseja copiar a linha do método ' +
      dsPlanilha.DataSet.FieldByName('SPMETODOTESTE').AsString + ' do cliente ' + FsCliente + '?'
  else
    sMsg := 'Tem certeza que deseja copiar a linha ' +
      dsPlanilha.DataSet.FieldByName('cdvalor').AsString + ' do cliente ' + FsCliente + '?';


  nBotao := messagedlg(sMsg, mtConfirmation, mbYesNoCancel, 0);

  if nBotao <> mrYes then
    exit;

  DuplicarLinha;
end;

procedure TfrmManipulaDados.AtualizarQueryLinhaCopia;
var
  sComando: string;
begin
  if qryCopiaLinha.active then
    qryCopiaLinha.Close;

  sComando := 'SELECT * FROM ' + FsNomeTeste + ' WHERE SPMETODOTESTE=' +
    quotedStr(dsPlanilha.DataSet.FieldByName('SPMETODOTESTE').AsString) + ' AND CDCLIENTE=' +
    quotedStr(dsPlanilha.DataSet.FieldByName('CDCLIENTE').AsString);

  qryCopiaLinha.SQL.Clear;
  qryCopiaLinha.SQL.Text := sComando;
  qryCopiaLinha.Open;
end;

procedure TfrmManipulaDados.ProcurarColunaGrid(psColuna: string);
var
  i, nVolta: integer;
  bAchou: boolean;
begin
  if psColuna = '' then
    exit;

  nVolta := 0;
  bAchou := False;
  while nVolta < 2 do
  begin
    for i := grDados.SelectedIndex + 1 to grDados.Columns.Count - 1 do
    begin
      if pos(psColuna, grDados.Columns.Items[i].FieldName) <> 0 then
      begin
        grDados.SelectedIndex := i;
        bAchou := True;
        break;
      end;

    end;
    if bAchou then
    begin
      grDados.SetFocus;
      break;
    end;
    grDados.SelectedIndex := -1;
    Inc(nVolta);
  end;
  if not bAchou then
  begin
    ShowMessage('O campo ' + psColuna + ' não foi encontrado na grid');
    txtProcuraCampo.Text := '';
    txtProcuraCampo.SetFocus;
  end;
end;

procedure TfrmManipulaDados.grDadosKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 13 then
    ProcurarColunaGrid(txtProcuraCampo.Text);
end;

procedure TfrmManipulaDados.txtProcuraCampoKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if key = 13 then
    ProcurarColunaGrid(txtProcuraCampo.Text);
end;

procedure TfrmManipulaDados.btnExcluiLinhaClick(Sender: TObject);
var
  nBotao: integer;
  sMsg: string;
begin
  sMsg := 'Tem certeza que deseja excluir a linha do método ' +
    dsPlanilha.DataSet.FieldByName('SPMETODOTESTE').AsString + ' do cliente ' + FsCliente + '?';
  nBotao := messagedlg(sMsg, mtConfirmation, mbYesNoCancel, 0);

  if nBotao <> mrYes then
    exit;

  ExcluirlinhaGrid;
end;

procedure TfrmManipulaDados.ExcluirlinhaGrid;
var
  sComando: string;
begin
  if qryExecutor.active then
    qryExecutor.Close;

  sComando := 'Delete from ' + FsNomeTeste + ' where spMetodoTeste=' +
    quotedStr(dsPlanilha.DataSet.FieldByName('SPMETODOTESTE').AsString) +
    ' and cdcliente=' + quotedStr(dsPlanilha.DataSet.FieldByName('CDCLIENTE').AsString) +
    ' and cdvalor=' + quotedStr(dsPlanilha.DataSet.FieldByName('CDVALOR').AsString);

  qryExecutor.SQL.Text := sComando;
  qryExecutor.ExecSQL;

  AtualizaTabelaPlanilha;
end;

procedure TfrmManipulaDados.txtClienteChange(Sender: TObject);
begin
  FiltrarGridPlanilha;
end;

procedure TfrmManipulaDados.txtProcuraCampoExit(Sender: TObject);
begin
  ProcurarColunaGrid(txtProcuraCampo.Text);
end;

procedure TfrmManipulaDados.ExcluirCampo;
begin
  if CampoTemInfo(grDados.Columns.Items[grDados.SelectedIndex].FieldName) then
  begin
    ShowMessage('Não é possível excluir o campo ' +
      grDados.Columns.Items[grDados.SelectedIndex].FieldName +
      ' porque ele já possui informações na tabela');
    exit;
  end;
end;

function TfrmManipulaDados.CampoTemInfo(psCampo: string): boolean;
begin
  if qryExecutor.active then
    qryExecutor.Close;

  qryExecutor.SQL.Clear;
  qryExecutor.SQL.Text := 'SELECT count(1) TOTAL FROM ' + FsNomeTeste + ' where ' +
    psCampo + ' is not null and ' + psCampo + ' <> '''' ';
  qryExecutor.Open;
  result := qryExecutor.FieldByName('TOTAL').AsInteger > 0;
end;

procedure TfrmManipulaDados.ProcuraMetodo(psMetodo: string);
var
  sFiltro: string;
begin
  if psMetodo = '' then
  begin
    if txtCliente.Text = '' then
      dsPlanilha.DataSet.Filtered := False
    else
      txtClienteChange(txtCliente);
    exit;
  end;

  if dsPlanilha.DataSet.Filtered then
  begin
    sFiltro := dsPlanilha.DataSet.Filter;
    dsPlanilha.DataSet.Filtered := False;
    dsPlanilha.DataSet.Filter := sFiltro + ' AND spMetodoTeste like ' +
      quotedStr('%' + txtMetodo.Text + '%');
  end
  else
    dsPlanilha.DataSet.Filter := 'spMetodoTeste like ' + quotedStr('%' + txtMetodo.Text + '%');

  dsPlanilha.DataSet.Filtered := True;
end;

procedure TfrmManipulaDados.txtMetodoChange(Sender: TObject);
begin
  FiltrarGridPlanilha;
end;

procedure TfrmManipulaDados.FiltrarGridPlanilha;
var
  sFiltro: string;
begin
  sFiltro := '';
  if (txtCliente.Text <> '') and (txtMetodo.Text <> '') then
    sFiltro := 'CDCLIENTE LIKE ' + quotedStr('%' + txtCliente.Text + '%') +
      ' AND spMetodoTeste like ' + quotedStr('%' + txtMetodo.Text + '%')
  else if (txtCliente.Text <> '') then
    sFiltro := 'CDCLIENTE LIKE ' + quotedStr('%' + txtCliente.Text + '%')
  else if txtmetodo.Text <> '' then
    sFiltro := 'spMetodoTeste like ' + quotedStr('%' + txtMetodo.Text + '%')
  else
  begin
    dsPlanilha.DataSet.Filtered := False;
    exit;
  end;

  if pos(sFiltro, 'CDCLIENTE') > 0 then
  begin
    if qryUsuario.Filtered then
      qryUsuario.Filtered := False;
    qryUsuario.filter := 'cdcliente like ' + quotedStr('%' + txtCliente.Text + '%');
    qryUsuario.Filtered := True;
  end;

  dsPlanilha.DataSet.Filtered := False;
  dsPlanilha.DataSet.Filter := sFiltro;
  dsPlanilha.DataSet.Filtered := True;
end;

procedure TfrmManipulaDados.PreencherTabelas;
var
  slTabelas: TStringList;
  i: integer;
  sNomeTeste: string;
begin
  slTabelas := TStringList.Create;

  cdsTabelas.CreateDataSet;
  cdsTabelas.Open;

  cdsAbas.CreateDataSet;
  cdsAbas.Open;

  try
    conSQLite.GetTableNames(slTabelas);

    slTabelas.Sorted := True;

    bInserindoTabelas := True;

    for i := 0 to slTabelas.Count - 1 do
    begin
      sNomeTeste := copy(slTabelas[i], 0, pos('_', slTabelas[i]) - 1);
      if sNomeTeste <> '' then
      begin
        cdsAbas.Insert;
        cdsAbas.FieldByName('Aba').AsString := slTabelas[i];
        cdsAbas.Post;

        if not cdsTabelas.locate('tabela', sNomeTeste, []) then
        begin
          cdsTabelas.Insert;
          cdsTabelas.FieldByName('tabela').AsString := sNomeTeste;
          cdsTabelas.Post;
        end;
      end;
    end;
    cdsTabelas.First;
    cdsTabelas.Delete;
    bInserindoTabelas := False;

    AbrirTabelaPlanilha;
  finally
    FreeAndNil(slTabelas);
  end;
end;

procedure TfrmManipulaDados.DesabilitarControles;
begin
  txtProcuraCampo.Enabled := False;
  txtCliente.Enabled := False;
  txtMetodo.Enabled := False;
  btnAddCampo.Enabled := False;
  btnCopiaLinha.Enabled := False;
  btnExcluiLinha.Enabled := False;
end;

procedure TfrmManipulaDados.HabilitarControles;
begin
  txtProcuraCampo.Enabled := True;
  txtCliente.Enabled := True;
  txtMetodo.Enabled := True;
  btnAddCampo.Enabled := True;
  btnCopiaLinha.Enabled := True;
  btnExcluiLinha.Enabled := True;
end;

procedure TfrmManipulaDados.qryPlanilhaAfterClose(DataSet: TDataSet);
begin
  DesabilitarControles;
end;

procedure TfrmManipulaDados.ConectarBanco;
begin
  if conSQLite.Connected then
    conSQLite.Connected := False;

//  conSQLite.ConnectionString := LerStringConexao;

  conSQLite.Connected := True;
end;

function TfrmManipulaDados.ValidarInsercaoCampo(psCampo: string): boolean;
var
  bPossuiValor, bSemEspacoBranco, bNaoTemNaTabela: boolean;
begin
  result := False;
  bPossuiValor := VerificaValorCampo(psCampo);
  bSemEspacoBranco := VerificaCampoBranco(psCampo);
  bNaoTemNaTabela := VerificaSeTemNaTabela(psCampo);

  if bPossuiValor and bSemEspacoBranco and bNaoTemNaTabela then
    if VerificaCertezaNome(psCampo) then
      result := True;
end;

function TfrmManipulaDados.VerificaValorCampo(psCampo: string): boolean;
begin
  result := True;
  if psCampo = '' then
  begin
    ShowMessage('Nenhum nome de campo informado');
    result := False;
  end;
end;

function TfrmManipulaDados.VerificaCampoBranco(psCampo: string): boolean;
begin
  result := True;
  psCampo := Trim(psCampo);

  if pos(' ', psCampo) > 0 then
  begin
    ShowMessage('Não é permitido espaços na criação do campo');
    result := False;
  end;
end;

function TfrmManipulaDados.VerificaSeTemNaTabela(psCampo: string): boolean;
var
  slCamposTabela: TStringList;
begin
  result := True;
  slCamposTabela := TStringList.Create;
  try
    conSQLite.GetFieldNames(FsNomeTeste, slCamposTabela);

    slCamposTabela.Sort;
    if slCamposTabela.IndexOf(psCampo) <> -1 then
    begin
      ShowMessage('O campo ' + psCampo + ' já existe na tabela');
      result := False;
    end;
  finally
    FreeAndNil(slCamposTabela);
  end;
end;

function TfrmManipulaDados.VerificaCertezaNome(psCampo: string): boolean;
var
  sMsg: string;
  nBotao: integer;
begin
  sMsg := 'Tem certeza que deseja adicionar o campo ' + psCampo + ' na tabela ' +
    FsNomeTeste + '?';
  nBotao := messagedlg(sMsg, mtConfirmation, mbYesNoCancel, 0);

  result := nBotao = mrYes;
end;

procedure TfrmManipulaDados.grDadosColExit(Sender: TObject);
begin
  if dsPlanilha.DataSet.State = dsEdit then
    dsPlanilha.DataSet.Post;
end;

procedure TfrmManipulaDados.qryPlanilhaBeforePost(DataSet: TDataSet);
begin
  if (grDados.Columns.Grid.SelectedField.FullName = 'spMetodoTeste') or
    (grDados.Columns.Grid.SelectedField.FullName = 'cdCliente') then
  begin
    if qryExecutor.active then
      qryExecutor.Close;

    qryExecutor.SQL.Clear;

    qryExecutor.SQL.Text := 'Select * from ' + FsNomeTeste + ' where spMetodoTeste=' +
      quotedstr(dsPlanilha.DataSet.FieldByName('spMetodoTeste').AsString) +
      ' and cdcliente=' + quotedstr(dsPlanilha.DataSet.FieldByName('cdcliente').AsString);

    qryExecutor.Open;
    if not qryExecutor.IsEmpty then
    begin
      ShowMessage('O método ' + dsPlanilha.DataSet.FieldByName('spMetodoTeste').AsString +
        ' já existe na planilha pro cliente ' + dsPlanilha.DataSet.FieldByName(
        'cdcliente').AsString);
      dsPlanilha.DataSet.Cancel;
      abort;
    end;
  end;
end;

procedure TfrmManipulaDados.gridTabelasDblClick(Sender: TObject);
begin
  if gridTabelas.Height = 88 then
    gridTabelas.Height := 1010
  else
    gridTabelas.Height := 88;
end;

procedure TfrmManipulaDados.gridTabelasCellClick(Column: TColumn);
begin
  AbrirTabelaPlanilha;
  AdicionarAbas;
end;

procedure TfrmManipulaDados.AdicionarAbas;
var
  sAba: string;
  oAba: TTabSheet;
  i: integer;
begin

  if cdsAbas.filtered then
    cdsAbas.filtered := False;
  cdsAbas.filter := 'Aba like ' + quotedStr(cdsTabelastabela.Asstring + '%');

  cdsAbas.filtered := True;

  for i := 0 to pcAbas.PageCount - 1 do
    pcAbas.Pages[0].Destroy;

  oAba:= TTabSheet.Create(cdsAbas);
  oAba.Caption := 'DadosPrincipal';
  oAba.PageControl := pcAbas;


  if cdsAbas.RecordCount = 1 then
    exit;

  while not cdsAbas.eof do
  begin
    sAba := copy(cdsAbasAba.AsString, pos('_', cdsAbasAba.AsString) + 1, Length(cdsAbasAba.AsString));
    if sAba <> 'DadosPrincipal' then
    begin
      oAba:= TTabSheet.Create(cdsAbas);
      oAba.Caption := sAba;
      oAba.PageControl := pcAbas;
    end;
    cdsAbas.Next;
  end;
end;

procedure TfrmManipulaDados.pcAbasChange(Sender: TObject);
begin
  gridTabelas.Height := 88;
  AbrirTabelaPlanilha;
end;

procedure TfrmManipulaDados.gridTabelasExit(Sender: TObject);
begin
  gridTabelas.Height := 88;
end;

function TfrmManipulaDados.removerAcentuacao(psString: string): string;
const
  ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
  x: integer;
begin
  for x := 1 to Length(psString) do
    if Pos(psString[x], ComAcento) <> 0 then
      psString[x] := SemAcento[Pos(psString[x], ComAcento)];

  result := psString;
end;

procedure TfrmManipulaDados.FormShow(Sender: TObject);
begin
  ConectarBanco;

  PreencherTabelas;

  qryUsuario.Open;
  AbrirTabelaPlanilha;
  AdicionarAbas;
  txtCliente.Text := FsCliente;
  txtClienteChange(txtCliente);
end;

procedure TfrmManipulaDados.btnUsarClick(Sender: TObject);
begin
  gsMetodo := grDados.DataSource.DataSet.fieldbyName('spmetodoTeste').asString;
  self.close;
end;

procedure TfrmManipulaDados.btnExcluiCampoClick(Sender: TObject);
begin
  frmUsuario := TfrmUsuario.Create(self);
  frmUsuario.ShowModal;
end;

end.


unit ufpgCadModeloTests;

interface

uses
  ufpgCadModelo, ufpgGUITestCase, ufpgCadModeloModelTests, ufpgDataModelTests, ufpgEditor;


type
  TffpgCadModeloTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadModelo;
    FoDados: TffpgCadModeloModelTests;
    procedure CadastrarModelo;
    function VerificarDocumentoCriado: boolean;
    procedure PreencherDadosPrincipais;
    procedure FecharTelaEditor(FoTelaEditor: TffpgEditor);
    procedure PreencherDadosAtosDoDocumento;
    procedure PreencherDadosMovimentacao;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure SetUp; override;
  published
    procedure TestarCadastrarModelo;
  end;

implementation

uses
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, Classes, uspForm, DB,
  uspInterface, ufpgGerenciadorArquivo, ufpgVariaveisTestesGUI, uedtDocumentoEDT,
  ufpgFuncoesGUITestes, uspSendKeys, Controls, ufpgConsTipoMvProcessoTreeView,
  usaj5TreeView, VirtualTrees;

var
  FsNomeModelo: string;


procedure TffpgCadModeloTests.SetUp;
begin
  spNomeMenuItem := 'imfggpCadModeloDocumentos';
  inherited;
end;


procedure TffpgCadModeloTests.CadastrarModelo;
var
  oTelaEditor: TffpgEditor;
begin
  AbrirTela;
  FoTela := TffpgCadModelo(spTela);
  FoDados := TffpgCadModeloModelTests(spDataModelTests);
  PreencherDadosPrincipais;

  ExecutarSubRoteiroTestes(PreencherDadosMovimentacao, 'DadosMovimentacao',
    FoDados.fpgCadMovimentacaoModelTests);

  ExecutarSubRoteiroTestes(PreencherDadosAtosDoDocumento, 'DadosAtosDocumento',
    FoDados.fpgCadAtoModelTests);

  FoTela.dxbbBotoesSalvar.Click;
  FoTela.acBotoesSalvarExecute(FoTela.dxbbBotoesSalvar);

  oTelaEditor := PegarTela('ffpgEditor', False, 0) as TffpgEditor;
  if Assigned(oTelaEditor) then
    FecharTelaEditor(oTelaEditor);

  if FoDados.fpgVerificarModelo then
    Check(VerificarDocumentoCriado, 'O modelo de documento não foi criado.');

  FecharTela;
end;


function TffpgCadModeloTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadModeloModelTests;
end;

function TffpgCadModeloTests.VerificarDocumentoCriado: boolean;
var
  oTela: TffpgGerenciadorArquivo;
begin
  result := False;
  ClicarItemMenu('imffpgGerenciadorArquivo');
  oTela := PegarTela('ffpgGerenciadorArquivo') as TffpgGerenciadorArquivo;
  EnterTextCheckBox(oTela.tbxrbTipoDeArquivoModelos, True);
  oTela.dxedNomeDocumento.Text := FsNomeModelo;
  Sleep(1000);
  Application.ProcessMessages;
  oTela.tbxiConsultar.Click;
  application.ProcessMessages;
  oTela.dbGrid.DataSource.DataSet.First;

  while not oTela.dbGrid.DataSource.DataSet.EOF do
  begin
    if oTela.dbGrid.DataSource.DataSet.FieldByName('NMDOCUMENTO').AsString = FsNomeModelo then
    begin
      result := True;
      Application.ProcessMessages;
      Break;
    end
    else
    begin
      oTela.dbGrid.DataSource.DataSet.Next;
    end;
  end;
  oTela.imArquivoFechar.Click;
end;

procedure TffpgCadModeloTests.PreencherDadosPrincipais;
begin
  EnterTextInto(FoTela.edtCategoriaConsGrid.dfCodigo, FoDados.fpgCdCategoria);
  Tab;
  FoTela.dxbbBotoesNovo.Click;
  gsNuModeloDocumento := FoTela.dfcdModelo.PegaTexto;
  FsNomeModelo := FoDados.fpgNomeModelo + '' + gsNuModeloDocumento;
  EnterTextInto(FoTela.dfnmModelo, FsNomeModelo);
  checkFalse(FoTela.grFilhoModelo.columns[0].ReadOnly,
    'A consulta não foi habilitada no primeiro clique no insert');
end;

procedure TffpgCadModeloTests.FecharTelaEditor(FoTelaEditor: TffpgEditor);
begin
  FoTelaEditor.dxbbArquivoFecharEditor.Click;
end;

procedure TffpgCadModeloTests.PreencherDadosAtosDoDocumento;
var
  oModelAto: TffpgCadAtoModelTests;
begin
  oModelAto := FoDados.fpgCadAtoModelTests;
  FoTela.pcDadosModelo.ActivePage := FoTela.tsAtosDocumento;
  FoTela.pcDadosModeloChange(FoTela.pcDadosModelo);
  EnterTextGrid(FoTela.gdAtosDocumento, oModelAto.fpgAto, 0);
  EnterTextGrid(FoTela.gdAtosDocumento, oModelAto.fpgForma, 1);

  if FoTela.gdAtosDocumento.DataSource.DataSet.State <> dsEdit then
    FoTela.gdAtosDocumento.DataSource.DataSet.Edit;

  FoTela.gdAtosDocumento.DataSource.DataSet.FieldByName('CDMODELO').AsString :=
    oModelAto.fpgModelo;

  //  EnterTextGrid(FoTela.gdAtosDocumento, oModelAto.fpgModelo, 2);

  EnterTextGrid(FoTela.gdAtosDocumento, oModelAto.fpgPrazo, 4);
  EnterTextGrid(FoTela.gdAtosDocumento, oModelAto.fpgAutomatico, 5);
  EnterTextGrid(FoTela.gdAtosDocumento, oModelAto.fpgTpSelecao, 6);
  EnterTextGrid(FoTela.gdAtosDocumento, oModelAto.fpgModoFinalizacao, 7);
end;

procedure TffpgCadModeloTests.TestarCadastrarModelo;
begin
  ExecutarRoteiroTestes(CadastrarModelo);
end;

procedure TffpgCadModeloTests.PreencherDadosMovimentacao;
begin
  FoTela.pcDadosModelo.ActivePage := FoTela.tsMovimentacoes;
  FoTela.pcDadosModeloChange(FoTela);

  FoTela.ccMovimentacao.Execute(acNovo);
  FoTela.ccMovimentacao.Execute(acNovo);

  FoTela.fsajTipoMvProcessoCons.dfCodigo.SetFocus;
  FoTela.fsajTipoMvProcessoCons.dfCodigo.DefineTexto('70011');
  Tab;

  application.ProcessMessages;
end;

end.


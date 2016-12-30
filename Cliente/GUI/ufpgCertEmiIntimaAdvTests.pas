unit ufpgCertEmiIntimaAdvTests;


interface

uses
  ufpgCertEmiIntimaAdv, ufpgGUITestCase, ufpgCertEmiIntimaAdvModelTests,
  ufpgDataModelTests, SysUtils, Windows, FutureWindows;

type
  TffpgCertEmiIntimaAdvTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCertEmiIntimaAdv;
    FoDados: TffpgCertEmiIntimaAdvModelTests;
    procedure CertEmiIntimaAdv;
    procedure PreencherDados;
    procedure LiberarDocumento(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCertEmiIntimaAdv;
  end;

implementation

{ TffpgCertEmiIntimaAdvTests }

uses
  usajConstante, ufpgFuncoesGUITestes, Forms, usajConsAgente, DB, uspInterface,
  udigSelecaoCertificadoDigital, ufpgVariaveisTestesGUI;

procedure TffpgCertEmiIntimaAdvTests.TestarCertEmiIntimaAdv;
begin
  ExecutarRoteiroTestes(CertEmiIntimaAdv);
end;

procedure TffpgCertEmiIntimaAdvTests.CertEmiIntimaAdv;
begin
  FoDados := TffpgCertEmiIntimaAdvModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgCertEmiIntimaAdv');

  FoTela := TffpgCertEmiIntimaAdv(spTela);

  PreencherDados;


  TFutureWindows.Expect('TfdigSelecaoCeritificadoDigital', 1000).ExecProc(LiberarDocumento);
  FoTela.ccCadastro.Execute(acImprimir);

  if FoDados.fpgFecharTela then
    FecharTela;
end;

function TffpgCertEmiIntimaAdvTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCertEmiIntimaAdvModelTests;
end;

procedure TffpgCertEmiIntimaAdvTests.PreencherDados;
begin
  if FoDados.fpgVara = STRING_INDEFINIDO then
    FoDados.fpgVara := gsVara;
  Check(FoDados.fpgVara <> STRING_INDEFINIDO, 'Número da Vara Não definida.');
  EnterTextInto(FoTela.csVara.dfcdVara, FoDados.fpgVara);

  if FoDados.fpgSeqRelacao = STRING_INDEFINIDO then
    if gsSeqRelacao <> STRING_INDEFINIDO then
      FoDados.fpgSeqRelacao := gsSeqRelacao;
  Check(FoDados.fpgSeqRelacao <> STRING_INDEFINIDO, 'Número da Relação nao definido.');
  EnterTextInto(FoTela.nuRelacao.edRelSeq, FoDados.fpgSeqRelacao);

  if FoDados.fpgAnoRelacao = STRING_INDEFINIDO then
    FoDados.fpgAnoRelacao := FormatDateTime('YYYY', Now);
  Check(FoDados.fpgAnoRelacao <> STRING_INDEFINIDO, 'Número do Ano da Relação não definido.');
  EnterTextInto(FoTela.nuRelacao.edRelAno, FoDados.fpgAnoRelacao);

  Application.ProcessMessages;
end;


procedure TffpgCertEmiIntimaAdvTests.LiberarDocumento(const poWindow: IWindow);
var
  oTelaFinalizar: TfdigSelecaoCeritificadoDigital;
begin
  oTelaFinalizar := poWindow.asControl as TfdigSelecaoCeritificadoDigital;
  EnterTextInto(oTelaFinalizar.cbCertificados, FoDados.fpgCertificado);
  spVerificadorTelas.RegistrarMensagem(
    'As certidões foram geradas com sucesso para os processos selecionados.', 'OK');
  oTelaFinalizar.dxbbBotoesSelecionar.Click;
end;


end.


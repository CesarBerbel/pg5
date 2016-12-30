unit ufpgCertPubIntimaAdvTests;

interface

uses
  TestFramework, ufpgDataModelTests, ufpgGUITestCase, ufpgCertPubIntimaAdv,
  ufpgCertPubIntimaAdvModelTests, FutureWindows, SysUtils, Windows, Forms;

type
  TffpgCertPubIntimaAdvTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCertPubIntimaAdv;
    FoDados: TffpgCertPubIntimaAdvModelTests;
    procedure CertPubIntimaAdv;
    procedure PreencherDados;
    procedure LiberarDocumento(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCertPubIntimaAdv;
  end;

implementation

{ TffpgCertPubIntimaAdvTests }

uses
  ufpgConstanteGUITests, usajConstante, ufpgFuncoesGUITestes, ufpgVariaveisTestesGUI,
  uspInterface, udigSelecaoCertificadoDigital, DB, usajLotacao;

procedure TffpgCertPubIntimaAdvTests.CertPubIntimaAdv;
begin
  FoDados := TffpgCertPubIntimaAdvModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgCertPubIntimaAdv');

  FoTela := TffpgCertPubIntimaAdv(spTela);

  PreencherDados;

  FecharTela;
  check(FoDados.VerificarPublicacaoIntimacao(FoDados.fpgCdForo, FoDados.fpgCdVara,
    FoDados.fpgCdProcesso, gsNuRelacao, FoDados.fpgTpMvProcesso),
    'Ocorreu um erro na impressão da certidão.');
end;

function TffpgCertPubIntimaAdvTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCertPubIntimaAdvModelTests;
end;

procedure TffpgCertPubIntimaAdvTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
  begin
    FoDados.fpgNuProcesso := UsarProcessoArray;
    FoDados.fpgCdProcesso := gsCDProcesso;
    FoDados.fpgCdForo := IntToStr(sajLotacaoUsuario.FnCdForo);
    FoDados.fpgNuRelacao := gsSeqRelacao;
  end;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');

  if FoDados.fpgNuRelacao = STRING_INDEFINIDO then
    FoDados.fpgNuRelacao := gsSeqRelacao;
  Check(FoDados.fpgNuRelacao <> STRING_INDEFINIDO, 'Número da relação não encontrado.');

  if FoDados.fpgDtDisponibilizacao = STRING_INDEFINIDO then
    FoDados.fpgDtDisponibilizacao := DateToStr(Now);

  EnterTextInto(FoTela.csVara.dfcdVara, FoDados.fpgCdVara);
  EnterTextInto(FoTela.nuRelacao.edRelSeq, FoDados.fpgNuRelacao);

  while not FoTela.eddtDisponib.Enabled do
  begin
    sleep(100);
    application.ProcessMessages;
    tab;
  end;

  EnterTextInto(FoTela.eddtDisponib, FoDados.fpgDtDisponibilizacao);
  if (FoTela.eddtDisponib.EstaNulo) and (FoTela.efpgPublicaDiario.State <> dsEdit) then
  begin
    FoTela.efpgPublicaDiario.edit;
    FoTela.eddtDisponib.SetFocus;
    FoTela.eddtDisponib.Clear;
    application.ProcessMessages;
    FoTela.eddtDisponib.DefineTexto(FoDados.fpgDtDisponibilizacao);
    sleep(500);
    application.ProcessMessages;
  end;

  FoDados.fpgTpMvProcesso := FoTela.csTipoMv.dfCodigo.PegaTexto;

  EnterTextInto(FoTela.edFolhas, FoDados.fpgNuFolhas);
  FoTela.bcBotoesCadastro.spControleCadastro.Execute(acSalvar);
  TFutureWindows.Expect('TfdigSelecaoCeritificadoDigital', 1000).ExecProc(LiberarDocumento);
  spVerificadorTelas.RegistrarMensagem(
    'As certidões foram geradas com sucesso para os processos selecionados.', 'OK');
  FoTela.bcBotoesCadastro.spControleCadastro.Execute(acImprimir);
end;

procedure TffpgCertPubIntimaAdvTests.TestarCertPubIntimaAdv;
begin
  ExecutarRoteiroTestes(CertPubIntimaAdv);
end;

procedure TffpgCertPubIntimaAdvTests.LiberarDocumento(const poWindow: IWindow);
var
  oTelaFinalizar: TfdigSelecaoCeritificadoDigital;
begin
  oTelaFinalizar := poWindow.asControl as TfdigSelecaoCeritificadoDigital;
  EnterTextInto(oTelaFinalizar.cbCertificados, FoDados.fpgCertificado);
  oTelaFinalizar.dxbbBotoesSelecionar.Click;
end;

end.


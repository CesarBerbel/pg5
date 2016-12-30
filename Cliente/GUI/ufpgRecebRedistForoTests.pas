unit ufpgRecebRedistForoTests;

interface

uses
  ufpgRecebRedistForo, ufpgGUITestCase, ufpgRecebRedistForoModelTests, ufpgDataModelTests;

type
  TffpgRecebRedistForoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRecebRedistForo;
    FoDados: TffpgRecebRedistForoModelTests;
    procedure RecebRedistForo;
    procedure PreencherDados;
    procedure FecharTelaResultadoDistribuicao;
  protected
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarRecebRedistForo;
  end;

implementation

uses
  TestFrameWork, uspInterface, usajConstante, ufpgFuncoesGUITestes,
  ufpgResultadoDistribuicao, ufpgVariaveisTestesGUI;

function TffpgRecebRedistForoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRecebRedistForoModelTests;
end;

procedure TffpgRecebRedistForoTests.TestarRecebRedistForo;
begin
  ExecutarRoteiroTestes(RecebRedistForo);
end;

procedure TffpgRecebRedistForoTests.RecebRedistForo;
begin
  AbrirTela;
  FoTela := TffpgRecebRedistForo(spTela);
  FoDados := TffpgRecebRedistForoModelTests(spDataModelTests);

  PreencherDados;
  FoTela.ccCadastro.Execute(acSalvar);
  FecharTelaResultadoDistribuicao;

  FecharTela;
  check(FoDados.fpgCdForo <> STRING_INDEFINIDO, 'Foro não informado');
  check(FoDados.VerificaForoProcesso(gsCDProcesso, FoDados.fpgCdForo),
    'Processo não está no foro correto.');
end;

procedure TffpgRecebRedistForoTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  checkFalse(FoTela.dfnuProcesso.FdfNumeroProcessoExterno.EstaNulo, 'Processo ' +
    FoDados.fpgNuProcesso + ' não foi encontrado neste foro para recebimento');

  EnterTextInto(FoTela.cbTipoDistribuicao, FoDados.fpgTipoDistribuicao, False);
  EnterTextInto(FoTela.csVara.dfcdVara, FoDados.fpgCdVara, False);
  FoTela.dfdeMotivo.spMemo.Text := FoDados.fpgMotivo;
end;

procedure TffpgRecebRedistForoTests.FecharTelaResultadoDistribuicao;
var
  FoTelaResultadoDistribuicao: TffpgResultadoDistribuicao;
begin
  FoTelaResultadoDistribuicao :=
    TffpgResultadoDistribuicao(PegarTela('ffpgResultadoDistribuicao'));
  CheckNotNull(FoTelaResultadoDistribuicao, 'Não achou a tela ffpgResultadoDistribuicao');
  FoTelaResultadoDistribuicao.Close;
end;

end.


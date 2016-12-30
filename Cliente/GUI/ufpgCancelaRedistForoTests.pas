unit ufpgCancelaRedistForoTests;

interface

uses
  ufpgCancelaRedistForo, ufpgGUITestCase, ufpgCancelaRedistForoModelTests, ufpgDataModelTests;

type
  TffpgCancelaRedistForoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCancelaRedistForo;
    FoDados: TffpgCancelaRedistForoModelTests;
    procedure CancelarRedistForo;
    procedure PreencherDados;
    procedure SelecionarFilaTrabalho;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCancelarRedistForo;
  end;

implementation

uses
  TestFrameWork, uspInterface, ufpgSelFilaTrabalhoCancelaRedistForo, usajConstante,
  ufpgFuncoesGUITestes, ufpgVariaveisTestesGUI;

function TffpgCancelaRedistForoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCancelaRedistForoModelTests;
end;

procedure TffpgCancelaRedistForoTests.TestarCancelarRedistForo;
begin
  ExecutarRoteiroTestes(CancelarRedistForo);
end;

procedure TffpgCancelaRedistForoTests.CancelarRedistForo;
begin
  AbrirTela;
  FoTela := TffpgCancelaRedistForo(spTela);
  FoDados := TffpgCancelaRedistForoModelTests(spDataModelTests);

  PreencherDados;

  FoTela.ccCadastro.Execute(acSalvar);

  if FoDados.fpgSelFilaObjeto then
  begin
    SelecionarFilaTrabalho;
  end;

  FecharTela;
  check(FoDados.VerificarEncaminhamentoProcesso(gsCDProcesso),
    'O encaminhamento não foi cancelado.');
end;

procedure TffpgCancelaRedistForoTests.SelecionarFilaTrabalho;
var
  oTelaSelFilaTrabalho: TffpgSelFilaTrabalhoCancelaRedistForo;
begin
  oTelaSelFilaTrabalho := PegarTela('ffpgSelFilaTrabalhoCancelaRedistForo') as
    TffpgSelFilaTrabalhoCancelaRedistForo;
  oTelaSelFilaTrabalho.Close;
end;

procedure TffpgCancelaRedistForoTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
  EnterTextInto(FoTela.dfdeMotivo.spMemo, FoDados.fpgMotivo);
end;

end.


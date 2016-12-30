unit ufpgRedistribuicaoForoTests;

interface

uses
  ufpgRedistribuicaoForo, ufpgGUITestCase, ufpgRedistribuicaoForoModelTests, ufpgDataModelTests;

type
  TffpgRedistribuicaoForoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRedistribuicaoForo;
    FoDados: TffpgRedistribuicaoForoModelTests;
    procedure RedistribuirForo;
    procedure PreencherDados;
  public
    procedure TearDown; override;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarRedistribuicaoForo;
  end;

implementation

uses
  TestFrameWork, uspInterface, ufpgFuncoesGUITestes, usajConstante, SysUtils,
  FutureWindows, ufpgVariaveisTestesGUI;

function TffpgRedistribuicaoForoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRedistribuicaoForoModelTests;
end;

procedure TffpgRedistribuicaoForoTests.TestarRedistribuicaoForo;
begin
  ExecutarRoteiroTestes(RedistribuirForo);
end;

procedure TffpgRedistribuicaoForoTests.RedistribuirForo;
var
  bEncaminhou: boolean;
begin
  AbrirTela;
  FoTela := TffpgRedistribuicaoForo(spTela);
  FoDados := TffpgRedistribuicaoForoModelTests(spDataModelTests);

  PreencherDados;

  bEncaminhou := False;
  if FoDados.fpgForoDestino = STRING_INDEFINIDO then
    spVerificadorTelas.RegistrarMensagem('O campo ''Foro destino'' deve ser informado.', 'OK')
  else if FoDados.fpgMotivo = STRING_INDEFINIDO then
    spVerificadorTelas.RegistrarMensagem('O campo ''Motivo'' deve ser informado.', 'OK')
  else
  begin
    spVerificadorTelas.RegistrarMensagem('O processo foi encaminhado para*', 'OK');
    bEncaminhou := True;
  end;

  if bEncaminhou then
    FoTela.ccCadastro.Execute(acSalvar)
  else
  begin
    StartExpectingException(EAbort);
    FoTela.ccCadastro.Execute(acSalvar);
  end;

  CheckTrue(FoDados.VerificarEncaminhamentoProcesso(gsCDProcesso, FoDados.fpgForoDestino),
    'O processo não foi encaminhado para outro foro');
end;

procedure TffpgRedistribuicaoForoTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecProc(FinalizarPendencia);
  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
  EnterTextInto(FoTela.csForo.dfCdForo, FoDados.fpgForoDestino);
  EnterTextInto(FoTela.dfdeMotivo.spMemo, FoDados.fpgMotivo);
end;

procedure TffpgRedistribuicaoForoTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.


unit ufpgCancelamentoProcessoTests;

interface

uses
  ufpgGUITestCase, ufpgCancelamentoProcessoModelTests, ufpgCancelamentoProcesso, ufpgDataModelTests;

type
  TffpgCancelamentoProcessoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCancelamentoProcesso;
    FoDados: TffpgCancelamentoProcessoModelTests;
    procedure PreencherDados;
    procedure RegistrarMensagens;
  public
    procedure CancelamentoProcesso;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCancelamentoProcesso;
  end;

implementation

{ TffpgCancelamentoProcessoTests }

uses
  TestFramework, ufpgFuncoesGUITestes, uspInterface, usajConstante, ufpgVariaveisTestesGUI,
  FutureWindows;

procedure TffpgCancelamentoProcessoTests.TestarCancelamentoProcesso;
begin
  ExecutarRoteiroTestes(CancelamentoProcesso);
end;

procedure TffpgCancelamentoProcessoTests.CancelamentoProcesso;
begin
  AbrirTela;
  FoTela := TffpgCancelamentoProcesso(spTela);
  FoDados := TffpgCancelamentoProcessoModelTests(spDataModelTests);

  PreencherDados;
  RegistrarMensagens;

  FoTela.ccCadastro.Execute(acSalvar);
  FecharTela;
  Check(FoDados.VerificarProcessoCancelado(gsCdProcesso), 'O processo ' +
    FoDados.fpgNuProcesso + ' não foi cancelado.');
end;

function TffpgCancelamentoProcessoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCancelamentoProcessoModelTests;
end;

procedure TffpgCancelamentoProcessoTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);

  FoTela.mmMotivo.spMemo.Text := FoDados.fpgMotivoCancelamento;
end;

procedure TffpgCancelamentoProcessoTests.RegistrarMensagens;
begin
  spVerificadorTelas.RegistrarMensagem('Confirma o cancelamento do processo?', 'Sim');
    spVerificadorTelas.RegistrarMensagem(
      'Deseja emitir a ficha do processo, que será utilizada como comprovante do cancelamento?',
      'Não');
end;

end.


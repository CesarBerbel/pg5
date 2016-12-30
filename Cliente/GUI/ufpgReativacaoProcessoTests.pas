//29/04/2016 - Shirleano.Junior - Task: 43061
// Refatorado.
unit ufpgReativacaoProcessoTests;

interface

uses
  ufpgReativacaoProcesso, ufpgGUITestCase, ufpgReativacaoProcessoModelTests,
  ufpgDataModelTests, FutureWindows;

type
  TffpgReativacaoProcessoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgReativacaoProcesso;
    FoDados: TffpgReativacaoProcessoModelTests;
    procedure PreencherDados;
    procedure ConfimarSalvamento(const poWindow: IWindow);
    procedure ReativacaoProcessoCancelado;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarReativacaoProcessoCancelado;
  end;

implementation

uses
  usajConstante, ufpgFuncoesGUITestes, ufpgVariaveisTestesGUI, TestFrameWork, uspInterface,
  Forms, SysUtils;

function TffpgReativacaoProcessoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgReativacaoProcessoModelTests;
end;

procedure TffpgReativacaoProcessoTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  EnterTextInto(FoTela.mmMotivo.spMemo, FoDados.fpgMotivoReativacao);
end;

procedure TffpgReativacaoProcessoTests.ConfimarSalvamento(const poWindow: IWindow);
begin
  PressionarSimNaTelaDeConfirmacao(poWindow);
  Application.ProcessMessages;
end;

procedure TffpgReativacaoProcessoTests.ReativacaoProcessoCancelado;
begin
  AbrirTela;
  FoTela := TffpgReativacaoProcesso(spTela);
  FoDados := (Self.spDataModelTests) as TffpgReativacaoProcessoModelTests;

  PreencherDados;

  spVerificadorTelas.PararVerificacao;
  TFutureWindows.Expect('TMessageForm', 1000).ExecProc(ConfimarSalvamento);
  FoTela.ccCadastro.Execute(acSalvar);
  spVerificadorTelas.IniciarVerificacao;

  FecharTela;
  Check(FoDados.RetornarProcessoReativado(gsCdProcesso), 'O processo ' +
    FoDados.fpgNuProcesso + ' não foi reativado!');
end;

procedure TffpgReativacaoProcessoTests.TestarReativacaoProcessoCancelado;
begin
  ExecutarRoteiroTestes(ReativacaoProcessoCancelado);
end;

end.


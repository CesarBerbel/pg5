unit ufpgCadJuntadaPetTests;

interface

uses
  ufpgCadJuntadaPet, ufpgGUITestCase, ufpgCadJuntadaPetModelTests, FutureWindows,
  ufpgDataModelTests;

var
  FsNumeroProcesso: string;

type
  TffpgCadJuntadaPetTests = class(TfpgGUITestCase)
  private
    procedure CadastroBasicoJuntadaPet;
    procedure PreencherDados;
    procedure PegarTelaModal(const poWindow: IWindow);
  public
    FoTela: TffpgCadJuntadaPet;
    FoDados: TffpgCadJuntadaPetModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastroBasicoJuntadaPet;
  end;

implementation

uses
  TestFrameWork, Windows, Forms, SysUtils, uspInterface, ufpgCadProcessoDependente,
  uproConsPeticaoIntermEletronica, ufpgConstanteGUITests, ufpgSelecionaDependente,
  ufpgFuncoesGUITestes, ufpgVariaveisTestesGUI, usajConstante;

{ TffpgCadJuntadaPetTests }

function TffpgCadJuntadaPetTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadJuntadaPetModelTests;
end;

procedure TffpgCadJuntadaPetTests.CadastroBasicoJuntadaPet;
begin
  FoDados := tffpgCadJuntadaPetModelTests(spDataModelTests);
  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgCadJuntadaPet');

  FoTela := TffpgCadJuntadaPet(spTela);

  PreencherDados;

  FecharTela;
  check(FoDados.VerificarJuntada(FoDados.fpgNuProcesso), 'A juntada não foi ralizada.');
end;

procedure TffpgCadJuntadaPetTests.PreencherDados;
begin
  if FoDados.fpgUtilizaArquivoExterno then
    FoDados.fpgNuProcesso := LerVariavelExterna('nuprocesso')
  else if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  TFutureWindows.Expect('TffpgSelecionaDependente').ExecProc(PegarTelaModal);

  spVerificadorTelas.RegistrarMensagem(
    'A juntada da(s) petição(ões) foi concluída com sucesso.', 'OK');

  if FoDados.fpgAbrirDoMenu then
    EnterTextInto(FoTela.edNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  Application.ProcessMessages;

  TFutureWindows.Expect('TffpgAssistente', 1000).ExecCloseWindow;

  FoTela.ccCadastro.Execute(acSalvar);
end;

procedure TffpgCadJuntadaPetTests.PegarTelaModal(const poWindow: IWindow);
var
  oTela: TffpgSelecionaDependente;
begin
  oTela := poWindow.asControl as TffpgSelecionaDependente;
  oTela.ccProcesso.Execute(acSelecionarTodos);
  oTela.ccProcesso.Execute(acSelecionar);
end;

procedure TffpgCadJuntadaPetTests.TestarCadastroBasicoJuntadaPet;
begin
  ExecutarRoteiroTestes(CadastroBasicoJuntadaPet);
end;

end.


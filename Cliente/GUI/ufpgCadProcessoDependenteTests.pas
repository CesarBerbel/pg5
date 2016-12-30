unit ufpgCadProcessoDependenteTests;

interface

uses
  ufpgGUITestCase, ufpgDataModelTests, ufpgCadProcessoDependenteMoldelTests,
  ufpgCadProcessoDependente;

type
  TffpgCadProcessoDependenteTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadProcessoDependente;
    FoDados: TffpgCadProcessoDependenteMoldelTests;
    procedure CadProcessoDependente;
    procedure PreencherDadosPrincipais;
    procedure CopiarPartes;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadProcessoDependente;
  end;

implementation

uses
  SysUtils, TestFramework, usajCopiaParte, FutureWindows, ufpgVariaveisTestesGUI,
  uspInterface, ufpgFuncoesGUITestes, usajConstante;

{ TffpgCadProcessoDependenteCompletoTests }

function TffpgCadProcessoDependenteTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadProcessoDependenteMoldelTests;
end;

procedure TffpgCadProcessoDependenteTests.TestarCadProcessoDependente;
begin
  ExecutarRoteiroTestes(CadProcessoDependente);
end;

procedure TffpgCadProcessoDependenteTests.CadProcessoDependente;
begin
  FoDados := TffpgCadProcessoDependenteMoldelTests(spDataModelTests);
  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgCadProcessoDependente');

  FoTela := TffpgCadProcessoDependente(spTela);

  PreencherDadosPrincipais;

  if FoDados.fpgCopiarPartes then
    CopiarPartes;

  FoTela.ccCadastro.Execute(acSalvar);

  if FoDados.fpgJuntarPeticao then
    FoTela.pbJuntada.Click;

  if FoDados.fpgApenser then
    FoTela.pbApensar.Click;

  if FoDados.fpgFecharTela then
    FecharTela;
end;


procedure TffpgCadProcessoDependenteTests.PreencherDadosPrincipais;
begin
  if FoDados.fpgUtilizaArquivoExterno then
    FoDados.fpgNuProcesso := LerVariavelExterna('nuprocesso')
  else if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  if FoDados.fpgAbrirDoMenu then
    check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  if FoDados.fpgAbrirDoMenu then
    FoTela.ccCadastro.Execute(acNovo);
  checkFalse(FoTela.dfnuProtocolo.EstaNulo, 'Nenhum protocolo foi encontrado');
  EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgCdClasse, False);
end;

procedure TffpgCadProcessoDependenteTests.CopiarPartes;
var
  oTelaCopiaParte: TfsajCopiaParte;
begin
  FoTela.PageControl.ActivePage := FoTela.tsParticipacao;
  FoTela.PageControlChange(FoTela.PageControl);
  FoTela.fpgProcessoParte.pbMostraCopiarPartes.Click;

  oTelaCopiaParte := PegarTela('fsajCopiaParte') as TfsajCopiaParte;
  with oTelaCopiaParte do
  begin
    pbMarcarTodosGeral.Click;
    tlParticipacao.BeginUpdate;
    esajParte.First;
    esajParte.Edit;
    esajParte['cdTipoParte'] := 1;
    esajParte.Post;
    esajParte.Next;
    esajParte.Edit;
    esajParte['cdTipoParte'] := 2;
    esajParte.Post;
    tlParticipacao.EndUpdate;
    ccCadastro.Execute(acSelecionar);
  end;
end;

end.


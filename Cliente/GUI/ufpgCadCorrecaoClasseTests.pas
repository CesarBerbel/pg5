unit ufpgCadCorrecaoClasseTests;

interface

uses
  ufpgCadCorrecaoClasse, ufpgGUITestCase, ufpgCadCorrecaoClasseModelTests,
  ufpgDataModelTests, ufpgVariaveisTestesGUI, ufpgDUnitDAO, ufpgConstanteGUITests;

type
  TffpgCadCorrecaoClasseTests = class(TfpgGUITestCase)
  private
    procedure CorrecaoDeClasse;
    procedure PreencherDados;
    procedure PegarTelaRedistribuicao;
  public
    FoTela: TffpgCadCorrecaoClasse;
    FoDados: TffpgCadCorrecaoClasseModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarCorrecaoDeClasse;
  end;

var
  sNuProcesso: string;

implementation

uses
  ufpgFuncoesGUITestes, TestFrameWork, uspInterface, FutureWindows, SysUtils,
  ufpgRedistribComCorrecao, Forms, usajConstante;

procedure TffpgCadCorrecaoClasseTests.CorrecaoDeClasse;
begin
  AbrirTela;
  FoTela := TffpgCadCorrecaoClasse(spTela);
  FoDados := TffpgCadCorrecaoClasseModelTests(spDataModelTests);

  PreencherDados;

  if gsCliente <> CS_CLIENTE_PG5_TJSP then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'A correção dessa classe irá causar uma redistribuição do processo. Deseja continuar?',
      '&Sim');
  end
  else
  begin
    spVerificadorTelas.RegistrarMensagem('A correção de classe foi realizada*', 'OK');
    spVerificadorTelas.RegistrarMensagem('A classe do processo foi alterada para*', 'OK');
  end;

  FoTela.ccCadastro.Execute(acSalvar);

  if gsCliente <> CS_CLIENTE_PG5_TJSP then
    PegarTelaRedistribuicao;

  Check(FoDados.RetornarCorrecaoClasse(FoDados.fpgNuProcesso),
    'Correção de classe não foi alterada com sucesso.');
end;

function TffpgCadCorrecaoClasseTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadCorrecaoClasseModelTests;
end;

procedure TffpgCadCorrecaoClasseTests.PegarTelaRedistribuicao;
var
  oTela: TffpgRedistribComCorrecao;
begin
  oTela := PegarTela('ffpgRedistribComCorrecao') as TffpgRedistribComCorrecao;
  spVerificadorTelas.RegistrarMensagem(
    'A correção de classe foi realizada. Como se trata de um processo digital, não requer etiqueta de autuação.'
    ,
    'OK');

  spVerificadorTelas.RegistrarMensagem('A classe do processo foi alterada para *', 'OK');

  oTela.dfdeMotivo.Lines.Add(FoDados.fpgMotivo);
  oTela.ccCadastro.Execute(acSalvar);
  Application.ProcessMessages;
end;

procedure TffpgCadCorrecaoClasseTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  TFutureWindows.Expect('TfsajAssistente').ExecProc(FecharJanelaModal);
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
  EnterTextInto(FoTela.csClasseCorrecao.dfCodigo, FoDados.fpgClasse);
  EnterTextInto(FoTela.csCompetencia.dfCdTipoCartorio, FoDados.fpgCompetencia);
  FoTela.mmdeObservacao.Lines.Add(FoDados.fpgMotivo);
end;

procedure TffpgCadCorrecaoClasseTests.TearDown;
begin
  FecharTela;
  inherited;
end;

procedure TffpgCadCorrecaoClasseTests.TestarCorrecaoDeClasse;
begin
  ExecutarRoteiroTestes(CorrecaoDeClasse);
end;

end.


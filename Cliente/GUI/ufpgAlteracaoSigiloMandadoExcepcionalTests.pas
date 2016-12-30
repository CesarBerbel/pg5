unit ufpgAlteracaoSigiloMandadoExcepcionalTests;

interface

uses
  ufpgAlteracaoSigiloMandadoExcepcional, ufpgGUITestCase,
  ufpgAlteracaoSigiloMandadoExcepcionalModelTests, ufpgDataModelTests;

type
  TffpgAlteracaoSigiloMandadoExcepcionalTests = class(TfpgGUITestCase)
  private
    procedure PreencherDadosAlteracaoMandado;
    procedure AlteracaoMandadoExcepcional;
  public
    FoTela: TffpgAlteracaoSigiloMandadoExcepcional;
    FoDados: TffpgAlteracaoSigiloMandadoExcepcionalModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarAlteracaoMandadoExcepcional;
  end;

implementation

uses
  Forms, FutureWindows, SysUtils, uspInterface, TestFramework, ufpgFuncoesGUITestes,
  usajAssistente, ufpgVariaveisTestesGUI, usajConstante;

{ TffpgAlteracaoSigiloMandadoExcepcionalTests }

function TffpgAlteracaoSigiloMandadoExcepcionalTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgAlteracaoSigiloMandadoExcepcionalModelTests;
end;

procedure TffpgAlteracaoSigiloMandadoExcepcionalTests.TestarAlteracaoMandadoExcepcional;
begin
  ExecutarRoteiroTestes(AlteracaoMandadoExcepcional);
end;

procedure TffpgAlteracaoSigiloMandadoExcepcionalTests.AlteracaoMandadoExcepcional;
begin
  AbrirTela;
  FoTela := TffpgAlteracaoSigiloMandadoExcepcional(spTela);
  FoDados := TffpgAlteracaoSigiloMandadoExcepcionalModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.smdNumeroMandado.sajNumeroProcesso.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);

  PreencherDadosAlteracaoMandado;

  FoTela.ccCadastro.Execute(acSalvar);

  if FoDados.fpgSigiloExterno then
    check(FoDados.VerificarSigiloExternoMandado('S',
      FoTela.smdNumeroMandado.dfnuMandado.PegaTexto),
      'Processo não foi alterado para sigilo externo.');

  FecharTela;
end;

procedure TffpgAlteracaoSigiloMandadoExcepcionalTests.PreencherDadosAlteracaoMandado;
begin
  if FoDados.fpgSigiloExterno then
  begin
    EnterTextCheckBox(FoTela.ckSigiloExterno, FoDados.fpgSigiloExterno);
    check((FoDados.fpgPoloAcesso <> ''), 'Favor informar Polo para acesso.');
    EnterTextInto(FoTela.cbPoloSigiloExterno, FoDados.fpgPoloAcesso);
  end;
end;

end.


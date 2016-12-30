unit ufpgCadMandadoExcepcionalSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCadMandadoExcepcionalTests,
  ufpgEdicaoDocumentoTests, ufpgEditorTests, ufpgVariaveisTestesGUI,
  ufpgConstanteGUITests, ufpgDigPecaProcessualTests, ufpgAlteracaoSigiloMandadoExcepcionalTests;

implementation

const
  CS_CAMINHO_TESTE = 'Mandado Excepcional';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoAlteracaoMandando'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMandadoExcepcionalTests.Create(
      'TestarEmissaodeMandadoExcepcional', 'TestarEmissaodeMandadoExcepcional'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgAlteracaoSigiloMandadoExcepcionalTests.Create(
      'TestarAlteracaoMandadoExcepcional', 'TestarAlteracaoMandadoExcepcional', 1, True));
  end;

end.


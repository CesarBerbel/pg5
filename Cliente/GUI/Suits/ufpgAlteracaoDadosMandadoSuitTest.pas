unit ufpgAlteracaoDadosMandadoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgEdicaoDocumentoTests, ufpgEditorTests,
  ufpgVariaveisTestesGUI, ufpgConstanteGuiTests, ufpgAlteracaoFormaPgtoTests,
  ufpgAlteracaoPrazoTests, ufpgCancelamentoMandadoTests;

const
  CS_CAMINHO_TESTE = 'Altera��o dos dados do mandado';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoAlteracaoMandando'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmitirMandado'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgAlteracaoFormaPgtoTests.Create(
      'TestarAlteracaoFormaPgto', 'TestarAlteracaoFormaPgto'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgAlteracaoPrazoTests.Create('TestarAlteracaoPrazo',
      'TestarAlteracaoPrazo'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCancelamentoMandadoTests.Create(
      'TestarCancelamentoMandado', 'TestarCancelamentoMandado'));
  end;

end.


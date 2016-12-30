unit ufpgAlteracaoAtosMandadoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgEdicaoDocumentoTests, ufpgEditorTests,
  ufpgVariaveisTestesGUI, ufpgConstanteGuiTests, ufpgAlteracaoFormaPgtoTests,
  ufpgAlteracaoPrazoTests, ufpgCancelamentoMandadoTests;

const
  CS_CAMINHO_TESTE = 'Altera��o dos atos do mandado';

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
  end;
end.


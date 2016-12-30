unit ufpgVerDuplicidadePessoaConfAtoSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgEdicaoDocumentoTests, ufpgEditorTests, ufpgVisualizaFluxoTrabalhoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Verificar Duplicidade Pessoa Configura��o Atos';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadastrarProcessoTarjaUrgente'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'TestarEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmitirMandadoCitacaoAto'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarEmitirAtoOrdinatorio', 1, True));
  end;
end.


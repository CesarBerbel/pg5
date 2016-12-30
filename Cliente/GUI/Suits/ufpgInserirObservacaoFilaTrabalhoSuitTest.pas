unit ufpgInserirObservacaoFilaTrabalhoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgVisualizaFluxoTrabalhoTests,
  ufpgEdicaoDocumentoTests, ufpgEditorTests, ufpgGerenciadorArquivoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Inserir observação fila fluxo trabalho';

initialization

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'CadastroProcessoSimples'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
    'TestarFluxoTrabalho', 'TestarInserirObservacaoFilaTrabalho_1_4_4'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
    'TestarInserirObservacaoFilaTrabalho_1_4_4'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
    'TestarInserirObservacaoFilaTrabalho_1_4_4'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
    'TestarGerenciadorArquivos', 'TestarInserirObservacaoFilaTrabalho_1_4_4', 1, True));
end.


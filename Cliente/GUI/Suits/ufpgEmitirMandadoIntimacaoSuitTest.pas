unit ufpgEmitirMandadoIntimacaoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgVisualizaFluxoTrabalhoTests,
  ufpgCadPautaAudienciaTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgEdicaoDocumentoTests, ufpgEditorTests, ufpgRedistribLoteVagaTests,
  ufpgGerenciadorArquivoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Emitir mandado de intimação.';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoMandadoIntimacao'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadPautaAudienciaTests.Create(
      'TestarCadPautaAudiencia', 'TestarCadPautaAudiencia'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'TestarEmitirMandadoIntimacao'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmissaoDespacho'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarEmissaoDespacho'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'TestarImpressaoVisualizacao'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRedistribLoteVagaTests.Create(
      'TestarRedistribuicaoEntreVaga', 'TestarDistribuirMandadoIntimacao'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgGerenciadorArquivoTests.Create(
      'TestarGerenciadorArquivos', 'TestarAssinarDocumentoJuizMandado', 1, True));

    //  RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
    //    'TestarFluxoTrabalho', 'TestarEmitirMandadoIntimacaoFinalizar'));
  end;

end.


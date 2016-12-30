unit ufpgFluxoMandadoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCalcCustaCompletaInicialProcTests,
  ufpgEdicaoDocumentoTests, ufpgEditorTests, ufpgVisualizaFluxoTrabalhoTests,
  ufpgCadGrjBaixaTests, ufpgConsultaDadosMandadoTests, ufpgConsultaMandadosTests,
  usmdRemessaAgenteCentralCompletaTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  usmdRemessaCartorioCentralTests, usmdRecebimentoCentralCartorioTests;

implementation

const
  CS_CAMINHO_TESTE = 'Fluxo de mandados\Digital';
  CS_CAMINHO_TESTE_FF = 'Fluxo de mandados\Físico';
  CS_CAMINHO_TESTE_CONSULTA_SP = 'Fluxo de mandados\Consulta Avançada de mandados';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarGeracaoImpressaoGRJ_1_6_1_A'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCalcCustaCompletaInicialProcTests.Create(
      'TestarCustaInicialProcesso', 'TestarGeracaoImpressaoGRJ_1_6_1'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadGrjBaixaTests.Create('TestarBaixaDeGuias',
      'TestarGeracaoImpressaoGRJ_1_6_1'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarGeracaoImpressaoGRJ_1_6_2_A'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarGeracaoImpressaoGRJ_1_6_2_A'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'TestarEnvioParaFilaAgDistribuicaoCentral_1_6_3'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'DistribuirMandadoAtividadeFluxo_1_6_4'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgConsultaDadosMandadoTests.Create(
      'TestarConsultaBasicaMandado'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgConsultaMandadosTests.Create(
      'TestarConsultaAvancadaMandado'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'EnviarParaFilaAgImpressaoCentral_1_6_6'));


    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'CertificacaoDoMandadoPeloFluxo_1_6_7'));

    RegisterTest(CS_CAMINHO_TESTE, TfsmdRemessaAgenteCentralCompletaTests.Create(
      'TestarRemessaAgenteCentralCompleta', 'TestarCertificacaoDoMandadoPeloFluxo_1_6_7'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarCertificacaoDoMandadoPeloFluxo_1_6_7'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarCertificacaoDoMandadoPeloFluxo_1_6_7', 1, True));

    //  RegisterTest(CS_CAMINHO_TESTE, TffpgConsultaDadosMandadoTests.Create(
    //    'TestarConsultaBasicaMandado', 'TestarConsultaBasicaMandados_1_6_9_1'));
  end;

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin

    //    RegisterTest(CS_CAMINHO_TESTE_FF, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    //      'TestarCadProcesssoMandado'));

    //    RegisterTest(CS_CAMINHO_TESTE_FF, TffpgEdicaoDocumentoTests.Create(
    //      'TestarEmitirDocumento', 'TestarEmissaoMandadoFisico'));

    //    RegisterTest(CS_CAMINHO_TESTE_FF, TffpgEditorTests.Create('TestarEditor',
    //      'TestarEmissaoMandadoFisico'));

    //    RegisterTest(CS_CAMINHO_TESTE_FF, TfsmdRemessaCartorioCentralTests.Create(
    //      'TestarRemessaCartorioCentral', STRING_INDEFINIDO));

    //    RegisterTest(CS_CAMINHO_TESTE_FF, TfsmdRecebimentoCentralCartorioTests.Create(
    //      'TestarRecebimentoCentralCartorio', STRING_INDEFINIDO, 1, True));

    //------------------------------ Consulta Avançada de Mandados ------------------------------\\

    RegisterTest(CS_CAMINHO_TESTE_CONSULTA_SP, TffpgCadProcessoTests.Create(
      'TestarCadastroProcesso', 'CadastroProcessoMandadoIntimacao'));

    RegisterTest(CS_CAMINHO_TESTE_CONSULTA_SP, TffpgEdicaoDocumentoTests.Create(
      'TestarEmitirDocumento', 'TestarEmissaoMandado'));

    RegisterTest(CS_CAMINHO_TESTE_CONSULTA_SP, TffpgEditorTests.Create('TestarEditor',
      'TestarEmissaoMandado'));

    RegisterTest(CS_CAMINHO_TESTE_CONSULTA_SP, TffpgConsultaMandadosTests.Create(
      'TestarConsultaAvancadaMandado', 'TestarConsultaAvancadaMandado', 1, True));
  end;
end.


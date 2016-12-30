unit ufpgFluxoARSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgMaterializaProcessoTests, ufpgRemessaTests,
  usajconstante, ufpgRecebimentoTests, ufpgEdicaoDocumentoTests,
  ufpgEditorTests, ucgoRemessaARTests, ucgoConsCargaARTests, ucgoRecebimentoARTests,
  usarGuiaRemECTTests, usarRegDevolucaoTests, usarAlteracaoARsTests,
  ufpgRegMvJuntadaTests, usarCancelJuntadaTests, usarConsARsJuntPendTests;

implementation

const
  CS_CAMINHO_TESTE = 'Fluxo de AR';

initialization
  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'CadastroProcessoSimples'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessoTests.Create(
    'TestarMaterializaProcesso', STRING_INDEFINIDO));

  RegisterTest(CS_CAMINHO_TESTE, TffpgRemessaTests.Create('TestarRemessaCarga',
    'TestarModelosFormaPostagemAR_1_3_5'));


  RegisterTest(CS_CAMINHO_TESTE, TffpgRecebimentoTests.Create('TestarReceberRemessa',
    'TestarModelosFormaPostagemAR_1_3_5'));


  RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
    'TestarModelosFormaPostagemAR_1_3_5'));


  RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
    'TestarModelosFormaPostagemAR_1_3_5'));

  RegisterTest(CS_CAMINHO_TESTE, TfcgoRemessaARTests.Create('TestarRemessaAR',
    'TestarRemeterAR_1_3_6'));


  RegisterTest(CS_CAMINHO_TESTE, TfcgoConsCargaARTests.Create('TestarConsultaCargaAR',
    'TestarConsultarARRemetidos_1_3_7'));


  RegisterTest(CS_CAMINHO_TESTE, TfcgoRecebimentoARTests.Create('TestarRecebimentoAR',
    'TestarReceberARSetorExpedicao_1_3_8'));


  RegisterTest(CS_CAMINHO_TESTE, TfsarGuiaRemECTTests.Create('TestarGuiaRemessaCT',
    'TestarGerarGuiaPostagem_1_3_9'));


  RegisterTest(CS_CAMINHO_TESTE, TfsarRegDevolucaoTests.Create('TestarRegDevolucao',
    'TestarRealizarDevolucaoARECT_1_3_10'));

  RegisterTest(CS_CAMINHO_TESTE, TfcgoRemessaARTests.Create('TestarRemessaAR',
    'TestarRemeterARCartorio_1_3_11'));

  RegisterTest(CS_CAMINHO_TESTE, TfcgoRecebimentoARTests.Create('TestarRecebimentoAR',
    'TestarReceberARExpedicao_1_3_12'));


  RegisterTest(CS_CAMINHO_TESTE, TfsarAlteracaoARsTests.Create('TestarAlterarArs',
    'TestarAlterarAR_1_3_13'));


  RegisterTest(CS_CAMINHO_TESTE, TffpgRegMvJuntadaTests.Create('TestarRegMvJuntada',
    'TestarJuntadaAR_1_3_14'));


  RegisterTest(CS_CAMINHO_TESTE, TfsarCancelJuntadaTests.Create('TestarCancelamentoJuntada',
    'TestarCancelarJuntadaAR_1_3_15'));


  RegisterTest(CS_CAMINHO_TESTE, TfsarConsARsJuntPendTests.Create(
    'TestarConsultarARcomJuntadaPendente', 'TestarConsultarARcomJuntadaPendente_1_3_16', 1, True));
end.


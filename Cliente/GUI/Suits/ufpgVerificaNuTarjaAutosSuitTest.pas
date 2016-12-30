unit ufpgVerificaNuTarjaAutosSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgVisualizaProcessoTests,
  ufpgCadProcessoTests, ufpgEdicaoDocumentoTests, ufpgEditorTests;

implementation

const
  CS_CAMINHO_TESTE = 'Testar número de processo da tarja de assinatura';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmissaoExpedientesNormal'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarEmissaoNuTarja'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaProcessoTests.Create(
      'TestarVisualizacaoAutos', 'TestarNuProcessoTarja', 1, True));
  end;
end.


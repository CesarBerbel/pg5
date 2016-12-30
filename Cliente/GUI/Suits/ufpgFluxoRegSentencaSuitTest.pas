unit ufpgFluxoRegSentencaSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgCadMovimentacaoUnitariaTests, ufpgEdicaoDocumentoTests, ufpgEditorTests,
  ufpgCadRegSentencaTests, ufpgConsRegSentencaTests;


implementation

const
  CS_CAMINHO_TESTE = 'Cadastro de registro e consulta de sentença';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarGerarSenhaProcesso'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarCadastrarMovUnitaria', 'TestarCadastrarMovSentenca'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'CadRegSentenca'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor', 'CadRegSentenca'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadRegSentencaTests.Create('TestarCadRegSenteca',
      'CadRegSentenca'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgConsRegSentencaTests.Create(
      'TestarConsultaRegistroSentenca', 'TestarConsultaRegistroSentenca_1_2_28', 1, True));
  end;

end.


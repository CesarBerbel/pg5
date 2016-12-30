unit ufpgCadRegSentencaSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgEdicaoDocumentoTests, ufpgEditorTests,
  ufpgCadRegSentencaTests, ufpgConstanteGUITests;

implementation

const
  CS_CAMINHO_TESTE = 'Registro de Sentença';

initialization

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'TestarGerarSenhaProcesso'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
    'CadRegSentenca'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor', 'CadRegSentenca'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadRegSentencaTests.Create('TestarCadRegSenteca',
    'CadRegSentenca', 1, True));

end.


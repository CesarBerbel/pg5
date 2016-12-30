unit ufpgEditorSuitTests;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgEditorTests;

implementation

const
  CS_CAMINHO_TESTE = 'Testar Editor\';

initialization
  // 06/10/2016  - Carlos.Gaspar - TASK: 50921 - Comentado
  //  RegisterTest(CS_CAMINHO_TESTE + ' corrigir texto', TffpgEditorTests.Create(
  //    'TestarEditor', 'TestarCorrigirTexto'));

  RegisterTest(CS_CAMINHO_TESTE + ' Salvar documento',
    TffpgEditorTests.Create('TestarEditor', 'TestarSalvarDocumento'));

  RegisterTest(CS_CAMINHO_TESTE + ' exportar e importar',
    TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

  RegisterTest(CS_CAMINHO_TESTE + ' exportar e importar',
    TffpgEditorTests.Create('TestarEditor', 'TestarExportarImportar', 1, True));
end.


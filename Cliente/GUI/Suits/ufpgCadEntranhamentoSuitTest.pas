unit ufpgCadEntranhamentoSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgCadEntranhamentoTests, ufpgMaterializaProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Entranhamento e Desentranhamento de Processos';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarApensarProcesso', 2))
  else if gsCliente = CS_CLIENTE_PG5_TJSP then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalDirecionada', 2))
  else
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_CIVIL_GENERICO_DIRECIONADA, 2));

  RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessoTests.Create(
    'TestarMaterializaProcesso', '', 2));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadEntranhamentoTests.Create(
    'TestarCadastroEntranhamento', '', 1));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadEntranhamentoTests.Create(
    'TestarCadastroDesentranhamento', '', 1, True));

end.


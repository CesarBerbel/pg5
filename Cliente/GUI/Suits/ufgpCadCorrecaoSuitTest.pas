unit ufgpCadCorrecaoSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgCadCorrecaoClasseTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro de correção de classe';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoSimples'))
  else
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_SORTEIO));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadCorrecaoClasseTests.Create(
      'TestarCorrecaoDeClasse', '', 1, True));
end.


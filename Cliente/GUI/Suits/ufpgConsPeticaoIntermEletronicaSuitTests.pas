unit ufpgConsPeticaoIntermEletronicaSuitTests;

interface

uses
  TestFramework, ufpgConsPeticaoIntermEletronicaTests, ufpgCadProcessoDependenteTests,
  ufpgConstanteGUITests, ufpgVariaveisTestesGUI, usajConstante, ufpgExecutarRoteiroPROTests,
  ufpgCadProcessoTests, ufpgCadProcExcepcionalTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro Petições Intermediárias Aguardando Cadastro';

initialization
  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    CS_PROCESSO_CIVIL_GENERICO_DIRECIONADA));

  RegisterTest(CS_CAMINHO_TESTE, TffpgExecutarRoteiroPROTests.Create(
    'TestarPeticaoIntermediaria'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgConsPeticaoIntermEletronicaTests.Create(
    'TestarCadastrarPeticaoIntermediaria', STRING_INDEFINIDO));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoDependenteTests.Create(
    'TestarCadProcessoDependente', STRING_INDEFINIDO, 1, True));

end.


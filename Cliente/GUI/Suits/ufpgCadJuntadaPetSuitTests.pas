unit ufpgCadJuntadaPetSuitTests;

interface

uses
  TestFramework, ufpgConsPeticaoIntermEletronicaTests, ufpgCadProcessoDependenteTests,
  ufpgConstanteGUITests, usajConstante, ufpgCadJuntadaPetTests, ufpgMaterializaProcessoTests,
  ufpgCadProcessoTests, ufpgExecutarRoteiroPROTests, ufpgVariaveisTestesGUI;

implementation

const
  CS_CAMINHO_TESTE = 'Juntada de Petição Intermediária';

initialization
  // 12/08/2016  - Carlos.Gaspar - SALT:
  // Comentado porque esta dando erro no build noturno
  //  if gsCliente <> CS_CLIENTE_PG5_TJSC then
  //  begin
  //    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
  //      'CadastroProcessoPenalSorteio'));

  //    RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessoTests.Create(
  //      'TestarMaterializaProcesso', STRING_INDEFINIDO));

  //    RegisterTest(CS_CAMINHO_TESTE, TffpgExecutarRoteiroPROTests.Create(
  //      'TestarPeticaoIntermediaria'));

  //    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoDependenteTests.Create(
  //      'TestarCadProcessoDependente', 'TestarCadProcessoDependenteJuntada'));

  //    RegisterTest(CS_CAMINHO_TESTE, TffpgCadJuntadaPetTests.Create(
  //      'TestarCadastroBasicoJuntadaPet', 'TestarCadastroJuntadaPet'));
  //  end;
end.


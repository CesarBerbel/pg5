unit ufpgEvolucaoDeClasseSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  usajConstante, ufpgCadEvolucaoClasseTests, ufpgCadMovimentacaoUnitariaTests;

implementation

const
  CS_CAMINHO_TESTE = 'Evolução de Classe';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoCriminalDirecionadoSimples'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadEvolucaoClasseTests.Create(
      'TestarCadastrarEvolucaoClasse', 'CadastroEvolucaoClasse'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarVerificarMovUnitaria', 'TestarVisualizarMovEvolucaoClasse', 1, True));
  end;

end.


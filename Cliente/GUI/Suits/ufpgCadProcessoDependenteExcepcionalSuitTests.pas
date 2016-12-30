unit ufpgCadProcessoDependenteExcepcionalSuitTests;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgCadProcessoDependenteExcepcionalTests, ufpgCadMovimentacaoUnitariaTests;

const
  CS_CAMINHO_TESTE = 'Cadastrar Cumprimento Sentença';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalSimples'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoDependenteExcepcionalTests.Create(
      'TestarCadProcessoDependenteExcepcional', ''));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarCadastrarMovUnitaria', 'TestarCumprimentoSentenca', 1, True));
  end;
end.


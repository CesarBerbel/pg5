unit ufpgCadPecSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCadHistoricoParteTests, ufpgConstanteGUITests,
  ufpgCadPecTests, usajConstante, ufpgCadMovimentacaoUnitariaTests, ufpgFuncoesGUITestes,
  ufpgVariaveisTestesGUI;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro do PEC';


initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin

    //Cadastro de PEC
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalSimples'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadHistoricoParteTests.Create(
      'TestarHistoricoPartes', 'TestarRelatorioMultasDeVarasExecucoesPenais_1_10_3_1'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadPecTests.Create('TestarCadastroDoPEC',
      STRING_INDEFINIDO, 1, True));

    RegisterTest(CS_CAMINHO_TESTE + ' em lote', TffpgCadProcessoTests.Create(
      'TestarCadastroProcesso', 'CadastroProcessoCriminalDirecionadoSimples'));

    RegisterTest(CS_CAMINHO_TESTE + ' em lote', TffpgCadHistoricoParteTests.Create(
      'TestarHistoricoPartes', 'TestarRelatorioMultasDeVarasExecucoesPenais_1_10_3_1', 1, True));

  end;
end.


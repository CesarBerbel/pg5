unit ufpgCadUnificacaoSuitTests;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgCadUnificacaoTests, ufpgDesmembraProcTests, ufpgCadParteRepresTests,
  ufpgCadMovimentacaoUnitariaTests;

const
  CS_CAMINHO_TESTE = 'Unificação e Desmembramento de Processo';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalSimples', 2));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadUnificacaoTests.Create('TestarUnificacaoProcessos',
      'TestarUnificacaoDesmembramentoDeProcessos_1_2_17_5'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgDesmembraProcTests.Create(
      'TestarDesmembramentoDeProcessos', 'TestarUnificacaoDesmembramentoDeProcessos_1_2_17_5'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarVerificarMovUnitaria', 'TestarUnificacaoDesmembramentoDeProcessos_1_2_17_5',
      1, True));
  end;
end.


unit ufpgRelExtratoProcSuitTest;

interface

uses
  TestFramework, ufpgRelExtratoProcTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgRelFichaProcTests, ufpgCadProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Relatório Extrato e Ficha do Processo 1_2_31';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRelExtratoProcTests.Create(
      'TestarRelExtratoProcesso', ''));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRelFichaProcTests.Create('TestarRelFichaProcesso1_2_31',
      '', 1, True));
  end;
end.


unit ufpgRelFichaProcSuitTests;

interface

uses
  TestFramework, ufpgRelFichaProcTests, ufpgCadProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Relatório Ficha Processo 1_2_31';

initialization

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'ProcessoPenalGenerico'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgRelFichaProcTests.Create('TestarRelFichaProcesso',
    '', 1, True));
end.


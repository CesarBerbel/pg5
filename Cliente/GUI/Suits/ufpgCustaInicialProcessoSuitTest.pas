unit ufpgCustaInicialProcessoSuitTest;

interface

uses
  TestFramework, ufpgCalcCustaCompletaInicialProcTests, usajConstante;

implementation

const
  CS_CAMINHO_TESTE = 'Custa Inicial Processo';

initialization
  RegisterTest(CS_CAMINHO_TESTE, TffpgCalcCustaCompletaInicialProcTests.Create(
    'TestarCustaInicialProcesso', STRING_INDEFINIDO));
end.


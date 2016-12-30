unit ufpgConsProcessoCargaSuitTests;

interface

uses
  TestFramework, ufpgConsProcessoCargaTests, ufpgCadProcessoTests,
  ufpgMaterializaProcessoTests, usajConstante, ufpgRemessaTests, ufpgCadMovimentacaoUnitariaTests;

implementation

const
  CS_CAMINHO_TESTE = 'Visualizar o relatório de processos em carga por dias em carga';

initialization
  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'ProcessoConsultaCarga'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessoTests.Create(
    'TestarMaterializaProcesso', 'TestarMaterializaProcessoForo90'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgRemessaTests.Create('TestarRemessaCarga',
    'TestarRemessaCargaConsulta'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
    'TestarCadastrarMovUnitaria', 'TestarCadastrarMovUnitariaConsCarga'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgRemessaTests.Create('TestarRemessaCarga',
    'TestarRemessaCargaConsultaJuiz'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgConsProcessoCargaTests.Create(
    'TestarConsProcessoCarga', STRING_INDEFINIDO, 1, True));
end.


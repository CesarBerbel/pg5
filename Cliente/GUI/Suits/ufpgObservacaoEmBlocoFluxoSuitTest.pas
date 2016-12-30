unit ufpgObservacaoEmBlocoFluxoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgVisualizaFluxoTrabalhoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Observação em bloco';

initialization
  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'TestarObservacaoEmBlocoFluxo_1_4_6_1', 3));

  RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
    'TestarFluxoTrabalho', 'TestarObservacaoEmBlocoFluxo_1_4_6', 1, True));

end.


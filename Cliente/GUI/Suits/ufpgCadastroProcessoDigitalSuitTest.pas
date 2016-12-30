unit ufpgCadastroProcessoDigitalSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgVisualizaFluxoTrabalhoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro de Processo Digital';

initialization

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'TestarCadastroProcessoDigital1_1_14'));


  RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
    'TestarFluxoTrabalho', 'TestarCadastroProcessoDigital1_1_14', 1, True));

end.


unit ufpgCadAPensamentoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCadApensamentoTests, ufpgConstanteGUITests,
  ufpgVariaveisTestesGUI;

implementation

uses
  usajConstante;

const
  CS_CAMINHO_TESTE = 'Apensamento de Processos';

initialization
  //Teste APENSAMENTO e DESAPENSAMENTO de processo
  if gsCliente = CS_CLIENTE_PG5_TJSC then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico', 2))
  else
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalDirecionada', 2));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadApensamentoTests.Create('TestarApensarProcesso',
    STRING_INDEFINIDO, 1, True));
end.


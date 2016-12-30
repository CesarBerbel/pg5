unit ufpgConsultaProcessoSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgConsProcAvancadaTests;

implementation

const
  CS_CAMINHO_TESTE = 'Consulta Avançada de Processo';

initialization
  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    CS_PROCESSO_CIVIL_GENERICO_DIRECIONADA));

  //  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
  //    CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

  RegisterTest(CS_CAMINHO_TESTE, TffpgConsProcAvancadaTests.Create(
    'TestarConsultaProcessoAvancadaNomeCompleto', STRING_INDEFINIDO));

  RegisterTest(CS_CAMINHO_TESTE, TffpgConsProcAvancadaTests.Create(
    'TestarConsultaProcessoAvancadaNomeParcial', STRING_INDEFINIDO, 1, True));
end.


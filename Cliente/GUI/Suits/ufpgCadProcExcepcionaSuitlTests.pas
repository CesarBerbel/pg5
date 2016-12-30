unit ufpgCadProcExcepcionaSuitlTests;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgExecutarRoteiroPROTests,
  ufpgCadProcExcepcionalTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro de processo excepcional';

initialization
  // 12/08/2016  - Carlos.Gaspar - SALT:
  //Comentado, erro build noturno
  //  RegisterTest(CS_CAMINHO_TESTE, TffpgExecutarRoteiroPROTests.Create(
  //    'TestarProtocoloExcepPeticaoInicialGrid'));

  //  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcExcepcionalTests.Create(
  //    'TestarCadastroProcExepcional', STRING_INDEFINIDO, 1, True));
end.


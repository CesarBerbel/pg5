unit ufpgCadRecadoSuitTest;

interface

uses
  TestFramework, usajCadRecadoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  usajConsRecadoRPDevTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastrar Recado e Consultar';

initialization
  if gsCliente <> CS_CLIENTE_PG5_TJMS then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TfsajCadRecadoTests.Create('TestarCadastroDeRecado',
      STRING_INDEFINIDO));

    RegisterTest(CS_CAMINHO_TESTE, TfsajConsRecadoRPDevTests.Create('TestarConsultarRecado',
      STRING_INDEFINIDO, 1, True));
  end;
end.


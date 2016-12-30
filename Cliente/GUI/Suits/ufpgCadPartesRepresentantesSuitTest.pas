unit ufpgCadPartesRepresentantesSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgCadParteRepresTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastrar de Partes e Representantes';

initialization
  if gsCliente <> CS_CLIENTE_PG5_TJMS then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'))
  else
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_SORTEIO));


  RegisterTest(CS_CAMINHO_TESTE, TffpgCadParteRepresTests.Create(
    'TestarCadastroPartesRepresentantes', 'TestarCadastroPartesRepresentantes', 1, True));

end.


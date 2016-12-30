unit ufpgCadastroPendenciaPrazoSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgCadPendenciaPrazoTests, ufpgConsProcBasicaTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro de Pendencia Prazo';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO))
  else
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_SORTEIO));

  RegisterTest(CS_CAMINHO_TESTE, TffpgConsProcBasicaTests.Create(
    'TestarConsultaBasicaProcessso', 'TestarConsultaBasicaProcessso'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadPendenciaPrazoTests.Create(
    'TestarCadastroPendenciaPrazo', 'TestarCadastroPendenciaPrazo1_1_24', 1, True));
end.


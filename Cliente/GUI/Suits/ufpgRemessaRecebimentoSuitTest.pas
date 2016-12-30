unit ufpgRemessaRecebimentoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgRemessaTests, ufpgMaterializaProcessoTests,
  ufpgRecebimentoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCancelamentoTests;

const
  CS_CAMINHO_TESTE = 'Testar o fluxo de carga de 7 processos';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    //Fazer remessa e recebimento de 7 processos
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO, 7));

    RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessoTests.Create(
      'TestarMaterializaProcesso', '', 7));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRemessaTests.Create('TestarRemessaCarga',
      'TestarRemessa7processos'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRecebimentoTests.Create(
      'TestarConsultarLoteParaReceber', ''));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCancelamentoTests.Create('TestarRealizarCancelamento',
      'TestarRealizarCancelamentoAntesReceber'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRemessaTests.Create('TestarRemessaCarga',
      'TestarRemessa7processos'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRecebimentoTests.Create('TestarReceberRemessa', ''));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCancelamentoTests.Create('TestarRealizarCancelamento',
      '', 1, True));
  end;
end.


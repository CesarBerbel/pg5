unit ufpgConsultaProcessoApensosLinksSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgCadApensamentoTests, ufpgConsProcBasicaTests, usajConstante;

implementation

const
  CS_CAMINHO_TESTE = 'Consultar um processo e seus apensos utilizando os links de navegação';

initialization
  if gsCliente = 'erro' then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoSimples', 2));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadApensamentoTests.Create('TestarApensarProcesso',
      STRING_INDEFINIDO));

    RegisterTest(CS_CAMINHO_TESTE, TffpgConsProcBasicaTests.Create(
      'TestarConsultaProcessoApensos', 'TestarConsultaProcessoApensosLinks_1_12_7', 1, True));
  end;
end.


unit ufpgCadProcessoDependeciaSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests;

const
  CS_CAMINHO_TESTE = 'Cadastro Processo Dependencia';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create(
      'TestarCadastroProcessoDependencia', CS_PROCESSO_PENAL_GENERICO_DEPENDENCIA, 1, True));
  end;
end.


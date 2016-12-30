unit ufpgVincUsuProcSigilosoSuitTests;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgVincUsuProcSigilosoTests, ufpgVariaveisTestesGUI,
  ufpgConstanteGUITests;

implementation

const
  CS_CAMINHO_TESTE = 'Vincular usu�rio ao processo com s�gilo absoluto';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalSigiloAbsoluto'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVincUsuProcSigilosoTests.Create(
      'TestarVincularUsuario', 'VincularUsuarioProcessoSig', 1, True));
  end;
end.


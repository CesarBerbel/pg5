unit ufpgVerificaFiltroForoSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgVisualizaFluxoTrabalhoTests;

const
  CS_CAMINHO_TESTE = 'Verificar filtro Foro para usu�rio com permiss�o';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'TestarFiltroForo', 1, True));
  end;
end.


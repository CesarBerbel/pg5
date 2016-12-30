unit ufpgConsProcBasicaTests;

interface

uses
  ufpgConsProcBasica, ufpgGUITestCase, ufpgDataModelTests, ufpgConsProcBasicaModelTests;

type
  TffpgConsProcBasicaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConsProcBasica;
    FoDados: TffpgConsProcBasicaModelTests;
    procedure ConsultaBasicaPorProcesso;
    procedure PreencherDadosConsulta;
    function ChecarResultadoPesquisa: boolean;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarConsultaBasicaProcessso;
    procedure TestarConsultaProcessoApensos;

  end;

implementation

{ TffpgConsProcBasicaTests }

uses
  uspInterface, ufpgFuncoesGuiTestes, ufpgConstanteGuiTests, Classes, SysUtils,
  Forms, ufpgVariaveisTestesGUI;

function TffpgConsProcBasicaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsProcBasicaModelTests;
end;

procedure TffpgConsProcBasicaTests.TestarConsultaBasicaProcessso;
begin
  ExecutarRoteiroTestes(ConsultaBasicaPorProcesso);
end;

procedure TffpgConsProcBasicaTests.TestarConsultaProcessoApensos;
begin
  ExecutarRoteiroTestes(ConsultaBasicaPorProcesso);
end;

procedure TffpgConsProcBasicaTests.ConsultaBasicaPorProcesso;
begin
  AbrirTela;
  FoTela := TffpgConsProcBasica(spTela);
  FoDados := TffpgConsProcBasicaModelTests(spDataModelTests);

  PreencherDadosConsulta;
  check(ChecarResultadoPesquisa, 'Processo ' + FoDados.fpgNuProcesso +
    ' não foi encontrado na pesquisa');

  FecharTela;
end;


procedure TffpgConsProcBasicaTests.PreencherDadosConsulta;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;

  checkFalse(FoDados.fpgNuProcesso = STRING_INDEFINIDO, 'Número de processo não encontrado');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
end;

function TffpgConsProcBasicaTests.ChecarResultadoPesquisa: boolean;
var
  aFile: TStringList;
  sNuProcFormatado: string;
begin
  FoTela.pcPesquisa.ActivePage := FoTela.tsResultado;
  sNuProcFormatado := FoTela.dfNuProcesso.PegaTextoMascarado;
  FoTela.pcResultado.ActivePage := FoTela.tsDadosProcesso;
  aFile := TStringList.Create;
  try
    aFile.LoadFromFile(CS_PASTA_CPOPG5 + gsCDProcesso + '.htm');

    result := Pos(sNuProcFormatado, aFile.Text) <> 0;
  finally
    aFile.Free;
  end;
end;

end.


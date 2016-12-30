//29/04/2016 - Shirleano.Junior - Task: 43061
// Refatorado.
unit ufpgRelCalcCustaGrjReemissaoTests;

interface

uses
  uccp5RelCalcCustaGrjReemissao, ufpgGUITestCase, ufpgRelCalcCustaGrjReemissaoModelTests,
  TestFrameWork, ufpgDataModelTests;

type
  TffpgRelCalcCustaGrjReemissaoTests = class(TfpgGUITestCase)
  private
    procedure GuiaReemissao;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarGuiaReemissao;
  end;

implementation

procedure TffpgRelCalcCustaGrjReemissaoTests.GuiaReemissao;
begin
  AbrirEFecharTela;
end;

function TffpgRelCalcCustaGrjReemissaoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRelCalcCustaGrjReemissaoModelTests;
end;


procedure TffpgRelCalcCustaGrjReemissaoTests.TestarGuiaReemissao;
begin
  ExecutarRoteiroTestes(GuiaReemissao);
end;

end.


//28/04/2016 - Shirleano.Junior - Task: 43059
//Refatorado.
unit ufpgCalcCustaCompletaComplementarProcTests;

interface

uses
  ufpgCalcCustaCompletaComplementarProc, ufpgGUITestCase,
  ufpgCalcCustaCompletaComplementarProcModelTests, TestFrameWork, ufpgDataModelTests;


type
  TffpgCalcCustaCompletaComplementarProcTests = class(TfpgGUITestCase)
  private
    procedure CustaCompletaComplementar;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCustaCompletaComplementar;
  end;

implementation


procedure TffpgCalcCustaCompletaComplementarProcTests.CustaCompletaComplementar;
begin
  AbrirEFecharTela;
end;

function TffpgCalcCustaCompletaComplementarProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCalcCustaCompletaComplementarProcModelTests;
end;

procedure TffpgCalcCustaCompletaComplementarProcTests.TestarCustaCompletaComplementar;
begin
  ExecutarRoteiroTestes(CustaCompletaComplementar);
end;

end.


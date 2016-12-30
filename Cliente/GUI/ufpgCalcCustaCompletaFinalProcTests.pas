unit ufpgCalcCustaCompletaFinalProcTests;

interface

uses
  ufpgCalcCustaCompletaFinalProc, ufpgGUITestCase, ufpgCalcCustaCompletaFinalProcModelTests,
  TestFrameWork, ufpgDataModelTests;


type
  TffpgCalcCustaCompletaFinalProcTests = class(TfpgGUITestCase)
  private
    procedure CustasFinais;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCustasFinais;
  end;

implementation

procedure TffpgCalcCustaCompletaFinalProcTests.CustasFinais;
begin
  AbrirEFecharTela;
end;

function TffpgCalcCustaCompletaFinalProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCalcCustaCompletaFinalProcModelTests;
end;

procedure TffpgCalcCustaCompletaFinalProcTests.TestarCustasFinais;
begin
  ExecutarRoteiroTestes(CustasFinais);
end;

end.


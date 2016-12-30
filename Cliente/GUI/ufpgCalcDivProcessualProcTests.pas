unit ufpgCalcDivProcessualProcTests;

interface

uses
  uccp5CalcDivProcessualProc, ufpgGUITestCase, ufpgCalcDivProcessualProcModelTests,
  TestFrameWork, ufpgDataModelTests;

type
  TffpgCalcDivProcessualProcTests = class(TfpgGUITestCase)
  private
    procedure CalculoProcessualProcesso;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCalculoProcessualProcesso;
  end;

implementation

procedure TffpgCalcDivProcessualProcTests.CalculoProcessualProcesso;
begin
  AbrirEFecharTela;
end;

function TffpgCalcDivProcessualProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCalcDivProcessualProcModelTests;
end;

procedure TffpgCalcDivProcessualProcTests.TestarCalculoProcessualProcesso;
begin
  ExecutarRoteiroTestes(CalculoProcessualProcesso);
end;

end.
  

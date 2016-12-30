unit ufpgCalcCustaCompletaExcepcionalProcTests;

interface

uses
  TestFrameWork, ufpgGUITestCase, ufpgCalcCustaCompletaExcepcionalProc;


type
  TffpgCalcCustaCompletaExcepcionalProcTests = class(TfpgGUITestCase)
  private
    procedure CustaCompletaExcepcional;
  published
    procedure TestarCustaCompletaExcepcional;
  end;

implementation

procedure TffpgCalcCustaCompletaExcepcionalProcTests.CustaCompletaExcepcional;
begin
  AbrirEFecharTela;
end;

procedure TffpgCalcCustaCompletaExcepcionalProcTests.TestarCustaCompletaExcepcional;
begin
  ExecutarRoteiroTestes(CustaCompletaExcepcional);
end;

end.


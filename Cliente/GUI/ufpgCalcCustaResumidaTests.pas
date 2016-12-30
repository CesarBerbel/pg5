unit ufpgCalcCustaResumidaTests;

interface

uses
  TestFrameWork, ufpgCalcCustaResumida, ufpgGUITestCase;


type
  TffpgCalcCustaResumidaTests = class(TfpgGUITestCase)
  private
    procedure CalcCustaResumida;
  published
    procedure TestarCalcCustaResumida;
  end;

implementation

{ TffpgCalcCustaResumidaTests }

procedure TffpgCalcCustaResumidaTests.CalcCustaResumida;
begin
  AbrirEFecharTela;
end;

procedure TffpgCalcCustaResumidaTests.TestarCalcCustaResumida;
begin
  ExecutarRoteiroTestes(CalcCustaResumida);
end;

end.


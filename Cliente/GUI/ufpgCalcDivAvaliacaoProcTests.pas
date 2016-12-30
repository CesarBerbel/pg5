unit ufpgCalcDivAvaliacaoProcTests;

interface

uses
  uccp5CalcDivAvaliacaoProc, ufpgGUITestCase, ufpgCalcDivAvaliacaoProcModelTests,
  TestFrameWork, ufpgDataModelTests;


type
  TffpgCalcDivAvaliacaoProcTests = class(TfpgGUITestCase)
  private
    procedure AvaliacaoDeBensProcesso;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarAvaliacaoDeBensProcesso;
  end;

implementation

function TffpgCalcDivAvaliacaoProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCalcDivAvaliacaoProcModelTests;
end;

procedure TffpgCalcDivAvaliacaoProcTests.AvaliacaoDeBensProcesso;
begin
  AbrirEFecharTela;
end;

procedure TffpgCalcDivAvaliacaoProcTests.TestarAvaliacaoDeBensProcesso;
begin
  ExecutarRoteiroTestes(AvaliacaoDeBensProcesso);
end;

end.


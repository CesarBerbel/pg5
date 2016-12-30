//28/04/2016 - Shirleano.Junior - Task: 43061
//Refatorado.
unit ufpgCalcDivSalarioIndenizacaoProcTests;

interface

uses
  ufpgCalcDivSalarioIndenizacaoProc, ufpgGUITestCase, ufpgCalcDivSalarioIndenizacaoProcModelTests,
  TestFrameWork, ufpgDataModelTests;

type
  TffpgCalcDivSalarioIndenizacaoProcTests = class(TfpgGUITestCase)
  private
    procedure CalculoDeIndenizacaoProcesso;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCalculoDeIndenizacaoProcesso;
  end;

implementation

procedure TffpgCalcDivSalarioIndenizacaoProcTests.CalculoDeIndenizacaoProcesso;
begin
  AbrirEFecharTela;
end;

function TffpgCalcDivSalarioIndenizacaoProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCalcDivSalarioIndenizacaoProcModelTests;
end;

procedure TffpgCalcDivSalarioIndenizacaoProcTests.TestarCalculoDeIndenizacaoProcesso;
begin
  ExecutarRoteiroTestes(CalculoDeIndenizacaoProcesso);
end;

end.


unit ufpgCalcDivAtualizacaoProcTests;

interface

uses
  uccp5CalcDivAtualizacaoProc, ufpgGUITestCase, ufpgCalcDivAtualizacaoProcModelTests, ufpgDataModelTests;


type
  TffpgCalcDivAtualizacaoProcTests = class(TfpgGUITestCase)
  private
    procedure AtualizacaoMonetariaProcesso;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarAtualizacaoMonetariaProcesso;
  end;

implementation

procedure TffpgCalcDivAtualizacaoProcTests.AtualizacaoMonetariaProcesso;
begin
  AbrirEFecharTela;
end;

function TffpgCalcDivAtualizacaoProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCalcDivAtualizacaoProcModelTests;
end;

procedure TffpgCalcDivAtualizacaoProcTests.TestarAtualizacaoMonetariaProcesso;
begin
  ExecutarRoteiroTestes(AtualizacaoMonetariaProcesso);
end;

end.
  

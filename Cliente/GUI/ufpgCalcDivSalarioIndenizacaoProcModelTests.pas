unit ufpgCalcDivSalarioIndenizacaoProcModelTests;

interface

uses
  uccp5CalcDivSalarioIndenizacaoProc, ufpgModelTests, ADODB;

type
  TffpgCalcDivSalarioIndenizacaoProcModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
  protected

  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
  published
  end;

implementation

end.
  

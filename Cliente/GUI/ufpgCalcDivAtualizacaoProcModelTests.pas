unit ufpgCalcDivAtualizacaoProcModelTests;

interface

uses
  uccp5CalcDivAtualizacaoProc, ufpgModelTests, ADODB;

type
  TffpgCalcDivAtualizacaoProcModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
  published
  end;

implementation

end.


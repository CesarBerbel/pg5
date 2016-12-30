unit ufpgCalcDivProcessualProcModelTests;

interface

uses
  uccp5CalcDivProcessualProc, ufpgModelTests, ADODB;

type
  TffpgCalcDivProcessualProcModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
  published
  end;

implementation

end.
  

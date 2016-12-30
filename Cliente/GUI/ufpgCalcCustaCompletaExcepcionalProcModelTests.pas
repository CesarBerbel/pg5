unit ufpgCalcCustaCompletaExcepcionalProcModelTests;

interface

uses
  uccp5CalcCustaCompletaExcepcionalProc, ufpgModelTests, ADODB;

type
  TffpgCalcCustaCompletaExcepcionalProcModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;

  public
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  published
  end;

implementation

end.
  

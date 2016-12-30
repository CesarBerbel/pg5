unit ufpgCalcCustaCompletaFinalProcModelTests;

interface

uses
  uccp5CalcCustaCompletaFinalProc, ufpgModelTests, ADODB;

type
  TffpgCalcCustaCompletaFinalProcModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
  protected

  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
  published
  end;

implementation

end.
  

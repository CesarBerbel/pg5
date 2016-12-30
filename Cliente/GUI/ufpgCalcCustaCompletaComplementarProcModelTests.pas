unit ufpgCalcCustaCompletaComplementarProcModelTests;

interface

uses
  ufpgCalcCustaCompletaComplementarProc, ufpgModelTests, ADODB;

type
  TffpgCalcCustaCompletaComplementarProcModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
  protected

  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
  published
  end;

implementation

end.
  

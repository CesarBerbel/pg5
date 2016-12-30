unit ufpgCalcCustaResumidaModelTests;

interface

uses
  uccp5CalcCustaResumida, ufpgModelTests, ADODB;

type
  TffpgCalcCustaResumidaModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
  protected

  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
  published
  end;

implementation

end.


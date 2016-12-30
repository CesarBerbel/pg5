unit ufpgRelCalcCustaGrjReemissaoModelTests;

interface

uses
  uccp5RelCalcCustaGrjReemissao, ufpgModelTests, ADODB;

type
  TffpgRelCalcCustaGrjReemissaoModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
  published
  end;

implementation

end.
  
